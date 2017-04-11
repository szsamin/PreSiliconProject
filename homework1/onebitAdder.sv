// =======================================================================
//   Filename:     onebitAdder.v
//   Created by:   Shadman Zaman Samin
//   Date:         April 10th, 2017
//
//   Description:  This module instiates the lower level AND,XOR and OR gates
//				   is used to design the gate level adder 
// =======================================================================

`timescale 1ns/1ps

module onebitAdder (A,B,Cin,S,Cout); 

/* Input Signal */ 
input A;
input B;
input Cin;

/* Output Signal */ 
output logic S;
output logic Cout;

/* Signal Wires between gates */ 
logic N1,N2,N3; 
	     
/* Module Intantiations */
XOR sum1(N1,A,B);               // XOR gate 
XOR sumout(S,N1,Cin); 			// XOR gate

AND carry1(N2, N1, Cin);        // AND gate 
AND carry2(N3, A, B); 			// AND gate 

OR  carryout(Cout, N2, N3);		// OR gate

endmodule 
