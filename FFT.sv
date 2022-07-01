module FFT (
	input MAX10_CLK1_50,
	input KEY0
);

localparam[1 : 0] NEUTRAL = 2'b00;
localparam[1 : 0] READ = 2'b01;
localparam[1 : 0] COMPUTE = 2'b10;
localparam[1 : 0] WRITE = 2'b11;

reg[1 : 0] state;
reg[6 : 0] compute_counter;

reg[9 : 0] base_pointer;
wire[10 : 0] base_increment;

reg[9 : 0] addendum;
wire[9 : 0] addendum_limit;

wire[9 : 0] a_address;
wire[9 : 0] b_address;
wire[9 : 0] twiddle_address;
wire[10 : 0] a_b_offset;

reg[3 : 0] level;

wire read_enable;
wire write_enable;
wire[63 : 0] computed_a;
wire[63 : 0] computed_b;
wire[63 : 0] a_read;
wire[63 : 0] b_read;
wire[63 : 0] twiddle_read;

reg[63 : 0] latched_a;
reg[63 : 0] latched_b;
reg[63 : 0]	latched_twiddle;

wire ready;

assign base_increment = 2 ** (level + 1);
assign addendum_limit = 2 ** (level) - 1;
assign a_b_offset = 2 ** (level);

assign a_address = base_pointer + addendum;
assign b_address = a_address + a_b_offset;
assign twiddle_address = (2 ** (9 - level)) * addendum;

assign read_enable = (level >= 4'ha) ? 1'b0 : (state == READ);
assign write_enable = (level >= 4'ha) ? 1'b0 : (state == WRITE);

initial begin
	state <= READ;
	level <= 4'ha;
	base_pointer <= 10'b0;
end

always @ (posedge MAX10_CLK1_50) begin
	if (!KEY0) begin
		state <= READ;
	end else begin
		if (state == NEUTRAL) begin
			state <= READ;
		end else if (state == READ) begin
			state <= (ready) ? COMPUTE : READ;
		end else if (state == COMPUTE) begin
			state <= (compute_counter == 7'd100) ? WRITE : COMPUTE;
		end else if (state == WRITE) begin
			state <= (ready) ? NEUTRAL : WRITE;
		end
	end
end

always @ (posedge MAX10_CLK1_50) begin
	compute_counter <= (state == COMPUTE) ? compute_counter + 1 : 8'b0;
end

always @ (posedge MAX10_CLK1_50) begin
	if (!KEY0) begin
		level <= 4'h0;
	end else if (level >= 4'ha) begin
		level <= 4'ha;
	end else if (addendum == addendum_limit && state == NEUTRAL) begin
		if (base_pointer == 11'd1024 - base_increment) begin
			level <= level + 1;
		end
	end
end

always @ (posedge MAX10_CLK1_50) begin
	if (!KEY0) begin
		base_pointer <= 10'h0;
	end else if (addendum == addendum_limit && state == NEUTRAL) begin
		base_pointer <= base_pointer + base_increment;
	end
end

always @ (posedge MAX10_CLK1_50) begin
	if (!KEY0) begin
		addendum <= 10'b0;
	end else if (level >= 4'ha) begin 
		addendum <= 10'b0;
	end else if (state == NEUTRAL) begin
		addendum <= (addendum == addendum_limit) ? 10'b0 : addendum + 1;
	end
end

always @ (posedge MAX10_CLK1_50) begin
	if (ready) begin
		latched_a <= a_read;
		latched_b <= b_read;
		latched_twiddle <= twiddle_read;
	end
end

RAM_CONTROLLER rc (
	.clk (MAX10_CLK1_50),
	.read_enable (read_enable),
	.write_enable (write_enable),
	.a_address (a_address),
	.b_address (b_address),
	.twiddle_address ({1'b1, twiddle_address}),
	.a_write (computed_a),
	.b_write (computed_b),
	.a_read (a_read),
	.b_read (b_read),
	.twiddle_read (twiddle_read),
	.ready (ready)
);

COMPUTE_UNIT cu (
	.clk (MAX10_CLK1_50),
	.a (latched_a),
	.b (latched_b),
	.twiddle (latched_twiddle),
	.out_a (computed_a),
	.out_b (computed_b)
);

endmodule
