module ALU (

	input [31:0] A,B,
	input [2:0] F,
	output zero,overflow,
	output reg carry,
	output reg [31:0] Y

);

always @(*)
begin
	
	Y=0;carry=0;
	case (F)
	3'b000: Y = A & B;
	3'b001: Y = A | B;
	3'b010: begin 
	{carry,Y} = A + B;
	end
	3'b100: Y = A & ~B;
	3'b101: Y = A | ~B;
	3'b110:begin 
	{carry,Y} = A - B;
	end
	3'b111: Y = A < B;
	default : begin
	Y=0;carry=0;
	end
	
	endcase

end

assign zero = (Y==0);
assign overflow = F==3'b010 & A[31] & B [31] & ~Y[31] |
						F==3'b110 & ~A[31] & ~B [31] & Y[31];

endmodule