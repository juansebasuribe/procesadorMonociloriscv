module mux_superior(
	input [31:0] pc_outmux,
	input [31:0] RUrs1,
	input ALUASrc,
	output [31:0] muxOutput
);


assign muxOutput = ALUASrc ? pc_outmux : RUrs1;
endmodule