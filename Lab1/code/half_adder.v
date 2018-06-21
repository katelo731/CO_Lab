// Student : 0513311 Lo Wen-Huei
module half_adder(
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b;
assign cout = a & b;

endmodule
