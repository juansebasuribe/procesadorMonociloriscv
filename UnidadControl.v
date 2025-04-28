module UnidadControl(
    input [6:0] opcode01,         // Código de operación
    input [2:0] funt3_01,
    input [6:0] funt7_01,
    output reg ruWe01,
    output reg [2:0] immSrc01,
    output reg aluASrc01,
    output reg aluBSrc01,
    output reg [3:0] aluOp01,
    output reg dmWr01,
    output reg [1:0] RUrSrc01,
    output reg [2:0] DMCtrl01,
    output reg [4:0] BROp1
);

    always @(*) begin
		 ruWe01 = 1'b0;
		 immSrc01 = 3'b000;
		 aluASrc01 = 1'b0;
		 aluBSrc01 = 1'b0;
		 aluOp01 = 4'b0000;
		 dmWr01 = 1'b0;
		 DMCtrl01 = 3'b000;
		 BROp1 = 5'b00000;
		 RUrSrc01 = 2'b00;
		 
        case (opcode01)
            7'b0110011: begin // Tipo R
                ruWe01 = 1'b1;
                aluOp01 = {funt7_01[5], funt3_01[2:0]}; // Suma
                aluASrc01 = 1'b0;
                aluBSrc01 = 1'b0;
                dmWr01 = 1'b0;
                BROp1 = 5'b00000;
                RUrSrc01 = 2'b00;
					 DMCtrl01 = 2'b11;
					 immSrc01 = 3'b000;
            end

            7'b0010011: begin // Tipo I (aritmetica)
                ruWe01 = 1'b1;
                immSrc01 = 3'b000;
                aluASrc01 = 1'b0;
                aluBSrc01 = 1'b1;
                dmWr01 = 1'b0;
                BROp1 = 5'b00000;
                RUrSrc01 = 2'b00;
					 DMCtrl01 = 2'b11;

                case (funt3_01)
                    3'b000: aluOp01 = {1'b0, funt3_01 [2:0]}; // ADDI
                    3'b100: aluOp01 = {1'b0, funt3_01 [2:0]}; // XORI
                    3'b110: aluOp01 = {1'b0, funt3_01 [2:0]}; // ORI
                    3'b111: aluOp01 = {1'b0, funt3_01 [2:0]}; // ANDI
                    default: aluOp01 = {funt7_01 [5], funt3_01 [2:0]};
                endcase
            end
            
            7'b0000011: begin // Tipo I para instrucciones de carga (e.g., LW)
                ruWe01 = 1'b1;
                aluASrc01 = 1'b0;
                aluBSrc01 = 1'b1;
                aluOp01 = 4'b0000;
                immSrc01 = 3'b000;
                dmWr01 = 1'b0;
                DMCtrl01 = funt3_01 [2:0];
                BROp1 = 5'b00000;
                RUrSrc01 = 2'b01;
            end
				
				//Tipo B
            
            7'b1100011: begin
					ruWe01 = 1'b0;
               aluASrc01 = 1'b1;
               aluBSrc01 = 1'b1;
               aluOp01 = 4'b0000;
               immSrc01 = 3'b101;
               dmWr01 = 1'b0;
               BROp1 = {2'b01, funt3_01 [2:0]};
					DMCtrl01 = 2'b11;
					RUrSrc01 = 2'b11;
					
				end
				
				// Tipo J
				
				7'b1101111: begin 
                ruWe01 = 1'b1;
                aluASrc01 = 1'b1;
                aluBSrc01 = 1'b1;
                aluOp01 = 4'b0000;
                immSrc01 = 3'b110;
                dmWr01 = 1'b0;
                BROp1 = 5'b11111;
                RUrSrc01 = 2'b10;
					 DMCtrl01 = 2'b11;
            end
				
				//Tipo s
				
				7'b0100011: begin 
                ruWe01 = 1'b0;
                aluASrc01 = 1'b0;
                aluBSrc01 = 1'b1;
                aluOp01 = 4'b0000;
                immSrc01 = 3'b001;
                dmWr01 = 1'b1;
                DMCtrl01 = funt3_01 [2:0];
                BROp1 = 5'b00000;
					 RUrSrc01 = 2'b10;
               
            end
				
				//Tipo I de salto Jalr
				
				7'b1100111: begin 
                ruWe01 = 1'b1;
                aluASrc01 = 1'b0;
                aluBSrc01 = 1'b1;
                aluOp01 = 4'b0000;
                immSrc01 = 3'b000;
                dmWr01 = 1'b0;
                BROp1 = 5'b11111;
                RUrSrc01 = 2'b10;
					 DMCtrl01 = funt3_01 [2:0];
            end
				
				//Tipo U
				
				7'b0110111: begin 
                ruWe01 = 1'b0;
                aluBSrc01 = 1'b1;
                aluOp01 = 4'b0111;
                immSrc01 = 3'b010;
                dmWr01 = 1'b0;
                BROp1 = 5'b00000;
                RUrSrc01 = 2'b00;
					 DMCtrl01 = funt3_01 [2:0];
            end
				
				//Tipo U
				
				7'b0010111: begin 
                ruWe01 = 1'b0;
                aluBSrc01 = 1'b1;
                aluOp01 = 4'b0111;
                immSrc01 = 3'b010;
                dmWr01 = 1'b0;
                BROp1 = 5'b00000;
                RUrSrc01 = 2'b00;
					 DMCtrl01 = funt3_01 [2:0];
            end
				
				default: begin
					 ruWe01 = 1'b0;
					 immSrc01 = 3'b000;
					 aluASrc01 = 1'b0;
					 aluBSrc01 = 1'b0;
					 aluOp01 = 4'b0000;
					 dmWr01 = 1'b0;
					 DMCtrl01 = 3'b000;
					 BROp1 = 5'b00000;
					 RUrSrc01 = 2'b00;
    
				end


        endcase
    end
endmodule
