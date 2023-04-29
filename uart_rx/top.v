`timescale 1ns / 1ps


module top(
    input clk,         // input clock
    input reset,       // input reset 
    input RxD,         // input receiving data line
    output [7:0] LED // LEDS for 8 bits data
    );
    
    
  receiver receive(
    .clk(clk),
    .reset(reset),
    .RxD(RxD),
    .RxData(LED)
    );
    
endmodule
