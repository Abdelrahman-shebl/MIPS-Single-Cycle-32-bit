module Data_mem (
	
	input clk,
	input [31:0] A,
	input WE,
	input [31:0] WD,
	output [31:0] RD

);
reg [31:0] mem [127:0];

integer i;

initial
begin
    for (i = 0; i < 128; i = i + 1)  // Loop through all memory locations
        mem[i] = 32'b0;        // Set each memory location to 0
end

always @ (posedge clk)
begin
		if (WE)
		mem [A] <= WD;
end

assign RD =mem[A];

endmodule