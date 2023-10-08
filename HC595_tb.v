`timescale 1ns/1ns
`define clk_perios 20

module HC595_tb;

reg clk;
reg rst_n;
reg[7:0] dat;
wire SHCP;
wire STCP;
wire DS;

HC595 HC595(
				.clk(clk),
				.rst_n(rst_n),
				.DS(DS),
				.SHCP(SHCP),
				.STCP(STCP),
				.dat(dat)
				);
				
initial clk = 0;
always#(`clk_perios/2) clk = ~clk;

initial begin
	rst_n = 0;
	dat = 0;
	#10_000;rst_n = 1;
	dat = 8'hab;
	#1_000_000;
	dat = 8'h12;
	#1_000_000;
	$stop;
end

endmodule 
	