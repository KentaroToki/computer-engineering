`timescale 1ns/1ns

module div(clk, ld, a, b, y);
	input        clk; /* クロック */
	input        ld;  /* ロード */
	input  [3:0] a;   /* 剰余(被除数) */
	input  [3:0] b;   /* 除数 */
	output [3:0] y;   /* 商 */
	
	reg [7:0] ra; /* 剰余レジスタ */
	reg [7:0] rb; /* 除数レジスタ */
	reg [3:0] ry; /* 商レジスタ */
	
	/* 以下を記述 */
	always@(posedge clk) begin
		if(ld == 1'b1) begin
			ra <= {4'b0000, a};
		end else if(rb <= 8'b00000001) begin
			ra <= ra;
		end else if(ra >= rb) begin
			ra <= ra - rb;
		end
	end

	always@(posedge clk) begin
		if(ld == 1'b1) begin
			rb <= {1'b0, b, 3'b000};
		end else begin
			rb <= {1'b0, rb[7:1]};
		end
	end

	always@(posedge clk) begin
		if(ld == 1'b1) begin
			ry <= 4'b0000;
		end else if(rb <= 8'b00000001) begin
			ry <= ry;
		end else if(ra >= rb) begin
			ry <= {ry[2:0], 1'b1};
		end else begin
			ry <= {ry[2:0], 1'b0};
		end
	end
	/* ここまで */
	
	assign y = ry;
	
endmodule
