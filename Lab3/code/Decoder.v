//Subject:     CO project 3 - Decoder**
//--------------------------------------------------------------------------------
//Version:     3.5
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 5 / 21
//--------------------------------------------------------------------------------
//Description: decode the instrction's opcode and control other segments
//--------------------------------------------------------------------------------

module Decoder(
   instr_op_i,
	instr_funct_i,		// JR instr.
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Jump_o,
	MemToReg_o,
	BranchType_o,
	MemRead_o,
	MemWrite_o
);
     
//I/O ports
input 	  [6-1:0] instr_op_i;
input		  [6-1:0] instr_funct_i;

output reg [4-1:0] ALU_op_o;
output reg         ALUSrc_o;
output reg         RegWrite_o;
output reg [2-1:0] RegDst_o;
output reg         Branch_o;

output reg [2-1:0] Jump_o;
output reg [2-1:0] MemToReg_o;
output reg [2-1:0] BranchType_o;
output reg 			 MemRead_o;
output reg			 MemWrite_o;

//Internal Signals

//Main function
always@(*)
begin
	case(instr_op_i)
	
		6'd00: 
		begin
			if( instr_funct_i == 6'h08) // JR instr.
				begin
					ALU_op_o			<= 4'bxxxx;
					ALUSrc_o			<= 1'bx;
					RegWrite_o  	<= 1'b0;
					RegDst_o			<= 2'bxx;
					Branch_o			<= 1'b0;
					
					Jump_o			<= 2'b10;
					MemToReg_o  	<= 2'bxx;
					BranchType_o	<= 2'bxx;
					MemRead_o		<= 1'b0;
					MemWrite_o		<= 1'b0;
				end
			else 								 // R-type
				begin
					ALU_op_o			<= 4'd00;
					ALUSrc_o			<= 1'b0;
					RegWrite_o  	<= 1'b1;
					RegDst_o			<= 2'b01;
					Branch_o			<= 1'b0;
					
					Jump_o			<= 2'b00;
					MemToReg_o  	<= 2'b00;
					BranchType_o	<= 2'bxx;
					MemRead_o		<= 1'b0;
					MemWrite_o		<= 1'b0;
				end
		end
		
		6'd01: // BLTZ
		begin
				ALU_op_o			<= 4'd01;
				ALUSrc_o			<= 1'b0;
				RegWrite_o  	<= 1'b0;
				RegDst_o			<= 2'bxx;
				Branch_o			<= 1'b1;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'bxx;
				BranchType_o	<= 2'b10;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end
		
		6'd02: // JUMP
		begin
				ALU_op_o			<= 4'bxxxx;
				ALUSrc_o			<= 1'bx;
				RegWrite_o  	<= 1'b0;
				RegDst_o			<= 2'bxx;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b01;
				MemToReg_o  	<= 2'bxx;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end
		
		6'd03: // JAL
		begin
				ALU_op_o			<= 4'd02;
				ALUSrc_o			<= 1'bx;
				RegWrite_o  	<= 1'b1;
				RegDst_o			<= 2'b10;
				Branch_o			<= 1'b0; 
				
				Jump_o			<= 2'b01;
				MemToReg_o  	<= 2'b00;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end
		
		6'd04: // BEQ
		begin
				ALU_op_o			<= 4'd03;
				ALUSrc_o			<= 1'b0;
				RegWrite_o  	<= 1'b0;
				RegDst_o			<= 2'bxx;
				Branch_o			<= 1'b1;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'bxx;
				BranchType_o	<= 2'b00;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end
		
		6'd05: // BNE / BNEZ
		begin
				ALU_op_o			<= 4'd04;
				ALUSrc_o			<= 1'bx;
				RegWrite_o  	<= 1'b0;
				RegDst_o			<= 2'bxx;
				Branch_o			<= 1'b1;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'bxx;
				BranchType_o	<= 2'b11;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end
		
		6'd06: // BLE
		begin
				ALU_op_o			<= 4'd05;
				ALUSrc_o			<= 1'b0;
				RegWrite_o  	<= 1'b0;
				RegDst_o			<= 2'bxx;
				Branch_o			<= 1'b1;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'bxx;
				BranchType_o	<= 2'b01;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end
		
		6'd08: // ADDI
		begin
				ALU_op_o			<= 4'd06;
				ALUSrc_o			<= 1'b1;
				RegWrite_o  	<= 1'b1;
				RegDst_o			<= 2'b00;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'b00;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end		
		
		6'd11: // STLIU
		begin
				ALU_op_o			<= 4'd07;
				ALUSrc_o			<= 1'b1;
				RegWrite_o  	<= 1'b1;
				RegDst_o			<= 2'b01;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'b00;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end	
		
		6'd13: // ORI
		begin
				ALU_op_o			<= 4'd08;
				ALUSrc_o			<= 1'b1;
				RegWrite_o  	<= 1'b1;
				RegDst_o			<= 2'b00;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'b00;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end	
		
		6'd15: // LI
		begin
				ALU_op_o			<= 4'd06;
				ALUSrc_o			<= 1'b1;
				RegWrite_o  	<= 1'b1;
				RegDst_o			<= 2'b00;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'b00;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b0;
		end	
		
		6'd35: // LW
		begin
				ALU_op_o			<= 4'd09;
				ALUSrc_o			<= 1'b1;
				RegWrite_o  	<= 1'b1;
				RegDst_o			<= 2'b00;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'b01;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b1;
				MemWrite_o		<= 1'b0;
		end		
		
		6'd43: // SW
		begin
				ALU_op_o			<= 4'd10;
				ALUSrc_o			<= 1'b1;
				RegWrite_o  	<= 1'b0;
				RegDst_o			<= 2'bxx;
				Branch_o			<= 1'b0;
				
				Jump_o			<= 2'b00;
				MemToReg_o  	<= 2'bxx;
				BranchType_o	<= 2'bxx;
				MemRead_o		<= 1'b0;
				MemWrite_o		<= 1'b1;
		end	
		
		default:;
	endcase
end


endmodule


