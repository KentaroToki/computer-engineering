module rom(
	adrs, dout, rd );
	
	input  [7:0] adrs;
	output [7:0] dout;
	input  rd;
	
	reg    [7:0] rom_data;
	
	always@( adrs ) begin
		case( adrs )
			8'h00 : rom_data = 8'h01;//ldi 0
			8'h01 : rom_data = 8'h00;
			8'h02 : rom_data = 8'h05;//st 5 
			8'h03 : rom_data = 8'h21;
			8'h04 : rom_data = 8'h01;//ldi 0
			8'h05 : rom_data = 8'h00;
			8'h06 : rom_data = 8'h05;//st 20
			8'h07 : rom_data = 8'h20;
			8'h08 : rom_data = 8'h03;//addi 1
			8'h09 : rom_data = 8'h01;
			8'h0A : rom_data = 8'h05;//st 20
			8'h0B : rom_data = 8'h20;
			8'h0C : rom_data = 8'h02;//ld 21
			8'h0D : rom_data = 8'h21;
			8'h0E : rom_data = 8'h04;//add 20
			8'h0F : rom_data = 8'h20;
			8'h10 : rom_data = 8'h05;//st 21
			8'h11 : rom_data = 8'h21;
			8'h12 : rom_data = 8'h02;//ld 20
			8'h13 : rom_data = 8'h20;
			8'h14 : rom_data = 8'h06;//jmp 8
			8'h15 : rom_data = 8'h08;
			8'h16 : rom_data = 8'h00;
			8'h17 : rom_data = 8'h00;
			8'h18 : rom_data = 8'h00;
			8'h19 : rom_data = 8'h00;
			8'h1A : rom_data = 8'h00;
			8'h1B : rom_data = 8'h00;
			8'h1C : rom_data = 8'h00;
			8'h1D : rom_data = 8'h00;
			8'h1E : rom_data = 8'h00;
			8'h1F : rom_data = 8'h00;
			default : rom_data = 8'bxxxxxxxx;
		endcase
	end
	
	assign dout = ( rd == 1'b1 ) ? rom_data : 8'bxxxxxxxx;
	
endmodule
