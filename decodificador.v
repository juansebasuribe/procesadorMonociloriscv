module Decodificador(
    input [31:0] instruction1,        // Instrucción completa
    output reg [6:0] opcode1,         // Opcode de la instrucción
    output reg [4:0] rs11,            // Registro fuente 1
    output reg [4:0] rs22,            // Registro fuente 2 (para R-type)
    output reg [4:0] rd1,             // Registro destino
    output reg [24:0] imm1,
	 output reg [2:0] funt31,
	 output reg [6:0] funt71           // Desplazamiento inmediato (para I-type, S-type, B-type)
);

    always @(*) begin
        // Inicializar registros a 0
        opcode1 = instruction1[6:0];     // Extraer el opcode
        rs11 = instruction1[19:15];       // Extraer rs1
        rs22 = instruction1[24:20];       // Extraer rs2 (solo para R-type)
        rd1 = instruction1[11:7];         // Extraer rd
		  funt31 = instruction1[14:12];
		  funt71 = instruction1[31:25];
		  imm1 = instruction1[31:7];
        
    end
endmodule
