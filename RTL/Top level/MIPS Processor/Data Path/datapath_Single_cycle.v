module datapath_Single_cycle (
	 input  clk,reset_n,
	 input  MemtoReg,PCSrc,
	 input  ALUSrc,RegDst,
	 input  RegWrite,Jump,
	 input  [2:0] ALUControl,
	 input  [31:0] ReadData,
	 input  [25:0] Instr,
	 output  [31:0] PC,
	 output [31:0] ALUOut,WriteData,
	 output  Zero
);

wire [31:0] ALUOut_w,WriteData_w;
wire [31:0] PCBranch,PCplus4;

D_reg_n_bit #( .n(32)) inst1 (
	
	.clk(clk),.reset_n(reset_n),.en(1'b1),
	.D(Jump? {PC[31:28],Instr[25:0],2'b00}:PCSrc? PCBranch :PCplus4),
	.Q(PC)

);

wire [31:0] RD1_2_out;

reg_file inst2 (
	
	.clk(clk),
	.A1(Instr[25:21]),.A2(Instr[20:16]),.A3(RegDst?Instr[15:11]:Instr[20:16]),
	.WE3(RegWrite),
	.WD3(MemtoReg?ReadData: ALUOut_w),
	.RD1(RD1_2_out),.RD2(WriteData_w)

);
wire [31:0] signimm,signimm_s2;

sign_extend inst3 (

	.imm(Instr[15:0]),
	.imm_ext(signimm)
);

ALU data_adder (

	.A(RD1_2_out),.B(ALUSrc ? signimm:WriteData_w ),
	.F(ALUControl),
	.zero(Zero),.overflow(),
	.carry(),
	.Y(ALUOut_w)

);


ALU pc_adder (

	.A(PC),.B(32'd4),
	.F(3'b010),
	.zero(),.overflow(),
	.carry(),
	.Y(PCplus4)

);

shifter s1(
   .a(signimm),
   .y(signimm_s2)
);
ALU Branch_adder (

	.A(signimm_s2),.B(PCplus4),
	.F(3'b010),
	.zero(),.overflow(),
	.carry(),
	.Y(PCBranch)

);

assign ALUOut= ALUOut_w;
assign WriteData=WriteData_w;

endmodule