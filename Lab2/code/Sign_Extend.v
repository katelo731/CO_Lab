//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1.1
//--------------------------------------------------------------------------------
//Writer:      0513311 Lo Wen-Huei
//--------------------------------------------------------------------------------
//Date:        2018 / 4 / 20
//--------------------------------------------------------------------------------
//Description: extend sign bit of data_i to [31:16]data_o
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
);
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
wire    [16-1:0] data_i;
reg     [32-1:0] data_o;

//Sign extended
always@(*)
begin
	data_o[0] <= data_i[0];
	data_o[1] <= data_i[1];
	data_o[2] <= data_i[2];
	data_o[3] <= data_i[3];
	data_o[4] <= data_i[4];
	data_o[5] <= data_i[5];
	data_o[6] <= data_i[6];
	data_o[7] <= data_i[7];
	
	data_o[8] <= data_i[8];
	data_o[9] <= data_i[9];
	data_o[10] <= data_i[10];
	data_o[11] <= data_i[11];
	data_o[12] <= data_i[12];
	data_o[13] <= data_i[13];
	data_o[14] <= data_i[14];
	data_o[15] <= data_i[15];
	
	data_o[16] <= data_i[15];
	data_o[17] <= data_i[15];
	data_o[18] <= data_i[15];
	data_o[19] <= data_i[15];
	data_o[20] <= data_i[15];
	data_o[21] <= data_i[15];
	data_o[22] <= data_i[15];
	data_o[23] <= data_i[15];
	
	data_o[24] <= data_i[15];
	data_o[25] <= data_i[15];
	data_o[26] <= data_i[15];
	data_o[27] <= data_i[15];
	data_o[28] <= data_i[15];
	data_o[29] <= data_i[15];
	data_o[30] <= data_i[15];
	data_o[31] <= data_i[15];
end

endmodule      
     