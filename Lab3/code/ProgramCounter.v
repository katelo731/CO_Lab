//Subject:     CO project 3 - PC
//--------------------------------------------------------------------------------
//Version:     3.5
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 5 / 21
//--------------------------------------------------------------------------------
//Description: design for PC
//--------------------------------------------------------------------------------

module ProgramCounter(
   clk_i,
	rst_i,
	pc_in_i,
	pc_out_o
);
     
//I/O ports
input           clk_i;
input	          rst_i;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

//Main function
always @(posedge clk_i) begin
    if(~rst_i)
	    pc_out_o <= 0;
	else
	    pc_out_o <= pc_in_i;
end

endmodule



                    
                    