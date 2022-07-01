
module ram_qsys (
	clk_clk,
	ram_address,
	ram_byte_enable,
	ram_read,
	ram_write,
	ram_write_data,
	ram_acknowledge,
	ram_read_data,
	reset_reset_n);	

	input		clk_clk;
	input	[13:0]	ram_address;
	input	[7:0]	ram_byte_enable;
	input		ram_read;
	input		ram_write;
	input	[63:0]	ram_write_data;
	output		ram_acknowledge;
	output	[63:0]	ram_read_data;
	input		reset_reset_n;
endmodule
