module PC(
    input clk,                // Señal de relo
    input [31:0] next_pc1,     // Dirección de la siguiente instrucción
    output reg [31:0] pc           // Dirección actual de la instrucción
);


	 // Bloque secuencial para actualizar el valor del PC en cada ciclo de reloj
    always @(posedge clk) begin
            pc <= next_pc1;         // Actualiza el PC a la siguiente dirección
    end
	 
endmodule

