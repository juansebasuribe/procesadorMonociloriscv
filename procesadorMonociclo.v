module procesadorMonociclo(
    input clk1, 
	 input [3:0] switch0,
	 output [6:0] seg_display0,
	 output [6:0] seg_display1,
	 output [6:0] seg_display2,
	 output [6:0] seg_display3
	 	 
);

    wire ruWe;
	 wire in3;
	 wire	[2:0] immSrc;
	 wire aluASrc;
	 wire aluBSrc;
	 wire [3:0] aluOp;
	 wire dmWr;
	 wire [31:0] memoryDataOut;
	 wire [1:0] RUrSrc;
	 wire [2:0] DMCtrl;
	 wire [4:0] BROp;
	 wire [2:0] funt3;
	 wire [6:0] funt7;
    wire [24:0] imm;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    wire [31:0] next_pc;
    wire [31:0] dataOut1, dataOut2; // Salidas del Banco de Registros
    wire [31:0] aluResult; // Resultado de la ALU
    wire zero; // Indicador de cero
	 wire [31:0] pc_out;
	 wire [31:0] instruction;
	 wire [31:0] in0;
	 wire [31:0] in1;
	 wire [31:0] in2;
	 wire [31:0] dataWrite;
	 wire regWrite;
	 wire [31:0] immExt;
	 wire [31:0] next_pc_plus_4;
	 wire NextPcSrc;
	 wire [31:0] outMuxSup;
	 wire [31:0] outMuxInf;
	 
	 

    // Instancia del PC
    PC pc_inst (
        .clk(clk1),
        .next_pc1(next_pc),
        .pc(pc_out)
    );
	 
	 // Instancia del sumador
	 Sumador sumador_pc (
		 .in(pc_out),
		 .out(next_pc_plus_4)
	 );
	 // instancia progrma memory
	 p_memory p_memory (
			.address(pc_out),
			.data_out(instruction)
			);

    // Instancia del Decodificador
    Decodificador decodificador_inst (
        .instruction1(instruction),
        .opcode1(opcode),
        .rs11(rs1),
        .rs22(rs2),
        .rd1(rd),
        .imm1(imm),
		  .funt31(funt3),
		  .funt71(funt7)
    );
	 
	 // Instancia de la Unidad de Control
    UnidadControl control_inst (
        .opcode01(opcode),
		  .funt3_01(funt3),
		  .funt7_01(funt7),
        .ruWe01(ruWe),
		  .immSrc01(immSrc),
		  .aluASrc01(aluASrc),
		  .aluBSrc01(aluBSrc),
		  .aluOp01(aluOp),
		  .dmWr01(dmWr),
		  .RUrSrc01(RUrSrc),
		  .DMCtrl01(DMCtrl),
		  .BROp1(BROp)
    );
	 
	    
    // Instancia del Banco de Registros
    BancoRegistros banco_registros_inst (
        .clk(clk1),
        .regWrite1(ruWe),
        .rs11(rs1),
        .rs22(rs2),
        .rd1(rd),
        .dataIn(dataWrite),
        .dataOut11(dataOut1),
        .dataOut2(dataOut2)
    );
	 
	 
	 //instancia del inmediato
	 immunit immunit_inst(
			.imm_entrada(imm),
			.immSrc1(immSrc),
			.immExt1(immExt)
	 );
	 
	 //multiplexor superior
	 mux_superior mux_sup(
		  .pc_outmux(pc_out),
		  .RUrs1(dataOut1),
		  .ALUASrc(aluASrc),
		  .muxOutput(outMuxSup)
	);
	
	//multiplexor superior
	 mux_inferior mux_inf(
		  .in_immExt(immExt),
		  .in_RUrs2(dataOut2),
		  .in_ALUBSrc(aluBSrc),
		  .out_muxOutput(outMuxInf)
	);
		  

    // Instancia de la ALU
    ALU alu_inst (
        .a(outMuxSup),           // Operando A
        .b(outMuxInf), // Operando B (inmediato o del registro)
        .aluOp_001(aluOp), // Señal de control
        .result(aluResult)     // Resultado de la ALU
    );
	 
	 
	 UnidadBranch unidad_branch(
		  .data1(dataOut1),
		  .data2(dataOut2),
		  .branchOp(BROp),
		  .NextPcSrc1(NextPcSrc)
	 );
	 
	 // Instancia de la Memoria
	 Memoria memoria_inst (
		  .clk(clk1),
		  .memWrite(dmWr),
		  .DMCtrl1(DMCtrl),
		  .address(aluResult),      // Usamos la salida de la ALU como dirección
		  .writeData(dataOut2),     // Datos a escribir vienen del registro
		  .readData(memoryDataOut)  // Datos leídos de memoria
	 );
	 
	 mux4_1 mux4_1(
			.in0(aluResult),
			.in1(memoryDataOut),
			.in2(next_pc_plus_4),
			.in31(in3),
			.sel(RUrSrc),
			.out(dataWrite)
	 );
			
	 mux_2_1_B mux_2_1_B(
			.inSum(next_pc_plus_4),
			.inAlu(aluResult),
			.NexPcSrc1(NextPcSrc),
			.out(next_pc)
	 );
	 
	 
	 pc_display pc_display(
		 .pc(pc_out),
		 .sel(switch0),
		 .reAlu(aluResult),
		 .instruction1(instruction),
		 .rd1(rd),
		 .DataWriteDisplay(dataWrite),
		 .rs01(dataOut1),
		 .rs02(dataOut2),
		 .outMuxInf1(outMuxInf),
		 .outMuxSub1(outMuxSup),
		 .seg_display00(seg_display0),
		 .seg_display11(seg_display1),
		 .seg_display22(seg_display2),
		 .seg_display33(seg_display3)
	 );
	 
endmodule
