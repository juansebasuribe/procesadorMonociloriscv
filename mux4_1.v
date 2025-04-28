module mux4_1 (
    input [31:0] in0,         // Primera entrada de 32 bits
    input [31:0] in1,         // Segunda entrada de 32 bits
    input [31:0] in2,         // Tercera entrada de 32 bits
    input [31:0] in31,         // Cuarta entrada de 32 bits (bloqueada)
    input [1:0] sel,          // Señal de control de 2 bits
    output reg [31:0] out     // Salida de 32 bits
);

always @(*) begin
    case (sel)
        2'b00: out = in0;
        2'b01: out = in1;
        2'b10: out = in2;
        default: out = 32'b1; // Bloqueada cuando sel es 2'b11
    endcase
end

endmodule
