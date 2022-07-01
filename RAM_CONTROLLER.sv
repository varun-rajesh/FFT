module RAM_CONTROLLER (
	input clk,
	input read_enable,
	input write_enable,
	input[10 : 0] a_address,
	input[10 : 0] b_address,
	input[10 : 0] twiddle_address,
	input[63 : 0] a_write,
	input[63 : 0] b_write,
	output reg[63 : 0] a_read,
	output reg[63 : 0] b_read,
	output reg[63 : 0] twiddle_read,
	output ready
);

localparam[1 : 0] NO_OP = 2'd0;
localparam[1 : 0] READ_OP = 2'd1;
localparam[1 : 0] WRITE_OP = 2'd2;

localparam[2 : 0] NEUTRAL = 3'd0;

localparam[2 : 0] READ_A = 3'd1;
localparam[2 : 0] READ_B = 3'd2;
localparam[2 : 0] READ_TWIDDLE = 3'd3;
localparam[2 : 0] READ_ACKNOWLEDGE = 3'd4;

localparam[2 : 0] WRITE_A = 3'd5;
localparam[2 : 0] WRITE_B = 3'd6;
localparam[2 : 0] WRITE_ACKNOWLEDGE = 3'd7;

reg[1 : 0] op;
reg[2 : 0] state;

reg[10 : 0] ram_address;
wire ram_read;
wire ram_write;
reg[63 : 0] ram_write_data;
wire ram_acknowledge;
wire[63 : 0] ram_read_data;

always @ (posedge clk) begin
	if (state == READ_A) begin
		a_read <= ram_read_data;
	end else if (state == READ_B) begin
		b_read <= ram_read_data;
	end else if (state == READ_TWIDDLE) begin
		twiddle_read <= ram_read_data;
	end
end

always_comb begin
	case ({read_enable, write_enable})
		2'b00 : op <= NO_OP;
		2'b01 : op <= WRITE_OP;
		2'b10 : op <= READ_OP;
		2'b11 : op <= NO_OP;
	endcase
end

always @ (posedge clk) begin
	if (op == READ_OP) begin
		case (state)
			READ_A : state <= (ram_acknowledge) ? READ_B : READ_A;
			READ_B : state <= (ram_acknowledge) ? READ_TWIDDLE : READ_B;
			READ_TWIDDLE : state <= (ram_acknowledge) ? READ_ACKNOWLEDGE : READ_TWIDDLE;
			READ_ACKNOWLEDGE : state <= READ_A;
			default: state <= READ_A;
		endcase
	end else if (op == WRITE_OP) begin
		case (state)
			WRITE_A : state <= WRITE_B;
			WRITE_B : state <= WRITE_ACKNOWLEDGE;
			default: state <= WRITE_A;
		endcase
	end else begin
		state <= NEUTRAL;
	end
end

always_comb begin
	case (state)
		READ_A, WRITE_A : ram_address <= a_address;
		READ_B, WRITE_B : ram_address <= b_address;
		READ_TWIDDLE : ram_address <= twiddle_address;
		default : ram_address <= 11'b0;
	endcase
end

always_comb begin
	if (state == WRITE_A) begin
		ram_write_data <= a_write;
	end else if (state == WRITE_B) begin
		ram_write_data <= b_write;
	end else begin
		ram_write_data <= 64'b0;
	end
end

assign ram_read = (state == READ_A || state == READ_B || state == READ_TWIDDLE) && (op == READ_OP);
assign ram_write = (state == WRITE_A || state == WRITE_B) && (op == WRITE_OP);
assign ready = (state == READ_ACKNOWLEDGE) || (state == WRITE_ACKNOWLEDGE);

ram_qsys ram (
	.clk_clk (clk),
	.ram_address ({ram_address, 3'b000}),
	.ram_byte_enable (8'hff),
	.ram_read (ram_read),
	.ram_write (ram_write),
	.ram_write_data (ram_write_data),
	.ram_acknowledge (ram_acknowledge),
	.ram_read_data (ram_read_data),
	.reset_reset_n (1'b1)
);

endmodule

