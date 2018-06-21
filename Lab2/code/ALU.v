//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1.1
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 4 / 22
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
   src1_i,
	src2_i,
	ctrl_i,
	shamt,
	result_o,
	zero_o
);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [4-1:0]   ctrl_i;
input  [5-1:0]   shamt;

output [32-1:0]  result_o;
output           zero_o;

//Internal signals
reg    		[32-1:0] result_o;
wire             		zero_o;
wire signed [32-1:0] signed_src1,signed_src2;
wire 			[32-1:0] unsigned_src1,unsigned_src2;

//Parameter
// R-type
parameter AND   = 4'd0;
parameter OR    = 4'd1;
parameter ADD   = 4'd2;
parameter SUB   = 4'd3;
parameter SLT   = 4'd4;
parameter SRA   = 4'd5;
parameter SRAV  = 4'd6;

// I-type
parameter BEQ   = 4'd7;
parameter BNE   = 4'd8;
parameter ADDI  = 4'd9;
parameter STLIU = 4'd10;
parameter ORI   = 4'd11;
parameter LUI   = 4'd12;

parameter dft   = 4'bxxxx;

//Main function
assign zero_o = (result_o == 0);
assign unsigned_src1 = src1_i;
assign unsigned_src2 = src2_i;
assign signed_src1 = src1_i;
assign signed_src2 = src2_i;

always@(*)
begin
	case(ctrl_i)
		AND  : result_o <= src1_i & src2_i; 
		OR   : result_o <= src1_i | src2_i;
		ADD  : result_o <= unsigned_src1 + unsigned_src2;
		SUB  : result_o <= unsigned_src1 - unsigned_src2;
		SLT  : result_o <= (signed_src1 < signed_src2);
		SRA  : result_o <= signed_src2 >>> shamt;
		SRAV : result_o <= signed_src2 >>> signed_src1;
		
		BEQ  : result_o <= ((src1_i ^ src2_i) == 32'b0)? 32'b0 : 32'b1;
		BNE  : result_o <= ((src1_i ^ src2_i) != 32'b0)? 32'b0 : 32'b1;
		ADDI : result_o <= signed_src1 + signed_src2; 
		STLIU: result_o <= (unsigned_src1 < unsigned_src2);
		ORI  : result_o <= src1_i | { 16'b0, src2_i[15:0]};
		LUI  : result_o <= { src2_i[15:0], 16'b0};
	endcase
end
endmodule
