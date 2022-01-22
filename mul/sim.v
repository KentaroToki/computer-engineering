module sim();
	reg  clk, rst, ld;
	reg  [3:0] a, b;
	wire [7:0] ra;
	wire [3:0] rb;
	wire [7:0] ry;
	
	mul mul( .clk(clk), .rst(rst), .ld(ld), .a(a), .b(b), .ra(ra), .rb(rb), .ry(ry) );
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		a = 4'b0011;
		b = 4'b1101;
		rst = 1'b1;
		ld = 1'b0;
		#15
		rst = 1'b0;
		#20
		rst = 1'b1;
		ld = 1'b1;
		#20
		ld = 1'b0;
	end
	
endmodule
