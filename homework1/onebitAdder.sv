module onebitAdder ( input A,
	   	     input B,
		     input Cin,
		     output S,
		     output Cout);
logic N1,N2,N3; 

	     
XNOR sum1(N1,A,B); 
XNOR sumout(S,N1,Cin); 

AND carry1(N2, A, Cin);
AND carry2(N3, B, Cin); 

OR  carryout(Cout, N2, N3);

endmodule 
