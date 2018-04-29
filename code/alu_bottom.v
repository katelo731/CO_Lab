// Student : 0513311 Lo Wen-Huei
`timescale 1ns/1ps

module alu_bottom(
	input src1,       			// 1 bit source 1 (input)
	input src2,       			// 1 bit source 2 (input)
	input less,       			// 1 bit less     (input)
	input equal,					// 1 bit equal    (input)
	input A_invert,   			// 1 bit A_invert (input)
	input B_invert,  			   // 1 bit B_invert (input)
	input cin,        			// 1 bit carry in (input)
	input [2-1:0] operation,  	// operation      (input)
	input [3-1:0] comp,			// bonus control  (input)
	output reg result,     		// 1 bit result   (output)
	output reg overflow,
	output wire cout	      	// 1 bit carry out(output)
);

wire s1,s2;   						// src1,src2 after invertA,invertB
wire fa_sum,fa_cout;
wire comp_out;

assign s1 = (A_invert == 1'b0)? src1 : (A_invert == 1'b1)? ~src1 : 1'b0;
assign s2 = (B_invert == 1'b0)? src2 : (B_invert == 1'b1)? ~src2 : 1'b0;

full_adder fa1( .a(s1), .b(s2), .cin(cin), .sum(fa_sum), .cout(fa_cout));
compare cmp1( .less(less), .equal(equal), .comp(comp), .out(comp_out));

assign cout = (operation == 2'b10 || operation == 2'b11)? fa_cout : 1'b0;				// ADD or SET	

always@(*)
begin
	case(operation)
		2'b00: result <= s1 & s2; 		// ALU_AND
		2'b01: result <= s1 | s2; 		// ALU_OR
		2'b10: result <= fa_sum; 		// ALU_ADD
		2'b11: result <= 1'b0; 			// ALU_SET is not used here
	default: result <= 1'b0;
	endcase
end
	
always@(*)
begin
    if(operation == 2'b10 || operation == 2'b11)
        case({src1,src2,B_invert,fa_sum})
            4'b0001: overflow <= 1'b1;			// (+v) + (+v) = (-v)
            4'b0111: overflow <= 1'b1;			// (+v) - (-v) = (-v)
            4'b1100: overflow <= 1'b1;			// (-v) + (-v) = (+v)
            4'b1010: overflow <= 1'b1;			// (-v) - (+v) = (+v)
            default: overflow <= 1'b0;			
        endcase
    else 
        overflow <= 1'b0;
end

endmodule
