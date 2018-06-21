// Student : 0513311 Lo Wen-Huei
module compare(
	input less,
	input equal,
	input [2:0] comp,
	output reg out
);

always @(*) 
begin
	case(comp)
		3'b000: out <= less & ~equal;			// set less than
		3'b001: out <= less | equal;			// set less equal
		3'b010: out <= ~equal;					// set not equal
		3'b011: out <= equal;					// set equal
		3'b111: out <= ~less | equal;			// set greater equal
		3'b110: out <= ~less;					// set greater than
		3'b100: out <= 1'b0;
		default: out <= 1'b0;
	endcase
end

endmodule
