`timescale 1ns / 1ps

module top(
    input clk,
    input btn,
    input [1:0] freq,
    input send_data,
    input [6:0] switch,
    output reg [5:0] led,
    output reg ledclk,
    output reg [7:0] outdata,
    output TxD  
  );
        
wire clk10hz;
wire clk100hz;   
wire clk1khz;  
reg clk_in;
wire clk1hz;
wire oclk1hz;
wire clk10khz;
wire wizclk;


wire [7:0] data1;
wire [7:0] data2;
wire [7:0] data3;
wire [7:0] data4;
wire [7:0] data5;
wire [7:0] data6;
wire [7:0] data7;

        
        
        
Clock_divider1 clock1 (
    .clock_in(clk),
    .clock_out(clk100hz)
);

Clock_divider2 clock2 (
    .clock_in(clk),
    .clock_out(clk1khz)
);

Clock_divider3 clock3 (
    .clock_in(clk),
    .clock_out(clk1hz)
);

clock_divider4 clock1hz (
    .clock_in(clk),
    .clock_out(oclk1hz)
);

clock_divider5 clock10hz (
    .clock_in(clk),
    .clock_out(clk10hz)
);

clock_divider6 clock10khz (
    .clock_in(clk),
    .clock_out(clk10khz) 
 );


clk_wiz_0 clkr (
    .clk_in1(clk),
    .clk_out1(wizclk)
);

integer f;

initial begin
    f = 0;
end


always @(posedge clk1hz) begin
    if (freq[1])
        f = f + 1;
    else if (freq[0])
        f = f - 1;
    
    if (f > 5)
        f = 5;
    if (f < 0)
        f = 0;
 end
       
always @(posedge clk) begin
    if (f == 0)
        clk_in = oclk1hz;
   else if (f == 1)
        clk_in = clk10hz;
   else if (f == 2)
        clk_in = clk100hz;
   else if (f == 3)
    clk_in = clk1khz;
   else if (f == 4)
    clk_in = clk10khz;
  else if (f == 5)
    clk_in = wizclk;
end

sine_gen sine1 (
    .clk(clk_in),
    .sine_data(data1)
);

sine_gen2 half_amp (
    .clk(clk_in),
    .sine_data(data2)
);

triangle_gen triangle (
    .clk(clk_in),
    .triangle_data(data3)
);

decay_gen decay (
    .clk(clk_in),
    .decay_data(data4)
);

highfreq high (
    .clk(clk_in),
    .odata(data5)
);

chirp_wave chirp (
    .clk(clk_in),
    .odata(data6)
);  

square_wave square (
    .clk(clk_in),
    .odata(data7)
);

integer i;
initial begin
    i = 0;
end


always @(posedge clk1hz) begin
    ledclk <= ~ledclk;
    i = i + 1;
    if (i == 0)
        led[0] <= 1'b1;
    else if (i == 1)
        led[1] = 1'b1;
    else if (i == 2)
        led[2] = 1'b1;
    else if (i == 3)
        led[3] = 1'b1;
    else if (i == 4)
        led[4] = 1'b1;
    else if (i == 5)
        led[5] = 1'b1;
    else
        led[5:0] = 6'b000000;
    if (i == 6)
        i = 0;
end

always @(posedge clk) begin
    if (switch[0])
        outdata <= data1;
    else if (switch[1])
        outdata <= data2;
    else if (switch[2])
        outdata <= data3;
    else if (switch[3])
        outdata <= data4;
    else if (switch[4]) 
        outdata <= data5;
    else if (switch[5])
        outdata <= data6;
       else if (switch[6]) begin
if (i < 1 ) begin
    outdata <= data1;
    end
else if (i >= 1 && i < 2) begin
    outdata <= data2;
    end
else if (i >= 2 && i < 3) begin
    outdata <= data3;
    end
else if (i >= 3 && i < 4) begin
    outdata <= data4;
    end
else if (i >= 4 && i < 5) begin
    outdata <= data5;
    end
else if (i >= 5) begin
    outdata <= data6;
    end
else
    outdata <= 0;
end
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
