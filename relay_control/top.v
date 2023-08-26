//Author: Ryan Brady
//Purpose: Program the Basys3 to act as the relay control logic for the IoT Power Relay II.

`timescale 1ns / 1ps

module trigger2(
    input CLK100MHZ,   //system clock
    input reset,       //reset button
    input vauxp6,      //positive input for XADC channel 6
    input vauxn6,      //negative input for XADC channel 6
    input vauxp7,      //positive input for XADC channel 7
    input vauxn7,      //negative input for XADC channel 7
    input vauxp15,     //positive input for XADC channel 15
    input vauxn15,     //negative input for XADC channel 15
    input vauxp14,     //positive input for XADC channel 14
    input vauxn14,     //negative input for XADC channel 14
    input vp_in,       //system positive
    input vn_in,       //system negative
    input [1:0] sw,    //switches to control which input is being read
    input override,    //override switch to trigger relay (for example, if pumping down vacuum system
    output reg [15:0] led,  //LEDs to display input Voltage level
    output reg trigger,     //output positive end of 3.3V signal
    output [3:0] an,        //7-segment control
    output dp,              //7-segment control
    output [6:0] seg        //7-segment control
);

    wire enable;            //enable XADC
    wire ready;             //signal to continuously undergo ADC
    wire [15:0] data;       //digitized data from ADC
    reg [6:0] Address_in;   //address corresponding to which voltage input port is being used
	
	//secen segment controller signals
    reg [32:0] count;
    localparam S_IDLE = 0;
    localparam S_FRAME_WAIT = 1;
    localparam S_CONVERSION = 2;
    reg [1:0] state = S_IDLE;
    reg [15:0] sseg_data;
	
	//binary to decimal converter signals
    reg b2d_start;
    reg [15:0] b2d_din;
    wire [15:0] b2d_dout;
    wire b2d_done;

    //xadc instantiation, connect the eoc_out .den_in to get continuous conversion
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
    
    //led visual - the greater the input voltage, the more LEDs that are on              
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
    
    //binary to decimal conversion
    always @ (posedge(CLK100MHZ)) begin
        case (state)
        S_IDLE: begin
            state <= S_FRAME_WAIT;
            count <= 'b0;
        end
        S_FRAME_WAIT: begin
            if (count >= 10000000) begin
                if (data > 16'hFFD0) begin
                    sseg_data <= 16'h1000;
                    state <= S_IDLE;
                end else begin
                    b2d_start <= 1'b1;
                    b2d_din <= data;
                    state <= S_CONVERSION;
                end
            end else
                count <= count + 1'b1;
        end
        S_CONVERSION: begin
            b2d_start <= 1'b0;
            if (b2d_done == 1'b1) begin
                sseg_data <= b2d_dout;
                state <= S_IDLE;
            end
        end
        endcase
    end
    
    bin2dec m_b2d (
        .clk(CLK100MHZ),
        .start(b2d_start),
        .din(b2d_din),
        .done(b2d_done),
        .dout(b2d_dout)
    );


   //Switch logic to control which input port is being ADC sampled
    always @(posedge(CLK100MHZ)) begin
        case(sw)
        0: Address_in <= 8'h16;
        1: Address_in <= 8'h17;
        2: Address_in <= 8'h1e;
        3: Address_in <= 8'h1f;
        endcase
    end
    
    DigitToSeg segment1(
        .in1(sseg_data[3:0]),
        .in2(sseg_data[7:4]),
        .in3(sseg_data[11:8]),
        .in4(sseg_data[15:12]),
        .in5(),
        .in6(),
        .in7(),
        .in8(),
        .mclk(CLK100MHZ),
        .an(an),
        .dp(dp),
        .seg(seg)
    );

   //Main logic to control output voltage to power relay
 integer i = 0;

   //if the input voltage is >500mV at any point, and the override switch is not active, do not supply 3.3V output
    always @(posedge CLK100MHZ) begin
    if(led >= 16'b111111111 & ~override) begin
        trigger = 1'b0;
        i = 1;
   //if the input voltage is <500mV or the ovveride switch is active, supply 3.3V output
     end else if (i <= 0 || override) begin
        trigger = 1'b1;

	//if the reset button is pressed and the voltage is <500mV, 3.3V supply is output.
	//An example as to why this portion is needed is if the pump temporarily loses power --> vacuum system rises over 500mTorr --> vacuum suddenly turns back on --> system pumps back down --> valve STILL remains closed to prevent any potential oil splattering or adverse effects.
     end else if (reset) begin
        i = 0;
     end
end


endmodule
