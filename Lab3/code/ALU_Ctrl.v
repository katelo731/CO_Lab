//Subject:     CO project 3 - ALU Controller**
//--------------------------------------------------------------------------------
//Version:     3.3
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 5 / 15
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
);
          
//I/O ports 
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
// AluOpCode(output) [4-1:0]

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
parameter ADDI  = 4'd8;
parameter STLIU = 4'd9;
parameter ORI   = 4'd10;

// new function
parameter BNEZ	   = 4'd11;  // I-type
parameter MUL	   = 4'd12;  // R-type
parameter PC_ADD4 = 4'd13;  // I-type
parameter BLTZ	   = 4'd14;  // I-type

parameter dft   = 4'bxxxx;


// AluOp_ctrl(input) [4-1:0]
parameter OP_0   = 4'd00;
// JR, R-type( ADDU,SUBU,AND,OR,SLT,SRA(Shift right arith),SRAV(Shift right var), MUL)
parameter OP_1   = 4'd01;
// BLTZ		(OPcode = 1)
parameter OP_3   = 4'd02;
// JAL		(OPcode = 3)
parameter OP_4   = 4'd03;
// BEQ		(OPcode = 4)
parameter OP_5   = 4'd04;
// BNE/BNEZ	(OPcode = 5)
parameter OP_6   = 4'd05;
// BLE		(OPcode = 6)
parameter OP_8   = 4'd06;
// ADDI   	(OPcode = 8)

parameter OP_11   = 4'd07;
// STLIU		(OPcode = 11)
parameter OP_13   = 4'd08;
// ORI		(OPcode = 13)
parameter OP_35   = 4'd09;
// LW 		(OPcode = 35)
parameter OP_43   = 4'd10;
// SW			(OPcode = 43)

//Select exact operation
always@(*)
begin
	// R-type
	if(ALUOp_i == OP_0) 
	begin
		case(funct_i)
			6'h03: ALUCtrl_o <= SRA;
			6'h07: ALUCtrl_o <= SRAV;
			6'h18: ALUCtrl_o <= MUL;
			6'h21: ALUCtrl_o <= ADD;
			6'h23: ALUCtrl_o <= SUB;
			6'h24: ALUCtrl_o <= AND;
			6'h25: ALUCtrl_o <= OR;
			6'h2a: ALUCtrl_o <= SLT;
			default: ALUCtrl_o <= dft;
		endcase
	end	
	// I-type or J-type
	else
	begin
		case(ALUOp_i)
			OP_4:  ALUCtrl_o <= BEQ;
			OP_5:  ALUCtrl_o <= BNEZ;
			OP_8:  ALUCtrl_o <= ADDI;
			OP_11:  ALUCtrl_o <= STLIU;
			OP_13:  ALUCtrl_o <= ORI;
			
			OP_1:  ALUCtrl_o <= SUB;			// BLTZ
			OP_6:  ALUCtrl_o <= SUB;			// BLE
			OP_3:  ALUCtrl_o <= PC_ADD4;		// JAL
			OP_35: ALUCtrl_o <= ADD; 			// LW
			OP_43: ALUCtrl_o <= ADD;			// SW
			
			default: ALUCtrl_o <= dft;
		endcase
	end
end

endmodule     





                    
                    