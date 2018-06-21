//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1.1
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 4 / 22
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Simple_Single_CPU(
      clk_i,
		rst_i
);
		
//I/O port
input    clk_i;
input    rst_i;

//Internal Signles
wire RegDst_ctrl,
	  RegWrite_ctrl,
	  AluSrc_ctrl,
	  Branch_ctrl,
	  Alu_zero,
	  Branch_set;
	  
wire [3-1:0]  AluOp_ctrl;
wire [4-1:0]  AluOpCode;
wire [5-1:0]  instr_rs,
				  instr_rt,
				  instr_rd,
				  instr_shamt,
				  WriteReg_addr;
wire [6-1:0]  instr_op,
				  instr_funct;
wire [16-1:0] instr_immdt;
wire [32-1:0] aluSrc1,
				  aluSrc2,
				  aluSrc2_Reg,
				  instr,
				  Branch_addr,
				  pc_next,
				  pc_data,
				  pc_shift4,
				  RegWB_data,
				  immdt_32,
				  Shift_rst;

assign { instr_op, instr_rs, instr_rt, instr_rd, instr_shamt, instr_funct} = instr;
assign instr_immdt = instr[15:0];
assign Branch_set = Branch_ctrl & Alu_zero;

//Greate componentes
ProgramCounter PC(
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_next),   
	    .pc_out_o(pc_data) 
);
	
Adder Adder1(
       .src1_i(32'd4),     
	    .src2_i(pc_data),     
	    .sum_o(pc_shift4)    
);
	
Instr_Memory IM(
       .pc_addr_i(pc_data),  
	    .instr_o(instr)    
);

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_rt),
        .data1_i(instr_rd),
        .select_i(RegDst_ctrl),
        .data_o(WriteReg_addr)
);	
		
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_i(rst_i),     
        .RSaddr_i(instr_rs),  
        .RTaddr_i(instr_rt),  
        .RDaddr_i(WriteReg_addr),  
        .RDdata_i(RegWB_data), 
        .RegWrite_i(RegWrite_ctrl),
        .RSdata_o(aluSrc1),  
        .RTdata_o(aluSrc2_Reg)   
);
	
Decoder Decoder(
       .instr_op_i(instr_op), 
	    .RegWrite_o(RegWrite_ctrl), 
	    .ALU_op_o(AluOp_ctrl),   
	    .ALUSrc_o(AluSrc_ctrl),   
	    .RegDst_o(RegDst_ctrl),   
		 .Branch_o(Branch_ctrl)   
);

ALU_Ctrl AC(
        .funct_i(instr_funct),   
        .ALUOp_i(AluOp_ctrl),   
        .ALUCtrl_o(AluOpCode) 
);
	
Sign_Extend SE(
        .data_i(instr_immdt),
        .data_o(immdt_32)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(aluSrc2_Reg),
        .data1_i(immdt_32),
        .select_i(AluSrc_ctrl),
        .data_o(aluSrc2)
);	
		
ALU ALU(
       .src1_i(aluSrc1),
	    .src2_i(aluSrc2),
	    .ctrl_i(AluOpCode),
	    .shamt(instr_shamt),
	    .result_o(RegWB_data),
		 .zero_o(Alu_zero)
);
		
Adder Adder2(
       .src1_i(pc_shift4),     
	    .src2_i(Shift_rst),     
	    .sum_o(Branch_addr)      
);
		
Shift_Left_Two_32 Shifter(
        .data_i(immdt_32),
        .data_o(Shift_rst)
); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_shift4),
        .data1_i(Branch_addr),
        .select_i(Branch_set),
        .data_o(pc_next)
);	

endmodule
		  


