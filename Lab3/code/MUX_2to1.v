//Subject:     CO project 3 - MUX 221
//--------------------------------------------------------------------------------
//Version:     3.5
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 5 / 21
//--------------------------------------------------------------------------------
//Description: decide the source of the two datas
//--------------------------------------------------------------------------------
     
module MUX_2to1(
               data0_i,
               data1_i,
               select_i,
               data_o
);

parameter size = 0;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input              select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function
always@(*)
begin
	data_o <= ( select_i == 0 )? data0_i : data1_i;
end

endmodule      
          
          