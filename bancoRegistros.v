module BancoRegistros(
    input wire clk,                     // Señal de reloj
    input wire regWrite1,                // Señal de control para escribir en el registro
    input wire [4:0] rs11,               // Registro fuente 1
    input wire [4:0] rs22,               // Registro fuente 2
    input wire [4:0] rd1,                // Registro destino
    input wire [31:0] dataIn,           // Datos a escribir
    output reg [31:0] dataOut11,         // Datos del registro fuente 1
    output reg [31:0] dataOut2          // Datos del registro fuente 2
);

    // Array de registros de 32 bits
    reg [31:0] registros [0:31];
	 
	 initial begin
		registros[2] = 512; // Asignando el valor decimal 512
	 end


    always @(posedge clk) begin
        if (regWrite1) begin
            // Escribir en el registro destino, si no es x0
            registros[rd1] <= dataIn;
        end
    end

    // Leer los registros fuente
    always @(*) begin
        dataOut11 = (rs11 == 5'b00000) ? 32'b0 : registros[rs11]; // x0 siempre es 0
        dataOut2 = (rs22 == 5'b00000) ? 32'b0 : registros[rs22]; // x0 siempre es 0
    end
endmodule
