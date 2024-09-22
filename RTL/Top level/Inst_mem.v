module Inst_mem (

	input [31:0] A,
	output [31:0] RD

);
reg [31:0] mem [63:0];
initial
	$readmemh("mem.txt",mem);


assign RD =mem[A>>2];
endmodule