module ALU_Decoder (
	
	input [5:0] funct,
	input [1:0] ALUOp,
	
	output reg [2:0] ALUControl
	

);

always @ (*)
begin
ALUControl = 3'bx;
case(ALUOp)

	2'b00: ALUControl = 3'b010;	//Add
	2'b01: ALUControl = 3'b110;	//Sub
	default: 
		case (funct)
		
		6'b100000: ALUControl = 3'b010; //Add
		6'b100010: ALUControl = 3'b110; //Sub
		6'b100100: ALUControl = 3'b000; //And
		6'b100101: ALUControl = 3'b001;	//Or
		6'b101010: ALUControl = 3'b111; //SLT
		default :ALUControl = 3'bxxx;
		
		endcase
	

endcase

end

endmodule