//Subject:     CO project 3 - Simple_Single_CPU**
//--------------------------------------------------------------------------------
//Version:     3.5
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 5 / 21
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

//Internal Signals
wire RegWrite_ctrl,
	  AluSrc_ctrl,
	  Branch_ctrl,
	  MemRead_ctrl,
	  MemWrite_ctrl,
	  Alu_zero,
	  Branch_MUX_o,
	  Branch_select;
	  
wire [2-1:0]  Jump_ctrl,
				  MemtoReg_ctrl,
				  BranchType_ctrl,
				  RegDst_ctrl;
	  
wire [4-1:0]  AluOp_ctrl,
				  AluOpCode;
				  
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
				  AluResult,
				  RegWB_data,
				  MemRead_data,
				  Jump_addr,
				  Immdt_32,
				  Immdt_shift,
				  Branch_o;

assign { instr_op, instr_rs, instr_rt, instr_rd, instr_shamt, instr_funct} = instr;
assign instr_immdt = instr[15:0];
assign Jump_addr = {pc_shift4[31:28], instr[25:0], 2'b00};
assign Branch_select = Branch_ctrl & Branch_MUX_o;

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
       .addr_i(pc_data),  
	    .instr_o(instr)    
);

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_rt),
        .data1_i(instr_rd),
		  .data2_i(5'd31),
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
		 .instr_funct_i(instr_funct),
	    .RegWrite_o(RegWrite_ctrl), 
	    .ALU_op_o(AluOp_ctrl),   
	    .ALUSrc_o(AluSrc_ctrl),   
	    .RegDst_o(RegDst_ctrl),   
		 .Branch_o(Branch_ctrl),
		 .Jump_o(Jump_ctrl),
		 .MemToReg_o(MemtoReg_ctrl),
		 .BranchType_o(BranchType_ctrl),
		 .MemRead_o(MemRead_ctrl),
		 .MemWrite_o(MemWrite_ctrl)
);

ALU_Ctrl AC(
        .funct_i(instr_funct),   
        .ALUOp_i(AluOp_ctrl),   
        .ALUCtrl_o(AluOpCode) 
);
	
Sign_Extend SE(
        .data_i(instr_immdt),
        .data_o(Immdt_32)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(aluSrc2_Reg),
        .data1_i(Immdt_32),
        .select_i(AluSrc_ctrl),
        .data_o(aluSrc2)
);	
		
ALU ALU(
       .src1_i(aluSrc1),
	    .src2_i(aluSrc2),
	    .ctrl_i(AluOpCode),
	    .shamt(instr_shamt),
		 .pc_add4(pc_shift4),
	    .result_o(AluResult),
		 .zero_o(Alu_zero)
);

MUX_4to1 #(.size(1)) Mux_Branch_Type(
        .data0_i(Alu_zero),
        .data1_i(AluResult[31] | Alu_zero),
		  .data2_i(AluResult[31]),
		  .data3_i(!Alu_zero),
        .select_i(BranchType_ctrl),
        .data_o(Branch_MUX_o)
);	

Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(AluResult),
		.data_i(aluSrc2_Reg),
		.MemRead_i(MemRead_ctrl),
		.MemWrite_i(MemWrite_ctrl),
		.data_o(MemRead_data)
);

MUX_3to1 #(.size(32)) Mux_Write_Back(
        .data0_i(AluResult),
        .data1_i(MemRead_data),
		  .data2_i(Immdt_32),
        .select_i(MemtoReg_ctrl),
        .data_o(RegWB_data)
);	
		
Adder Adder2(
       .src1_i(pc_shift4),     
	    .src2_i(Immdt_shift),     
	    .sum_o(Branch_addr)      
);
		
Shift_Left_Two_32 Shifter(
        .data_i(Immdt_32),
        .data_o(Immdt_shift)
); 		

MUX_2to1 #(.size(32)) Mux_Branch(
        .data0_i(pc_shift4),
        .data1_i(Branch_addr),
        .select_i(Branch_select),
        .data_o(Branch_o)
);	
		 
MUX_3to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Branch_o),
        .data1_i(Jump_addr),
		  .data2_i(aluSrc1),
        .select_i(Jump_ctrl),
        .data_o(pc_next)
);	

endmodule
		  
