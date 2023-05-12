`timescale 1ns / 1ps

module top(
    input clk,
    input btn,
    input send_data,
    input [3:0] switch,
    output TxD  
  );
        
wire clk1;     
wire [7:0] data1;
wire [7:0] data2;
wire [7:0] data3;
reg [7:0] outdata;
        
Clock_divider1 clock1 (
    .clock_in(clk),
    .clock_out(clk1)
);

sine_gen sine1 (
    .clk(clk1),
    .sine_data(data1)
);

sine_gen2 half_amp (
    .clk(clk1),
    .sine_data(data2)
);

triangle_gen triangle (
    .clk(clk1),
    .triangle_data(data3)
);


always @(posedge(clk))begin
    if (switch[0])
        outdata <= data1;
    else if (switch[1])
        outdata <= data2;
    else if (switch[2])
        outdata <= data3;
    else
        outdata <= 0;
   end
 

transmitter T1 (
    .clk(clk),
    .reset(btn),
    .transmit(send_data),
    .data(outdata),
    .TxD(TxD)
);


endmodule
