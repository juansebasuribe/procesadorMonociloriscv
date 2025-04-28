module mux_2_1_B (
    input [31:0] inSum,     // Primera entrada de 32 bits
    input [31:0] inAlu,     // Segunda entrada de 32 bits
    input [1:0] NexPcSrc1,   // Señal de control de 2 bits
    output reg [31:0] out   // Salida de 32 bits
);

    always @(*) begin
        case (NexPcSrc1)
            2'b00: out = inSum;
            2'b01: out = inAlu;
            default: out = 32'b0;
        endcase
    end
endmodule
