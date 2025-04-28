module ALU(
    input [31:0] a,                 // Operando A
    input [31:0] b,                 // Operando B
    input [3:0] aluOp_001,        // Señal de control de la ALU
    output reg [31:0] result       // Resultado de la operación
);

    always @(*) begin
        case (aluOp_001)
            4'b0000: result = a + b;          // Suma
            4'b0001: result = a << b[4:0];         // Desplazamiento a la izquierda
            4'b0010: result = $signed(a) < $signed(b) ? 32'b1 : 32'b0;
            4'b0011: result = a < b ? 32'd1 : 32'd0;
            4'b0100: result = a ^ b;          // XOR
            4'b0101: result = a >> b[4:0];         // Desplazamiento a la derecha
            4'b0110: result = a | b;          // OR
            4'b0111: result = a & b;          // AND
            4'b1000: result = a - b;          // RESTA
				4'b1101: result = $signed(a) >>> b[4:0];        //desplazamiento a la derecha aritmético
            default: result = 32'b0; // Valor por defecto
        endcase
    end
endmodule

