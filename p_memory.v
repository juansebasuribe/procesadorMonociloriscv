module p_memory (
    input wire [31:0] address,
    output wire [31:0] data_out
);

    // Declaración de memoria ROM para 1024 palabras de 32 bits
    reg [31:0] memory [0:511];

    // Cargar datos desde el archivo .hex en la inicialización
    initial begin
        $readmemh("program.hex", memory);
    end
	 
	 assign data_out = (address[23:2] < 512) ? memory[address[23:2]]: 32'b0;
	 
endmodule

