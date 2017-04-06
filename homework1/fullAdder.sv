module fullAdder #(  parameter Width = 64);
		   ( input [width-1:0] A,
	   	     input [width-1:0] B,
		     input Cin,
		     output [width-1:0] S,
		     output Cout);

logic [Width-1:0] Nwires; 

for(int i = 0; i < width; i++); 
begin: onebitAdder_initilization 
	onebitAdder(
		.A(A[i]),
		.B(B[i]),
		.Cin(Cin),
		.S(S[i]),
		.Cout(Cout)
	);


end

endmodule 
