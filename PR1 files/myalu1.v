// Designed ALU for MIPS CPU based on ALU4.vl
// author: Tyler MacNeil, Eric Smith
// data: March 3, 2016
// Iteration: 1
//
// Notes: Includes test from the ALU4.vl to confirm that it works

module ALU(op,a,b,result,zero);

	input [15:0] a,b;
	input [2:0] op;
	output [15:0] result;
	output zero;
	wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
	
	ALU1	alu0  (a[0], b[0], op[2],op[1:0],set,op[2],c1, result[0]),
			alu1  (a[1], b[1], op[2],op[1:0],0,  c1,   c2, result[1]),
			alu2  (a[2], b[2], op[2],op[1:0],0,  c2,   c3, result[2]),
			alu3  (a[3], b[3], op[2],op[1:0],0,  c3,   c4, result[3]),
			alu4  (a[4], b[4], op[2],op[1:0],0,  c4,   c5, result[4]),
			alu5  (a[5], b[5], op[2],op[1:0],0,  c5,   c6, result[5]),
			alu6  (a[6], b[6], op[2],op[1:0],0,  c6,   c7, result[6]),
			alu7  (a[7], b[7], op[2],op[1:0],0,  c7,   c8, result[7]),
			alu8  (a[8], b[8], op[2],op[1:0],0,  c8,   c9, result[8]),
			alu9  (a[9], b[9], op[2],op[1:0],0,  c9,   c10,result[9]),
			alu10 (a[10],b[10],op[2],op[1:0],0,  c10,  c11,result[10]),
			alu11 (a[11],b[11],op[2],op[1:0],0,  c11,  c12,result[11]),
			alu12 (a[12],b[12],op[2],op[1:0],0,  c12,  c13,result[12]),
			alu13 (a[13],b[13],op[2],op[1:0],0,  c13,  c14,result[13]),
			alu14 (a[14],b[14],op[2],op[1:0],0,  c14,  c15,result[14]);
		 
	ALUmsb	alu15 (a[15],b[15],op[2],op[1:0],0,  c15,  c16,result[15],set);

//Method 1
//	or or1(orbundle,result[0], result[1], result[2], result[3],
//					result[4], result[5], result[6], result[7],
//		            result[8], result[9], result[10],result[11],
//					result[12],result[13],result[14],result[15]);
//	not not1(zero,orbundle);
//Method 2
	or or1(or01, result[0],result[1]);
	or or2(or23, result[2],result[3]);
	nor nor1(zero,or01,or23);

endmodule

module ALU1(a,b,binvert,op,less,carryin,carryout,result);

	input a,b,less,carryin,binvert;
	input [1:0] op;
	output carryout,result;
	wire sum,a_and_b,a_or_b,b_inv;
	
	not not1(b_inv, b);
	mux2x1 mux1(b,b_inv,binvert,b1);
	and and1(a_and_b, a, b);
	or or1(a_or_b, a, b);
	fulladder adder1(sum,carryout,a,b1,carryin);
	mux4x1 mux2(a_and_b,a_or_b,sum,less,op[1:0],result); 

endmodule

module ALUmsb(a,b,binvert,op,less,carryin,carryout,result,sum);

	input a,b,less,carryin,binvert;
	input [1:0] op;
	output carryout,result,sum;
	wire sum,a_and_b,a_or_b,b_inv;
	
	not not1(b_inv, b);
	mux2x1 mux1(b,b_inv,binvert,b1);
	and and1(a_and_b, a, b);
	or or1(a_or_b, a, b);
	fulladder adder1(sum,carryout,a,b1,carryin);
	mux4x1 mux2(a_and_b,a_or_b,sum,less,op[1:0],result); 

endmodule

// Components

module halfadder(S,C,x,y);

	input x,y; 
	output S,C; 

	xor (S,x,y); 
	and (C,x,y);

endmodule

module fulladder(S,C,x,y,z);

	input x,y,z; 
	output S,C; 
	wire S1,D1,D2;

	halfadder HA1 (S1,D1,x,y), 
              HA2 (S,D2,S1,z); 
	or g1(C,D2,D1);

endmodule

module mux2x1(A,B,select,OUT);

	input A,B,select;
	output OUT;
	wire S_inv,wire1,wire2;
	
	not not1(S_inv, select);
	and and1(wire1,A,S_inv),
		and2(wire2,B,select);
	or or1(OUT,wire1,wire2);

endmodule

module mux4x1(i0,i1,i2,i3,select,y);

	input i0,i1,i2,i3;
	input [1:0] select;
	output y;
	wire S0,S1,w1,w2,w3,w4;
	
	not not1(S0,select[0]),
		not2(S1,select[1]);
	
	and and1(w1,i0,S1,S0),
		and2(w2,i1,S1,select[0]),
		and3(w3,i2,select[1],S0),
		and4(w4,i3,select[1],select[0]);
		
	or  or1(y,w1,w2,w3,w4);

endmodule


// Test Module 

module testALU;
   reg [3:0] a;
   reg [3:0] b;
   reg [2:0] op;
   wire [3:0] result;
   wire zero;
	
   ALU alu (op,a,b,result,zero);
	
   initial
      begin

	    op = 3'b000; a = 4'b0111; b = 4'b0001;  // AND
	#10 op = 3'b001; a = 4'b0101; b = 4'b0010;  // OR

	#10 op = 3'b010; a = 4'b0101; b = 4'b0001;  // ADD
	#10 op = 3'b010; a = 4'b0111; b = 4'b0001;  // ADD
	#10 op = 3'b110; a = 4'b0101; b = 4'b0001;  // SUB
	#10 op = 3'b110; a = 4'b1111; b = 4'b0001;  // SUB
	#10 op = 3'b111; a = 4'b0101; b = 4'b0001;  // SLT
	#10 op = 3'b111; a = 4'b1110; b = 4'b1111;  // SLT

      end

   initial
    $monitor ("op = %b a = %b b = %b result = %b zero = %b",op,a,b,result,zero);

endmodule


/* Test Results

C:\Verilog>iverilog -o t ALU4.vl

C:\Verilog>vvp t
op = 000 a = 0111 b = 0001 result = 0001 zero = 0
op = 001 a = 0101 b = 0010 result = 0111 zero = 0
op = 010 a = 0101 b = 0001 result = 0110 zero = 0
op = 010 a = 0111 b = 0001 result = 1000 zero = 0
op = 110 a = 0101 b = 0001 result = 0100 zero = 0
op = 110 a = 1111 b = 0001 result = 1110 zero = 0
op = 111 a = 0101 b = 0001 result = 0000 zero = 1
op = 111 a = 1110 b = 1111 result = 0001 zero = 0

*/
