//Subject:     CO project 2 - Decoder**
//--------------------------------------------------------------------------------
//Version:     1.2
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 4 / 22
//--------------------------------------------------------------------------------
//Description: decode the instrction's opcode and control other segments
//--------------------------------------------------------------------------------

module Decoder(
   instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
);
     
//I/O ports
input 	  [6-1:0] instr_op_i;

output reg [3-1:0] ALU_op_o;
output reg         ALUSrc_o;
output reg         RegWrite_o;
output reg         RegDst_o;
output reg         Branch_o;

//Parameter

//Main function
always@(*)
begin
	case(instr_op_i)
		// ALU_op_o defined?
		6'd00: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b000,4'b0110}; 
		// ADDU,SUBU,AND,OR,SLT,SRA(Shift right arith),SRAV(Shift right var)
		
		6'd04: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b001,4'b0001}; 
		// BEQ
		
		6'd05: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b010,4'b0001}; 
		// BNE 
		
		6'd08: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b011,4'b1100}; 
		// ADDI
		
		6'd11: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b100,4'b1100}; 
		// STLIU*
		
		6'd13: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b101,4'b1100}; 
		// ORI
		
		6'd15: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'b110,4'b1100}; 
		// LUI(load upper immediate)*
		
		default: {ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o} <= {3'bxxx,4'bxxxx};
	endcase
end

endmodule





                    
                    