// Student : 0513311 Lo Wen-Huei
`timescale 1ns/1ps

module alu(
	input rst_n,         				// negative reset            (input)
	input [32-1:0] src1,          			// 32 bits source 1          (input)
	input	[32-1:0]	src2,   	       	// 32 bits source 2          (input)
	input	[4-1:0]	ALU_control,   			// 4 bits ALU control input  (input)
	input	[3-1:0]	bonus_control, 			// 3 bits bonus control input(input)
	output reg [32-1:0] result,      		// 32 bits result            (output)
	output reg zero,          			// 1 bit when the output is 0, zero must be set (output)
	output reg cout,          			// 1 bit carry out           (output)
	output reg overflow       			// 1 bit overflow            (output)
);

wire set,equal,A_invert,B_invert,sub,alu_overflow,fa_sum31,fa_cout31;
wire [31:0] alu_result;
wire [1:0] op;
wire [31:0] alu_cout;

parameter zc=1'b0;
parameter comp=3'b100;					// let alu_top's result=1'b0 while SET

assign equal = (src1 ^ src2)? 1'b0 : 1'b1;		// bitwise check equality

assign A_invert = (ALU_control == 4'b1100 || ALU_control == 4'b1101)? 1'b1 : 1'b0;															// NOR or NAND

assign B_invert = (ALU_control == 4'b0110 || (ALU_control == 4'b1100 || ALU_control == 4'b1101))? 1'b1 : 1'b0; 					// SUBU or NOR or NAND

assign sub = (ALU_control == 4'b0110 || ALU_control == 4'b0111)? 1'b1 : 1'b0;																	// SUBU or SET

assign op[0] = ALU_control[0];
assign op[1] = ALU_control[1];

					
// alu_top
alu_top ALU_00(  .src1(src1[0]),  .src2(src2[0]), .less(set), .equal(equal), .A_invert(A_invert), .B_invert(B_invert), .cin(sub), .operation(op), .comp(bonus_control), .result(alu_result[0]), .cout(alu_cout[0]));

alu_top ALU_01(  .src1(src1[1]),  .src2(src2[1]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[0]), .operation(op), .comp(comp),  .result(alu_result[1]),  .cout(alu_cout[1]));
alu_top ALU_02(  .src1(src1[2]),  .src2(src2[2]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[1]), .operation(op), .comp(comp),  .result(alu_result[2]),  .cout(alu_cout[2]));
alu_top ALU_03(  .src1(src1[3]),  .src2(src2[3]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[2]), .operation(op), .comp(comp),  .result(alu_result[3]),  .cout(alu_cout[3]));
alu_top ALU_04(  .src1(src1[4]),  .src2(src2[4]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[3]), .operation(op), .comp(comp),  .result(alu_result[4]),  .cout(alu_cout[4]));
alu_top ALU_05(  .src1(src1[5]),  .src2(src2[5]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[4]), .operation(op), .comp(comp),  .result(alu_result[5]),  .cout(alu_cout[5]));

alu_top ALU_06(  .src1(src1[6]),  .src2(src2[6]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[5]), .operation(op), .comp(comp),  .result(alu_result[6]),  .cout(alu_cout[6]));
alu_top ALU_07(  .src1(src1[7]),  .src2(src2[7]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[6]), .operation(op), .comp(comp),  .result(alu_result[7]),  .cout(alu_cout[7]));
alu_top ALU_08(  .src1(src1[8]),  .src2(src2[8]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[7]), .operation(op), .comp(comp),  .result(alu_result[8]),  .cout(alu_cout[8]));
alu_top ALU_09(  .src1(src1[9]),  .src2(src2[9]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[8]), .operation(op), .comp(comp),  .result(alu_result[9]),  .cout(alu_cout[9]));
alu_top ALU_10( .src1(src1[10]), .src2(src2[10]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert),  .cin(alu_cout[9]), .operation(op), .comp(comp), .result(alu_result[10]), .cout(alu_cout[10]));

alu_top ALU_11( .src1(src1[11]), .src2(src2[11]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[10]), .operation(op), .comp(comp), .result(alu_result[11]), .cout(alu_cout[11]));
alu_top ALU_12( .src1(src1[12]), .src2(src2[12]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[11]), .operation(op), .comp(comp), .result(alu_result[12]), .cout(alu_cout[12]));
alu_top ALU_13( .src1(src1[13]), .src2(src2[13]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[12]), .operation(op), .comp(comp), .result(alu_result[13]), .cout(alu_cout[13]));
alu_top ALU_14( .src1(src1[14]), .src2(src2[14]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[13]), .operation(op), .comp(comp), .result(alu_result[14]), .cout(alu_cout[14]));
alu_top ALU_15( .src1(src1[15]), .src2(src2[15]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[14]), .operation(op), .comp(comp), .result(alu_result[15]), .cout(alu_cout[15]));

alu_top ALU_16( .src1(src1[16]), .src2(src2[16]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[15]), .operation(op), .comp(comp), .result(alu_result[16]), .cout(alu_cout[16]));
alu_top ALU_17( .src1(src1[17]), .src2(src2[17]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[16]), .operation(op), .comp(comp), .result(alu_result[17]), .cout(alu_cout[17]));
alu_top ALU_18( .src1(src1[18]), .src2(src2[18]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[17]), .operation(op), .comp(comp), .result(alu_result[18]), .cout(alu_cout[18]));
alu_top ALU_19( .src1(src1[19]), .src2(src2[19]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[18]), .operation(op), .comp(comp), .result(alu_result[19]), .cout(alu_cout[19]));
alu_top ALU_20( .src1(src1[20]), .src2(src2[20]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[19]), .operation(op), .comp(comp), .result(alu_result[20]), .cout(alu_cout[20]));

alu_top ALU_21( .src1(src1[21]), .src2(src2[21]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[20]), .operation(op), .comp(comp), .result(alu_result[21]), .cout(alu_cout[21]));
alu_top ALU_22( .src1(src1[22]), .src2(src2[22]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[21]), .operation(op), .comp(comp), .result(alu_result[22]), .cout(alu_cout[22]));
alu_top ALU_23( .src1(src1[23]), .src2(src2[23]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[22]), .operation(op), .comp(comp), .result(alu_result[23]), .cout(alu_cout[23]));
alu_top ALU_24( .src1(src1[24]), .src2(src2[24]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[23]), .operation(op), .comp(comp), .result(alu_result[24]), .cout(alu_cout[24]));
alu_top ALU_25( .src1(src1[25]), .src2(src2[25]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[24]), .operation(op), .comp(comp), .result(alu_result[25]), .cout(alu_cout[25]));

alu_top ALU_26( .src1(src1[26]), .src2(src2[26]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[25]), .operation(op), .comp(comp), .result(alu_result[26]), .cout(alu_cout[26]));
alu_top ALU_27( .src1(src1[27]), .src2(src2[27]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[26]), .operation(op), .comp(comp), .result(alu_result[27]), .cout(alu_cout[27]));
alu_top ALU_28( .src1(src1[28]), .src2(src2[28]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[27]), .operation(op), .comp(comp), .result(alu_result[28]), .cout(alu_cout[28]));
alu_top ALU_29( .src1(src1[29]), .src2(src2[29]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[28]), .operation(op), .comp(comp), .result(alu_result[29]), .cout(alu_cout[29]));
alu_top ALU_30( .src1(src1[30]), .src2(src2[30]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[29]), .operation(op), .comp(comp), .result(alu_result[30]), .cout(alu_cout[30]));

// alu_bottom
alu_bottom ALU_31( .src1(src1[31]), .src2(src2[31]), .less(zc), .equal(zc), .A_invert(A_invert), .B_invert(B_invert), .cin(alu_cout[30]), .operation(op), .comp(comp), .result(alu_result[31]), .overflow(alu_overflow), .cout(alu_cout[31]));


assign alu_overflow = (alu_cout[31] == 1)? 1'b1 : 1'b0;

full_adder fa1( .a(src1[31] ^ A_invert), .b(src2[31] ^ B_invert), .cin(alu_cout[30]), .sum(fa_sum31), .cout(fa_cout31));

assign set = (op == 2'b11)? fa_cout31 : 1'b0;												// SET

always@(*)
begin
	if(rst_n == 1)
	begin
		result <= alu_result;
		zero <= (result == 0)? 1'b1 : 1'b0;
		cout <= (ALU_control == 4'b0010 || ALU_control == 4'b0110)? alu_cout[31] : 1'b0;	// ADD or SUBU
		overflow <= alu_overflow;
	end
	else 
	begin 
		result <= 1'b0;
		zero <= 1'b0; 
		cout <= 1'b0;
		overflow <= 1'b0;
	end
end

endmodule
