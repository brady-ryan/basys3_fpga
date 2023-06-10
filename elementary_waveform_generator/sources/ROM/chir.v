`timescale 1ns / 1ps

module chirp_wave(
    input wire clk ,
    output wire [7:0] odata
    );

reg [15:0] data;
parameter SIZE = 1000;    
reg [15:0] rom_memory [SIZE-1:0];
integer i;
initial begin
    $readmemh("chirp4.mem", rom_memory); //File with the signal
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

assign odata = data[15:8];

endmodule
