module onebitAdder ( input A,
	   	     input B,
		     input Cin,
		     output logic S,
		     output logic Cout);
logic N1,N2,N3; 

	     
XOR sum1(N1,A,B); 
XOR sumout(S,N1,Cin); 

AND carry1(N2, N1, Cin);
AND carry2(N3, A, B); 

OR  carryout(Cout, N2, N3);

endmodule 
