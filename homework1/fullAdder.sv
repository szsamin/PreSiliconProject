module fullAdder(A,B,Cin,S,Cout); 

parameter width = 64; 

	
input [width-1:0] A;
input [width-1:0] B;
input Cin;
output [width-1:0] S;
output Cout;

logic [width-1:0] Nwires; 
genvar i;

generate
for(i = 0; i < width; i++)
begin: onebitAdder_initilization 
	onebitAdder(
		.A(A[i]),
		.B(B[i]),
		.Cin(Cin),
		.S(S[i]),
		.Cout(Cout)
	);
end
endgenerate 

endmodule 
