module COMPUTE_UNIT (
	input clk,
	input[63 : 0] a,
	input[63 : 0] b,
	input[63 : 0] twiddle,
	output[63 : 0] out_a,
	output[63 : 0] out_b
);

wire[63 : 0] twiddled_b;

COMPLEX_MULTIPLICATION c_mult (
	.clk (clk),
	.areset (1'b0),
	.a (b[63 : 32]),
	.b (b[31 : 0]),
	.c (twiddle[63 : 32]),
	.d (twiddle[31 : 0]),
	.q (twiddled_b[63 : 32]),
	.r (twiddled_b[31 : 0])
);

ADD adder_real (
	.clk (clk),
	.areset (1'b0),
	.a (a[63 : 32]),
	.b (twiddled_b[63 : 32]),
	.q (out_a[63 : 32])
);

ADD adder_imag (
	.clk (clk),
	.areset (1'b0),
	.a (a[31 : 0]),
	.b (twiddled_b[31 : 0]),
	.q (out_a[31 : 0])
);

SUBTRACT subtract_real (
	.clk (clk),
	.areset (1'b0),
	.a (a[63 : 32]),
	.b (twiddled_b[63 : 32]),
	.q (out_b[63 : 32])
);

SUBTRACT subtract_imag (
	.clk (clk),
	.areset (1'b0),
	.a (a[31 : 0]),
	.b (twiddled_b[31 : 0]),
	.q (out_b[31 : 0])
);

endmodule
