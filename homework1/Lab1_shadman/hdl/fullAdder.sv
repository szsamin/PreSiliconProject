// =======================================================================
//   Filename:     fullAdder.v
//   Created by:   Shadman Zaman Samin
//   Date:         April 10th, 2017
//
//   Description:  This module intantiates the hardware level one bit adder 
// 				   The design is a generic N bit ripple carry adder. The design use wires
//				   to carry the carryout signal into each of the One bit adder blocks 
// =======================================================================

`timescale 1ns/1ps

module fullAdder(A,B,Cin,S,Cout); 

/* Width Parameter */ 
parameter width = 64; 

/* Input signals */ 	
input [width-1:0] A;
input [width-1:0] B;
input Cin;

/* Output Signals */ 
output logic [width-1:0] S;
output logic Cout;

/* Carry signal wires */ 
logic [width-1:0] Nwires; 
genvar i;

/* Use generate to instiate N modules for a N bit Carry Adder */ 
generate
for(i = 0; i < width; i++)
begin: onebitAdder_initilization
	/* If counter is 0. Set the carry in and initialize the carry out wire to be used in the next block */ 
    if(i==0) begin
	onebitAdder nadder(
				.A(A[i]),
				.B(B[i]),
				.Cin(Cin),
				.S(S[i]),
				.Cout(Nwires[i]));	
	end
	/* if this is the last counter set the Carry out signal to Cout */ 
	else if(i == width-1) begin
	onebitAdder nadder(
				.A(A[i]),
				.B(B[i]),
				.Cin(Nwires[i-1]),
				.S(S[i]),
				.Cout(Cout));
	end
	/* If counter is not the first or last then use the previous wire as the carry in and next wire as carry out */ 
	else begin
	onebitAdder nadder(
				.A(A[i]),
				.B(B[i]),
				.Cin(Nwires[i-1]),
				.S(S[i]),
				.Cout(Nwires[i]));
	end 
end
endgenerate 

endmodule 
