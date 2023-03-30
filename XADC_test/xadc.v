`timescale 1ns/1ps

module XADCdemo(
    input CLK100MHZ,
    input vauxp6,
    input vauxn6,
    input vp_in,
    input vn_in,
    output reg [15:0] LED
);

    wire enable;  
    wire ready;
    wire [15:0] data;   

   //xadc instantiation connect the eoc_out .den_in to get continuous conversion
    xadc_wiz_0  XLXI_7 (
        .daddr_in(8'h16), //addresses can be found in the artix 7 XADC user guide DRP register space
        .dclk_in(CLK100MHZ), 
        .den_in(enable), 
        .di_in(0), 
        .dwe_in(0), 
        .busy_out(), 
        .vauxp6(vauxp6),
        .vauxn6(vauxn6),
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
            1:  LED <= 16'b11;
            2:  LED <= 16'b111;
            3:  LED <= 16'b1111;
            4:  LED <= 16'b11111;
            5:  LED <= 16'b111111;
            6:  LED <= 16'b1111111; 
            7:  LED <= 16'b11111111;
            8:  LED <= 16'b111111111;
            9:  LED <= 16'b1111111111;
            10: LED <= 16'b11111111111;
            11: LED <= 16'b111111111111;
            12: LED <= 16'b1111111111111;
            13: LED <= 16'b11111111111111;
            14: LED <= 16'b111111111111111;
            15: LED <= 16'b1111111111111111;                        
            default: LED <= 16'b1; 
            endcase
        end
    end
    
endmodule 
