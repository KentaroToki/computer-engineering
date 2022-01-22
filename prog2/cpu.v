module cpu(
	clk, rst, adrs, din, dout, mem_read, mem_write, 
	pr, mar, ir, gr, sc );
	
	input  clk, rst;
	output [7:0] adrs;
	input  [7:0] din;
	output [7:0] dout;
	output mem_read;
	output mem_write;
	output [7:0] pr, mar, ir, gr;
	output [2:0] sc;
	
	wire   [7:0] a, b;
	wire   [7:0] y;
	wire   [1:0] alu_sel;
	wire   a_sel, pr_load, mar_load, ir_load, gr_load, sc_clear;
	
	assign a = ( a_sel == 1'b1 ) ? gr : pr;
	assign b = ( mem_read == 1'b1 ) ? din : 8'bxxxxxxxx;
	assign adrs = ( mem_read | mem_write == 1'b1 ) ? mar : 8'bxxxxxxxx;
	assign dout = ( mem_write == 1'b1 ) ? y : 8'bxxxxxxxx;
	
	reg8 reg_pr(  .clk(clk), .rst(rst), .load(pr_load),  .d(y), .q(pr)  );
	reg8 reg_mar( .clk(clk), .rst(rst), .load(mar_load), .d(y), .q(mar) );
	reg8 reg_ir(  .clk(clk), .rst(rst), .load(ir_load),  .d(y), .q(ir)  );
	reg8 reg_gr(  .clk(clk), .rst(rst), .load(gr_load),  .d(y), .q(gr)  );
	
	alu alu( .a(a), .b(b), .sel(alu_sel), .y(y) );
	
	cnt3 cnt_sc( .clk(clk), .rst(rst), .clear(sc_clear), .q(sc) );
	
	csg csg(
		.sc(sc), .ir(ir),
		.alu_sel(alu_sel), .a_sel(a_sel), 
		.pr_load(pr_load), .mar_load(mar_load), .ir_load(ir_load), .gr_load(gr_load), 
		.mem_read(mem_read), .mem_write(mem_write), .sc_clear(sc_clear) );
	
endmodule

module reg8(
	clk, rst, load, d, q );
	
	input  clk, rst, load;
	input  [7:0] d;
	output [7:0] q;
	reg    [7:0] q;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			q <= 8'h00;
		end else if( load == 1'b1 ) begin
			q <= d;
		end
	end
endmodule

module cnt3(
	clk, rst, clear, q );
	
	input  clk, rst, clear;
	output [2:0] q;
	reg    [2:0] q;
	
	always@( posedge clk or negedge rst ) begin
		if( rst == 1'b0 ) begin
			q <= 3'h0;
		end else if( clear == 1'b1 ) begin
			q <= 3'h0;
		end else begin
			q <= q + 3'h1;
		end
	end
endmodule

module alu(
	a, b, sel, y );
	
	input  [7:0] a, b;
	input  [1:0] sel;
	output [7:0] y;
	reg    [7:0] y;
	
	always@( a or b or sel ) begin
		case( sel )
			2'b00 : y <= a;
			2'b01 : y <= b;
			2'b10 : y <= a + 1'b1;
			2'b11 : y <= a + b;
			default: y <= 8'hxx;
		endcase
	end
endmodule

module csg(
	sc, ir,
	alu_sel, a_sel, pr_load, mar_load, ir_load, gr_load,
	mem_read, mem_write, sc_clear );
	
	input  [7:0] ir;
	input  [2:0] sc;
	
	output [1:0] alu_sel;
	output a_sel, pr_load, mar_load, ir_load, gr_load;
	output mem_read, mem_write;
	output sc_clear;
	
	reg    [1:0] alu_sel;
	reg    a_sel, pr_load, mar_load, ir_load, gr_load;
	reg    mem_read, mem_write;
	reg    sc_clear;
	
	always@( ir or sc ) begin
		/* default */
		alu_sel   <= 2'bxx;
		a_sel     <= 1'bx;
		pr_load   <= 1'b0;
		mar_load  <= 1'b0;
		ir_load   <= 1'b0;
		gr_load   <= 1'b0;
		mem_read  <= 1'b0;
		mem_write <= 1'b0;
		sc_clear  <= 1'b0;
		
		case( sc )
			3'h0 : 
			begin /* 0: MAR ← PR */
				a_sel <= 1'b0;
				alu_sel <= 2'b00;
				mar_load <= 1'b1;
			end
			3'h1 :
			begin /* 1: PR ← PR + 1 */
				a_sel <= 1'b0;
				alu_sel <= 2'b10;
				pr_load <= 1'b1;
			end
			3'h2 :
			begin /* 2: IR ← MEM[MAR] */
				mem_read <= 1'b1;
				alu_sel <= 2'b01;
				ir_load <= 1'b1;
			end
			3'h3 :
			begin
				case( ir )
					8'h01, 8'h02, 8'h03,
					8'h04, 8'h05, 8'h06: /* defined */
					begin /* 3: PR ← MAR */
						a_sel <= 1'b0;
						alu_sel <= 2'b00;
						mar_load <= 1'b1;
					end
					default: /* undefined */
					begin /* 3: */
						sc_clear <= 1'b1;
					end
				endcase
			end
			3'h4 :
			begin /* 4: PR ← PR + 1 */
				a_sel <= 1'b0;
				alu_sel <= 2'b10;
				pr_load <= 1'b1;
			end
			3'h5 :
			begin
				case( ir )
					8'h1 : /* LDI */
					begin /* 5: GR ← MEM[MAR] */
						mem_read <= 1'b1;
						alu_sel <= 2'b01;
						gr_load <= 1'b1;
						sc_clear <= 1'b1;
					end
					8'h3 : /* ADDI */
					begin /* 5: GR ← GR + MEM[MAR] */
						a_sel  <= 1'b1;
						mem_read <= 1'b1;
						alu_sel <= 2'b11;
						gr_load <= 1'b1;
						sc_clear <= 1'b1;
					end
					8'h6 : /* JUMP */
					begin /* 5: PR ← MEM[MAR] */
						mem_read <= 1'b1;
						alu_sel <= 2'b01;
						pr_load <= 1'b1;
						sc_clear <= 1'b1;
					end
					8'h2, 8'h4, 8'h5:
					begin /* 5: MAR ← MEM[MAR] */
						mem_read <= 1'b1;
						alu_sel <= 2'b01;
						mar_load <= 1'b1;
					end
					default:;
				endcase
			end
			3'h6 :
			begin
				case( ir )
					8'h2 : /* LD */
					begin /* 6: GR ← MEM[MAR] */
						mem_read <= 1'b1;
						alu_sel <= 2'b01;
						gr_load <= 1'b1;
						sc_clear <= 1'b1;
					end
					8'h4 : /* ADD */
					begin /* 6: GR ← GR + MEM[MAR] */
						a_sel  <= 1'b1;
						mem_read <= 1'b1;
						alu_sel <= 2'b11;
						gr_load <= 1'b1;
						sc_clear <= 1'b1;
					end
					8'h5 : /* ST */
					begin /* 6: MEM[MAR] ← GR */
						a_sel <= 1'b1;
						alu_sel <= 2'b00;
						mem_write <= 1'b1;
						sc_clear <= 1'b1;
					end
					default:;
				endcase
			end
			default:;
		endcase
	end
endmodule
