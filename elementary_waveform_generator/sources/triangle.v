`timescale 1ns / 1ps

module triangle_gen (
    input wire clk ,
    output wire [7:0] triangle_data
    );

reg [15:0] triangle;
parameter SIZE = 1024;    
reg [15:0] rom_memory [SIZE-1:0];
integer i;
initial begin
    $readmemh("triangle.mem", rom_memory); //File with the signal
    i = 0;
end    
//At every positive edge of the clock, output a triangle wave sample.
always@(posedge clk)
begin
    triangle = rom_memory[i];
    i = i+ 1;
    if(i == SIZE)
        i = 0;
end

assign triangle_data = triangle[15:8];

endmodule
