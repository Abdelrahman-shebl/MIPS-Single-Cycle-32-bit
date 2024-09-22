
module Control_Unit (

  input [5:0] funct,Op,
  input Zero,
  output RegWrite,MemtoReg,MemWrite,ALUSrc,RegDst,Jump,PCSrc,
  output [2:0] ALUControl
  
);

wire [1:0] ALUOp;
wire Branch;
assign PCSrc = Branch & Zero ;

// Instantiate the main_decoder
main_decoder MD (
    .opcode(Op), 
    .MemtoReg(MemtoReg), 
    .MemWrite(MemWrite), 
    .Branch(Branch), 
    .ALUSrc(ALUSrc), 
    .RegDst(RegDst), 
    .RegWrite(RegWrite), 
    .Jump(Jump), 
    .ALUOp(ALUOp)
  );
  


  // Instantiate the ALU_Decoder
  ALU_Decoder AD (
    .funct(funct), 
    .ALUOp(ALUOp), 
    .ALUControl(ALUControl)
  );
 



endmodule