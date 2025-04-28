module Memoria (
    input clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,      // 1: write, 0: read
    input [2:0] DMCtrl1,
    output reg [31:0] readData
);
	 reg [31:0] data_read;
    reg [31:0] data_write;
    reg [7:0] memory [0:127];  // Memoria de 128 palabras de 8 bits (para almacenamiento byte a byte)

    always @(posedge clk) begin
        if (memWrite) begin
            // Escritura en la memoria según el control de tamaño DMCtrl1
            case (DMCtrl1)
                3'b000: data_write = {24'b0, writeData[7:0]};     // Byte
                3'b001: data_write = {16'b0, writeData[15:0]};    // Half-word
                3'b010: data_write = writeData;                   // Word completo
                default: data_write = 32'b0;                   // No escribe nada si DMCtrl es inválido
            endcase
            {memory[address+3], memory[address+2], memory[address+1], memory[address]} = data_write;
        end
    end

    // Lógica combinacional para lectura de datos
    always @(*) begin
        // Leer los datos de memoria en función del tamaño especificado por DMCtrl
        data_read = {memory[address+3], memory[address+2], memory[address+1], memory[address]};

        case (DMCtrl1)
            3'b000: readData = {{24{data_read[7]}}, data_read[7:0]};   // Byte con signo
            3'b001: readData = {{16{data_read[15]}}, data_read[15:0]}; // Half-word con signo
            3'b010: readData = data_read;                              // Word completo
            3'b100: readData = {24'b0, data_read[7:0]};                // Byte sin signo
            3'b101: readData = {16'b0, data_read[15:0]};               // Half-word sin signo
            default: readData = 32'b0;                              // Valor por defecto si DMCtrl es inválido
		endcase
	end
endmodule