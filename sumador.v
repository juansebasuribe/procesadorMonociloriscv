module Sumador(
    input wire [31:0] in,
    output wire [31:0] out
);
    assign out = in + 32'd4; // Suma constante de 4
endmodule
