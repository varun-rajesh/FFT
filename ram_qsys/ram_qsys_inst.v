	ram_qsys u0 (
		.clk_clk         (<connected-to-clk_clk>),         //   clk.clk
		.ram_address     (<connected-to-ram_address>),     //   ram.address
		.ram_byte_enable (<connected-to-ram_byte_enable>), //      .byte_enable
		.ram_read        (<connected-to-ram_read>),        //      .read
		.ram_write       (<connected-to-ram_write>),       //      .write
		.ram_write_data  (<connected-to-ram_write_data>),  //      .write_data
		.ram_acknowledge (<connected-to-ram_acknowledge>), //      .acknowledge
		.ram_read_data   (<connected-to-ram_read_data>),   //      .read_data
		.reset_reset_n   (<connected-to-reset_reset_n>)    // reset.reset_n
	);

