module main_decoder (
	
	input [5:0] opcode,
	
	output reg MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump,
	output reg [1:0] ALUOp
	

);

always @ (*)
begin
RegWrite=1'b0;
RegDst=1'b0;
ALUSrc=1'b0;
Branch=1'b0;
MemWrite=1'b0;
MemtoReg=1'b0;
ALUOp=2'b00;
Jump=1'b0;
casex(opcode)
	
	6'b000000 : begin //R-type
		RegWrite=1'b1;
		RegDst=1'b1;
		ALUSrc=1'b0;
		Branch=1'b0;
		MemWrite=1'b0;
		MemtoReg=1'b0;
		ALUOp=2'b10;
		Jump=1'b0;
	end
	
	6'b100011 : begin //lw
		RegWrite=1'b1;
		RegDst=1'b0;
		ALUSrc=1'b1;
		Branch=1'b0;
		MemWrite=1'b0;
		MemtoReg=1'b1;
		ALUOp=2'b00;
		Jump=1'b0;
	end
	
	6'b101011 : begin //sw
		RegWrite=1'b0;
		RegDst=1'b0;
		ALUSrc=1'b1;
		Branch=1'b0;
		MemWrite=1'b1;
		MemtoReg=1'b0;
		ALUOp=2'b00;
		Jump=1'b0;
	end
	
	6'b000100 : begin //beq
		RegWrite=1'b0;
		RegDst=1'b0;
		ALUSrc=1'b0;
		Branch=1'b1;
		MemWrite=1'b0;
		MemtoReg=1'b0;
		ALUOp=2'b01;
		Jump=1'b0;
	end
	
	6'b001000 : begin //addi
		RegWrite=1'b1;
		RegDst=1'b0;
		ALUSrc=1'b1;
		Branch=1'b0;
		MemWrite=1'b0;
		MemtoReg=1'b0;
		ALUOp=2'b00;
		Jump=1'b0;
	end
	
	6'b000010 : begin //j
		RegWrite=1'b0;
		RegDst=1'b0;
		ALUSrc=1'b0;
		Branch=1'b0;
		MemWrite=1'b0;
		MemtoReg=1'b0;
		ALUOp=2'b00;
		Jump=1'b1;
	end
	
	default :begin
	
	RegWrite=1'b0;
    RegDst=1'b0;
    ALUSrc=1'b0;
    Branch=1'b0;
    MemWrite=1'b0;
    MemtoReg=1'b0;
    ALUOp=2'b00;
    Jump=1'b0;
	end


endcase

end

endmodule