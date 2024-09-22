
module MIPS_Single_Cycle (
  
  input clk,reset_n,
  output  [31:0] PC,ALUOut,WriteData,
  input [31:0] ReadData,
  input [31:0] Instr,
  output  MemWrite
);

wire [2:0] ALUControl ;
wire Zero,PCSrc,MemtoReg,ALUSrc,RegDst,RegWrite,Jump;


  
// Instantiate the Control Unit
  Control_Unit CU (
    .funct(Instr[5:0]), 
    .Op(Instr[31:26]), 
    .Zero(Zero), 
    .RegWrite(RegWrite), 
    .MemtoReg(MemtoReg), 
    .MemWrite(MemWrite), 
    .ALUSrc(ALUSrc), 
    .RegDst(RegDst), 
    .Jump(Jump), 
    .PCSrc(PCSrc), 
    .ALUControl(ALUControl)
  );
  

datapath_Single_cycle dp (
   .clk(clk),.reset_n(reset_n),
   .MemtoReg(MemtoReg),.PCSrc(PCSrc),
   .ALUSrc(ALUSrc),.RegDst(RegDst),
   .RegWrite(RegWrite),.Jump(Jump),
   .ALUControl(ALUControl),
   .Zero(Zero),
   .PC(PC),
   .Instr(Instr[25:0]),
   .ALUOut(ALUOut),.WriteData(WriteData),
   .ReadData(ReadData)
);


endmodule