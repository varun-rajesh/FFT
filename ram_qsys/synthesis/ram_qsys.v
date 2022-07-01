// ram_qsys.v

// Generated using ACDS version 20.1 720

`timescale 1 ps / 1 ps
module ram_qsys (
		input  wire        clk_clk,         //   clk.clk
		input  wire [13:0] ram_address,     //   ram.address
		input  wire [7:0]  ram_byte_enable, //      .byte_enable
		input  wire        ram_read,        //      .read
		input  wire        ram_write,       //      .write
		input  wire [63:0] ram_write_data,  //      .write_data
		output wire        ram_acknowledge, //      .acknowledge
		output wire [63:0] ram_read_data,   //      .read_data
		input  wire        reset_reset_n    // reset.reset_n
	);

	wire  [63:0] bridge_avalon_master_readdata;              // mm_interconnect_0:bridge_avalon_master_readdata -> bridge:avalon_readdata
	wire         bridge_avalon_master_waitrequest;           // mm_interconnect_0:bridge_avalon_master_waitrequest -> bridge:avalon_waitrequest
	wire   [7:0] bridge_avalon_master_byteenable;            // bridge:avalon_byteenable -> mm_interconnect_0:bridge_avalon_master_byteenable
	wire         bridge_avalon_master_read;                  // bridge:avalon_read -> mm_interconnect_0:bridge_avalon_master_read
	wire  [13:0] bridge_avalon_master_address;               // bridge:avalon_address -> mm_interconnect_0:bridge_avalon_master_address
	wire         bridge_avalon_master_write;                 // bridge:avalon_write -> mm_interconnect_0:bridge_avalon_master_write
	wire  [63:0] bridge_avalon_master_writedata;             // bridge:avalon_writedata -> mm_interconnect_0:bridge_avalon_master_writedata
	wire         mm_interconnect_0_onchip_mem_s1_chipselect; // mm_interconnect_0:onchip_mem_s1_chipselect -> onchip_mem:chipselect
	wire  [63:0] mm_interconnect_0_onchip_mem_s1_readdata;   // onchip_mem:readdata -> mm_interconnect_0:onchip_mem_s1_readdata
	wire  [10:0] mm_interconnect_0_onchip_mem_s1_address;    // mm_interconnect_0:onchip_mem_s1_address -> onchip_mem:address
	wire   [7:0] mm_interconnect_0_onchip_mem_s1_byteenable; // mm_interconnect_0:onchip_mem_s1_byteenable -> onchip_mem:byteenable
	wire         mm_interconnect_0_onchip_mem_s1_write;      // mm_interconnect_0:onchip_mem_s1_write -> onchip_mem:write
	wire  [63:0] mm_interconnect_0_onchip_mem_s1_writedata;  // mm_interconnect_0:onchip_mem_s1_writedata -> onchip_mem:writedata
	wire         mm_interconnect_0_onchip_mem_s1_clken;      // mm_interconnect_0:onchip_mem_s1_clken -> onchip_mem:clken
	wire         rst_controller_reset_out_reset;             // rst_controller:reset_out -> [bridge:reset, mm_interconnect_0:bridge_reset_reset_bridge_in_reset_reset, onchip_mem:reset]
	wire         rst_controller_reset_out_reset_req;         // rst_controller:reset_req -> [onchip_mem:reset_req, rst_translator:reset_req_in]

	ram_qsys_bridge bridge (
		.clk                (clk_clk),                          //                clk.clk
		.reset              (rst_controller_reset_out_reset),   //              reset.reset
		.avalon_readdata    (bridge_avalon_master_readdata),    //      avalon_master.readdata
		.avalon_waitrequest (bridge_avalon_master_waitrequest), //                   .waitrequest
		.avalon_byteenable  (bridge_avalon_master_byteenable),  //                   .byteenable
		.avalon_read        (bridge_avalon_master_read),        //                   .read
		.avalon_write       (bridge_avalon_master_write),       //                   .write
		.avalon_writedata   (bridge_avalon_master_writedata),   //                   .writedata
		.avalon_address     (bridge_avalon_master_address),     //                   .address
		.address            (ram_address),                      // external_interface.export
		.byte_enable        (ram_byte_enable),                  //                   .export
		.read               (ram_read),                         //                   .export
		.write              (ram_write),                        //                   .export
		.write_data         (ram_write_data),                   //                   .export
		.acknowledge        (ram_acknowledge),                  //                   .export
		.read_data          (ram_read_data)                     //                   .export
	);

	ram_qsys_onchip_mem onchip_mem (
		.clk        (clk_clk),                                    //   clk1.clk
		.address    (mm_interconnect_0_onchip_mem_s1_address),    //     s1.address
		.clken      (mm_interconnect_0_onchip_mem_s1_clken),      //       .clken
		.chipselect (mm_interconnect_0_onchip_mem_s1_chipselect), //       .chipselect
		.write      (mm_interconnect_0_onchip_mem_s1_write),      //       .write
		.readdata   (mm_interconnect_0_onchip_mem_s1_readdata),   //       .readdata
		.writedata  (mm_interconnect_0_onchip_mem_s1_writedata),  //       .writedata
		.byteenable (mm_interconnect_0_onchip_mem_s1_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset),             // reset1.reset
		.reset_req  (rst_controller_reset_out_reset_req),         //       .reset_req
		.freeze     (1'b0)                                        // (terminated)
	);

	ram_qsys_mm_interconnect_0 mm_interconnect_0 (
		.clk_clk_clk                              (clk_clk),                                    //                            clk_clk.clk
		.bridge_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),             // bridge_reset_reset_bridge_in_reset.reset
		.bridge_avalon_master_address             (bridge_avalon_master_address),               //               bridge_avalon_master.address
		.bridge_avalon_master_waitrequest         (bridge_avalon_master_waitrequest),           //                                   .waitrequest
		.bridge_avalon_master_byteenable          (bridge_avalon_master_byteenable),            //                                   .byteenable
		.bridge_avalon_master_read                (bridge_avalon_master_read),                  //                                   .read
		.bridge_avalon_master_readdata            (bridge_avalon_master_readdata),              //                                   .readdata
		.bridge_avalon_master_write               (bridge_avalon_master_write),                 //                                   .write
		.bridge_avalon_master_writedata           (bridge_avalon_master_writedata),             //                                   .writedata
		.onchip_mem_s1_address                    (mm_interconnect_0_onchip_mem_s1_address),    //                      onchip_mem_s1.address
		.onchip_mem_s1_write                      (mm_interconnect_0_onchip_mem_s1_write),      //                                   .write
		.onchip_mem_s1_readdata                   (mm_interconnect_0_onchip_mem_s1_readdata),   //                                   .readdata
		.onchip_mem_s1_writedata                  (mm_interconnect_0_onchip_mem_s1_writedata),  //                                   .writedata
		.onchip_mem_s1_byteenable                 (mm_interconnect_0_onchip_mem_s1_byteenable), //                                   .byteenable
		.onchip_mem_s1_chipselect                 (mm_interconnect_0_onchip_mem_s1_chipselect), //                                   .chipselect
		.onchip_mem_s1_clken                      (mm_interconnect_0_onchip_mem_s1_clken)       //                                   .clken
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (1),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                     // reset_in0.reset
		.clk            (clk_clk),                            //       clk.clk
		.reset_out      (rst_controller_reset_out_reset),     // reset_out.reset
		.reset_req      (rst_controller_reset_out_reset_req), //          .reset_req
		.reset_req_in0  (1'b0),                               // (terminated)
		.reset_in1      (1'b0),                               // (terminated)
		.reset_req_in1  (1'b0),                               // (terminated)
		.reset_in2      (1'b0),                               // (terminated)
		.reset_req_in2  (1'b0),                               // (terminated)
		.reset_in3      (1'b0),                               // (terminated)
		.reset_req_in3  (1'b0),                               // (terminated)
		.reset_in4      (1'b0),                               // (terminated)
		.reset_req_in4  (1'b0),                               // (terminated)
		.reset_in5      (1'b0),                               // (terminated)
		.reset_req_in5  (1'b0),                               // (terminated)
		.reset_in6      (1'b0),                               // (terminated)
		.reset_req_in6  (1'b0),                               // (terminated)
		.reset_in7      (1'b0),                               // (terminated)
		.reset_req_in7  (1'b0),                               // (terminated)
		.reset_in8      (1'b0),                               // (terminated)
		.reset_req_in8  (1'b0),                               // (terminated)
		.reset_in9      (1'b0),                               // (terminated)
		.reset_req_in9  (1'b0),                               // (terminated)
		.reset_in10     (1'b0),                               // (terminated)
		.reset_req_in10 (1'b0),                               // (terminated)
		.reset_in11     (1'b0),                               // (terminated)
		.reset_req_in11 (1'b0),                               // (terminated)
		.reset_in12     (1'b0),                               // (terminated)
		.reset_req_in12 (1'b0),                               // (terminated)
		.reset_in13     (1'b0),                               // (terminated)
		.reset_req_in13 (1'b0),                               // (terminated)
		.reset_in14     (1'b0),                               // (terminated)
		.reset_req_in14 (1'b0),                               // (terminated)
		.reset_in15     (1'b0),                               // (terminated)
		.reset_req_in15 (1'b0)                                // (terminated)
	);

endmodule
