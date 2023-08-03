module decoder_3_8 ( 
    input [2:0] I,
    output [3:0] an,
    output dp	 
);

assign an[0] = ~(~I[2] & ~I[1] & ~I[0]);
assign an[1] = ~(~I[2] & ~I[1] & I[0]);

assign an[2] = ~(~I[2] & I[1] & ~I[0]);
assign an[3] = ~(~I[2] & I[1] & I[0]);

//assign an[4] = ~(I[2] & ~I[1] & ~I[0]);
//assign an[5] = ~(I[2] & ~I[1] & I[0]);
//assign an[6] = ~(I[2] & I[1] & ~I[0]);
//assign an[7] = ~(I[2] & I[1] & I[0]);

//decimal place
assign dp = ~(~I[2] & I[1] & I[0]);

endmodule
