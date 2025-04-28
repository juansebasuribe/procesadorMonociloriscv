module UnidadBranch (
    input [31:0] data1,       // Primer operando de comparación
    input [31:0] data2,       // Segundo operando de comparación
    input [4:0] branchOp,     // Código de operación para determinar el tipo de comparación
    output reg NextPcSrc1    // Señal de salida que indica si se debe tomar el salto
);

   // Evaluar el salto basado en el valor de BrOp
    always @(*) begin
        // Si BrOp[4] es 1, tomar el salto incondicionalmente
        if (branchOp[4] == 1'b1) begin
            NextPcSrc1 = 1'b1;
        end else if (branchOp[4:3] == 2'b00) begin
            // Evaluación condicional de acuerdo a BrOp[2:0] cuando BrOp[4:3] es '01'
            case (branchOp[3:0])
                4'b1000: NextPcSrc1 = (data1 == data2);      // BEQ: Salto si igual
                4'b1001: NextPcSrc1 = (data1 != data2);      // BNE: Salto si no igual
                4'b1100: NextPcSrc1 = ($signed(data1) < $signed(data2)); // BLT: Salto si menor (signed)
                4'b1101: NextPcSrc1 = ($signed(data1) >= $signed(data2)); // BGE: Salto si mayor o igual (signed)
                4'b1110: NextPcSrc1 = (data1 < data2);       // BLTU: Salto si menor (unsigned)
                4'b1111: NextPcSrc1 = (data1 >= data2);      // BGEU: Salto si mayor o igual (unsigned)
                default: NextPcSrc1 = 1'b0;                 // Por defecto, no hay salto
            endcase
        end else begin
            // Si BrOp[4:3] es '00', no hay salto y se ejecuta la siguiente instrucción
            NextPcSrc1 = 1'b0;
        end
    end
endmodule