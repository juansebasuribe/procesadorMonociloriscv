module mux_inferior(
	input [31:0] in_immExt,
	input [31:0] in_RUrs2,
	input in_ALUBSrc,
	output [31:0] out_muxOutput
);


assign out_muxOutput = in_ALUBSrc ? in_immExt : in_RUrs2;
endmodule