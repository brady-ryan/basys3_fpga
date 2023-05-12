`timescale 1ns / 1ps

module sine_gen2 (
    input wire clk ,
    output wire [7:0] sine_data
    );

reg [15:0] sine;
parameter SIZE = 1024;    
reg [15:0] rom_memory [SIZE-1:0];
integer i;
initial begin
    $readmemh("half_amp.mem", rom_memory); //File with the signal
    i = 0;
end    
//At every positive edge of the clock, output a sine wave sample.
always@(posedge clk)
begin
    sine = rom_memory[i];
    i = i+ 1;
    if(i == SIZE)
        i = 0;
end

assign sine_data = sine[15:8];

endmodule
