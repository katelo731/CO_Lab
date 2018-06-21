//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1.2
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 4 / 22
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
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
// AluOpCode(output) [3:0]

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


// AluOp_ctrl(input) [2:0]
parameter OP0   = 3'b000;
// R-type : ADDU,SUBU,AND,OR,SLT,SRA(Shift right arith),SRAV(Shift right var)
parameter OP1   = 3'b001;
// BEQ
parameter OP2   = 3'b010;
// BNE
parameter OP3   = 3'b011;
// ADDI
parameter OP4   = 3'b100;
// STLIU
parameter OP5   = 3'b101;
// ORI
parameter OP6   = 3'b110;
// LUI

//Select exact operation
always@(*)
begin
	// R-type
	if(ALUOp_i == OP0) 
	begin
		case(funct_i)
			6'h03: ALUCtrl_o <= SRA;
			6'h07: ALUCtrl_o <= SRAV;
			6'h21: ALUCtrl_o <= ADD;
			6'h23: ALUCtrl_o <= SUB;
			6'h24: ALUCtrl_o <= AND;
			6'h25: ALUCtrl_o <= OR;
			6'h2a: ALUCtrl_o <= SLT;
			default: ALUCtrl_o <= dft;
		endcase
	end	
	// I-type
	else
	begin
		case(ALUOp_i)
			OP1: ALUCtrl_o <= BEQ;
			OP2: ALUCtrl_o <= BNE;
			OP3: ALUCtrl_o <= ADDI;
			OP4: ALUCtrl_o <= STLIU;
			OP5: ALUCtrl_o <= ORI;
			OP6: ALUCtrl_o <= LUI;
			default: ALUCtrl_o <= dft;
		endcase
	end
end

endmodule     





                    
                    