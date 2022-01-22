module sim();
	reg  clk, rst, ld;
	reg  [3:0] a, b;
	wire [7:0] ra;
	wire [7:0] rb;
	wire [3:0] ry;
	
	div div( .clk(clk), .rst(rst), .ld(ld), .a(a), .b(b), .ra(ra), .rb(rb), .ry(ry) );
	
	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end
	
	initial begin
		a = 4'b1100;
		b = 4'b0100;
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
