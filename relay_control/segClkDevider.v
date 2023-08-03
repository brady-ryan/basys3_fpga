module segClkDevider(
input clk,
    input rst,
    output reg clk_div
    );
     
 localparam constantNumber = 10000;
 reg [31:0] count;
 
always @ (posedge(clk), posedge(rst))
begin
    if (rst == 1'b1)
        count <= 32'b0;
    else if (count == constantNumber - 1)
        count <= 32'b0;               
    else
        count <= count + 1;
end

always @ (posedge(clk), posedge(rst))
begin
    if (rst == 1'b1)
        clk_div <= 1'b0;
    else if (count == constantNumber - 1)
        clk_div <= ~clk_div;
    else
        clk_div <= clk_div;
end
endmodule
