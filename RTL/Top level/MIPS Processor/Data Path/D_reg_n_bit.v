module D_reg_n_bit #(parameter n=32) (
	
	input clk,reset_n,en,
	input [n-1:0] D,
	output [n-1:0] Q

);
reg [n - 1:0] Q_next, Q_reg;
    
always@(posedge clk,negedge reset_n)
    begin
        if(~reset_n)
            Q_reg <= 'b0;
        else if(en)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
always@(D)
        Q_next = D;
    
 assign Q = Q_reg;

endmodule