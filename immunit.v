module immunit (
	input [24:0] imm_entrada,
	input [2:0] immSrc1,
	output reg [31:0] immExt1
);


	    always @(*) begin
        case (immSrc1)
            3'b000:  // Tipo I (ej., instrucciones de carga)
                immExt1 = {{20{imm_entrada[24]}}, imm_entrada[24:13]};

            3'b001:  // Tipo S (ej., instrucciones de almacenamiento)
                immExt1 = {{20{imm_entrada[24]}}, imm_entrada[24:18], imm_entrada[4:0]};

            3'b101:  // Tipo B (ej., instrucciones de salto condicional)
                immExt1 = {{19{imm_entrada[24]}}, imm_entrada[24], imm_entrada[0], imm_entrada[23:18], imm_entrada[4:1], 1'b0};

            3'b010:  // Tipo U (ej., instrucciones de carga de inmediato superior)
                immExt1 = {imm_entrada[24:5], 12'b0};

            3'b110:  // Tipo J (ej., instrucciones de salto incondicional)
                immExt1 = {{11{imm_entrada[24]}}, imm_entrada[24], imm_entrada[12:5], imm_entrada[13], imm_entrada[23:14], 1'b0};

            default: // En caso de error, extender a 0
                immExt1 = 32'b0;
        endcase
    end
endmodule

	
