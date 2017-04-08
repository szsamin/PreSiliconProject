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
    if(i==1) begin 
	onebitAdder(.A(A[i]),
				.B(B[i]),
				.Cin(Cin),
				.S(S[i]),
				.Cout(Nwires[i]));	
	end
	else if(i == width-1) begin
	onebitAdder(.A(A[i]),
				.B(B[i]),
				.Cin(Nwires[i-1]),
				.S(S[i]),
				.Cout(Cout));
	end
	else begin 
	onebitAdder(.A(A[i]),
				.B(B[i]),
				.Cin(Nwires[i-1]),
				.S(S[i]),
				.Cout(Nwires[i]));
	end 
end
endgenerate 

endmodule 
