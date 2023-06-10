`timescale 1ns / 1ps

module decay_gen(
    input wire clk ,
    output wire [7:0] decay_data
    );

reg [15:0] data;
parameter SIZE = 3;    
reg [15:0] rom_memory [SIZE-1:0];
integer i;
initial begin
    $readmemh("33mhz.mem", rom_memory); //File with the signal
    i = 0;
end    
//At every positive edge of the clock, output a sine wave sample.
always@(posedge clk)
begin
    data = rom_memory[i];
    i = i+ 1;
    if(i == SIZE)
        i = 0;
end

assign decay_data = data[15:8];

endmodule
