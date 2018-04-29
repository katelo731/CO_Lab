// Student : 0513311 Lo Wen-Huei
module full_adder(
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

wire carry1,carry2,sum1;

half_adder ha1( .a(a), .b(b) , .sum(sum1) , .cout(carry1));
half_adder ha2( .a(sum1), .b(cin) , .sum(sum) , .cout(carry2));

assign cout = carry1 | carry2;

endmodule
