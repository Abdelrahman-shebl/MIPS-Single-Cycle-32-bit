`timescale 1ns/1ps
module MipsTB ();

	reg clk,reset_n;
	wire MemWrite;
	wire [31:0] WriteData,DataAddr;

Top_level  uut(
	
	.clk(clk),.reset_n(reset_n),.WriteData(WriteData),.DataAddr(DataAddr),.MemWrite(MemWrite)
);

initial
begin
    reset_n = 0; #5 reset_n =1;
	
end

always
begin
	clk = 1; #5; clk =0; #5;
end

always @ (negedge clk)
begin
	if(DataAddr==0  )
	begin
		if(WriteData ==7 & MemWrite )begin
			$display("simulation Succeeded");
			$stop;
			end
		
	end
		
end
endmodule
	