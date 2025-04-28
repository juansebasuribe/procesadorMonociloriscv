	module pc_display (
    input wire [31:0] pc,  // Entrada del valor del PC de 32 bits
    input wire [3:0] sel,        // Selector: 0 para los 16 bits menos significativos, 1 para los más significativos
	 input wire [31:0] reAlu, // Registro a mostrar
	 input wire [31:0] instruction1,
	 input wire [31:0] rd1,
	 input wire [31:0] DataWriteDisplay,
	 input wire [31:0] rs01,
	 input wire [31:0] rs02,
	 input wire [31:0] outMuxInf1,
	 input wire [31:0] outMuxSub1,
    output wire [6:0] seg_display00,  // Segmentos para display 0
    output wire [6:0] seg_display11,  // Segmentos para display 1
    output wire [6:0] seg_display22,  // Segmentos para display 2
    output wire [6:0] seg_display33  // Segmentos para display 3
);
    reg [15:0] selected_bits;  // seleccionar 16 bits para mostrar en el display
    reg [3:0] hex_digit0, hex_digit1, hex_digit2, hex_digit3;
	 
	 always @(*) begin
		case (sel)
			4'b0000: selected_bits = pc[15:0]; // se muestran los bits menos significativos del pc
			4'b0001: selected_bits = pc[31:16]; // se muestran los bits mas significativos del pc
			4'b0010: selected_bits = reAlu[15:0]; // se muestran los bits menos significativos del registro
			4'b0011: selected_bits = reAlu[31:16]; // se muestran los bits mas significativos del registro
			4'b0100: selected_bits = instruction1[15:0]; // se muestran los bits menos significativos del registro
			4'b0101: selected_bits = instruction1[31:16]; // se muestran los bits mas significativos del registro
			4'b0110: selected_bits = rd1[15:0];
			4'b0111: selected_bits = rd1[31:16];
			4'b1000: selected_bits = DataWriteDisplay[15:0];
			4'b1001: selected_bits = DataWriteDisplay[31:16];
			4'b1010: selected_bits = rs01[15:0];
			4'b1011: selected_bits = rs01[31:16];
			4'b1100: selected_bits = outMuxInf1[15:0];
			4'b1101: selected_bits = outMuxInf1[31:16];
			4'b1110: selected_bits = outMuxSub1[15:0];
			4'b1111: selected_bits = outMuxSub1[31:16];
			
			
			default: selected_bits = 16'b0;
		endcase
		hex_digit3 = selected_bits[15:12];  // Dígito más significativo
	   hex_digit2 = selected_bits[11:8];   // Segundo dígito
	   hex_digit1 = selected_bits[7:4];    // Tercer dígito
	   hex_digit0 = selected_bits[3:0];    // Cuarto dígito
		
	 end
	 
	 
    b4_to_7seg d0 (
		.int1(hex_digit0),
		.seg(seg_display00)
	 );
	 
	 b4_to_7seg d1 (
		.int1(hex_digit1),
		.seg(seg_display11)
	 );
	 
	 b4_to_7seg d2 (
		.int1(hex_digit2),
		.seg(seg_display22)
	 );
	 
	 b4_to_7seg d3 (
		.int1(hex_digit3),
		.seg(seg_display33)
	 );
    
endmodule 


