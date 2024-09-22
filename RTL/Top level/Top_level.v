module Top_level (
	
	input clk,reset_n,
	output [31:0] DataAddr,WriteData,
	output MemWrite
	
);

wire [31:0] PC,ALUOut,Instr,ReadData;



//Instantiate the MIPS_Single_Cycle
  MIPS_Single_Cycle mips (
    .clk(clk),
    .reset_n(reset_n),
    .PC(PC),
    .ALUOut(DataAddr),
    .WriteData(WriteData),
    .ReadData(ReadData),
    .Instr(Instr),
    .MemWrite(MemWrite)
  );
 

Inst_mem  imem(
	
	.A(PC),
	.RD(Instr)

);

Data_mem dmem(
	
	.clk(clk),
	.A(DataAddr),
	.WE(MemWrite),
	.WD(WriteData),
	.RD(ReadData)

);

endmodule