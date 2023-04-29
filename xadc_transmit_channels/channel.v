`timescale 1ns / 1ps

module XADCdemo(
    input CLK100MHZ,
    input vauxp6,
    input vauxn6,
    input vauxp7,
    input vauxn7,
    input vauxp15,
    input vauxn15,
    input vauxp14,
    input vauxn14,
    input vp_in,
    input vn_in,
    input [2:0] sw,
    input [1:0] btn,
    output reg [15:0] led,
    output TxD,
    output TxD_debug,
    output transmit_debug,
    output button_debug, 
    output clk_debug
);

    wire enable;  
    wire ready;
    wire [15:0] data;   
    reg [6:0] Address_in;
    wire start_conversion;
    

   //xadc instantiation connect the eoc_out .den_in to get continuous conversion
 xadc_wiz_0  XLXI_7 (
        .daddr_in(Address_in), //addresses can be found in the artix 7 XADC user guide DRP register space
        .dclk_in(CLK100MHZ), 
        .den_in(enable), 
        .di_in(0), 
        .dwe_in(0), 
        .busy_out(),                    
        .vauxp6(vauxp6),
        .vauxn6(vauxn6),
        .vauxp7(vauxp7),
        .vauxn7(vauxn7),
        .vauxp14(vauxp14),
        .vauxn14(vauxn14),
        .vauxp15(vauxp15),
        .vauxn15(vauxn15),
        .vn_in(vn_in), 
        .vp_in(vp_in), 
        .alarm_out(), 
        .do_out(data), 
        //.reset_in(),
        .eoc_out(enable),
        .channel_out(),
        .drdy_out(ready)
    );


always @(posedge(CLK100MHZ)) begin            
        if(ready == 1'b1) begin
            case (data[15:12])
            1:  led <= 16'b11;
            2:  led <= 16'b111;
            3:  led <= 16'b1111;
            4:  led <= 16'b11111;
            5:  led <= 16'b111111;
            6:  led <= 16'b1111111; 
            7:  led <= 16'b11111111;
            8:  led <= 16'b111111111;
            9:  led <= 16'b1111111111;
            10: led <= 16'b11111111111;
            11: led <= 16'b111111111111;
            12: led <= 16'b1111111111111;
            13: led <= 16'b11111111111111;
            14: led <= 16'b111111111111111;
            15: led <= 16'b1111111111111111;                        
            default: led <= 16'b1; 
            endcase
        end
    end

  always @(posedge(CLK100MHZ)) begin
        case(sw)
        0: Address_in <= 8'h16;
        1: Address_in <= 8'h17;
        2: Address_in <= 8'h1e;
        3: Address_in <= 8'h1f;
        endcase
    end

wire [7:0] new_data;

assign new_data = data[15:8];


wire transmits;
assign TxD_debug = TxD;
assign transmit_debug = transmits;
assign button_debug = btn[1];
assign clk_debug = CLK100MHZ;


transmit_debouncing D2 (.clk(CLK100MHZ), .btn1(btn[1]), .transmit(transmits));


// Connect the formatted_data to the transmitter module
transmitter T1 (.clk(CLK100MHZ), .reset(btn[0]), .transmit(transmits), .TxD(TxD), .data(new_data));

endmodule

module transmitter(
input clk, //UART input clock
input reset, // reset signal
input transmit, //btn signal to trigger the UART communication
input [7:0] data, // data transmitted
output reg TxD // Transmitter serial output. TxD will be held high during reset, or when no transmissions aretaking place. 
    );

//internal variables
reg [3:0] bitcounter; //4 bits counter to count up to 10
reg [13:0] counter; //14 bits counter to count the baud rate, counter = clock / baud rate
reg state,nextstate; // initial & next state variable
// 10 bits data needed to be shifted out during transmission.
//The least significant bit is initialized with the binary value “0” (a start bit) A binary value “1” is introduced in the most significant bit 
reg [9:0] rightshiftreg; 
reg shift; //shift signal to start bit shifting in UART
reg load; //load signal to start loading the data into rightshift register and add start and stop bit
reg clear; //clear signal to start reset the bitcounter for UART transmission

//UART transmission logic
always @ (posedge clk) 
begin 
    if (reset) 
	   begin // reset is asserted (reset = 1)
        state <=0; // state is idle (state = 0)
        counter <=0; // counter for baud rate is reset to 0 
        bitcounter <=0; //counter for bit transmission is reset to 0
       end
    else begin
         counter <= counter + 1; //counter for baud rate generator start counting 
            if (counter >= 27) //ADJUST BAUD RATE
               begin 
                  state <= nextstate; //previous state change to next state
                  counter <=0; // reset couter to 0
            	  if (load) rightshiftreg <= {1'b1,data,1'b0}; //load the data if load is asserted
		          if (clear) bitcounter <=0; // reset the bitcounter if clear is asserted
                  if (shift) 
                     begin // if shift is asserted
                        rightshiftreg <= rightshiftreg >> 1; //right shift the data as we transmit the data from lsb
                        bitcounter <= bitcounter + 1; //count the bitcounter
                     end
               end
         end
end 

//state machine

always @ (posedge clk) //trigger by positive edge of clock, 
//always @ (state or bitcounter or transmit)
begin
    load <=0; // set load equal to 0 at the beginning
    shift <=0; // set shift equal to 0 at the beginning
    clear <=0; // set clear equal to 0 at the beginning
    TxD <=1; // set TxD equals to during no transmission
    case (state)
        0: begin // idle state
             if (transmit) begin // assert transmit input
             nextstate <= 1; // Move to transmit state
             load <=1; // set load to 1 to prepare to load the data
             shift <=0; // set shift to 0 so no shift ready yet
             clear <=0; // set clear to 0 to avoid clear any counter
             end 
		else begin // if transmit not asserted
             nextstate <= 0; // next state is back to idle state
             TxD <= 1; 
             end
           end
        1: begin  // transmit state
             if (bitcounter >=10) begin // check if transmission is complete or not. If complete
             nextstate <= 0; // set nextstate back to 0 to idle state
             clear <=1; // set clear to 1 to clear all counters
             end 
		else begin // if transmisssion is not complete 
             nextstate <= 1; // set nextstate to 1 to stay in transmit state
             TxD <= rightshiftreg[0]; // shift the bit to output TxD
             shift <=1; // set shift to 1 to continue shifting the data
             end
           end
         default: nextstate <= 0;                      
    endcase
end


endmodule
module transmit_debouncing #(parameter threshold = 100000)// set parameter thresehold to guage how long button pressed
(
input clk, //clock signal
input btn1, //input buttons for transmit and reset
output reg transmit //transmit signal
    );
    
reg button_ff1 = 0; //button flip-flop for synchronization. Initialize it to 0
reg button_ff2 = 0; //button flip-flop for synchronization. Initialize it to 0
reg [30:0]count = 0; //20 bits count for increment & decrement when button is pressed or released. Initialize it to 0 


// First use two flip-flops to synchronize the button signal the "clk" clock domain

always @(posedge clk)begin
button_ff1 <= btn1;
button_ff2 <= button_ff1;
end

// When the push-button is pushed or released, we increment or decrement the counter
// The counter has to reach threshold before we decide that the push-button state has changed
always @(posedge clk) begin 
 if (button_ff2) //if button_ff2 is 1
 begin
    if (~&count)//if it isn't at the count limit. Make sure won't count up at the limit. First AND all count and then not the AND
        count <= count+1; // when btn pressed, count up
 end else begin
    if (|count)//if count has at least 1 in it. Make sure no subtraction when count is 0 
        count <= count-1; //when btn relesed, count down
 end
 if (count > threshold)//if the count is greater the threshold 
    transmit <= 1; //debounced signal is 1
 else
    transmit <= 0; //debounced signal is 0
end

endmodule
