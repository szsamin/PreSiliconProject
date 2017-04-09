module tb;

parameter width = 64; 

/* Wires to use with the instantiations */ 
logic onebit_A,onebit_B,onebit_S, onebit_Cin, onebit_Cout; 

logic [width-1:0] data_A, data_B, data_sum; 
logic Cin,Cout;  

/* Module instantiation Full Adder */ 
fullAdder adder1(
					.A(data_A),
					.B(data_B),
					.Cin(Cin),
					.S(data_sum), 
					.Cout(Cout)); 
					

/* Module instantiation One bit Adder */ 
	onebitAdder nadder(
				.A(onebit_A),
				.B(onebit_B),
				.Cin(onebit_Cin),
				.S(onebit_S),
				.Cout(onebit_Cout));
				

initial begin
	/* initialization */ 
	onebit_A = '0; onebit_B = '0; onebit_Cin = '0;
	data_A = '0; data_B = '0; Cin = '0;
	#100 onebit_A = '1; onebit_B = '0; onebit_Cin = '0; 
	#100 onebit_A = '0; onebit_B = '1; onebit_Cin = '0; 
	#100 onebit_A = '1; onebit_B = '1; onebit_Cin = '0; 
	#100 onebit_A = '0; onebit_B = '0; onebit_Cin = '1; 
	#100 onebit_A = '1; onebit_B = '0; onebit_Cin = '1; 
	#100 onebit_A = '0; onebit_B = '1; onebit_Cin = '1; 
	#100 onebit_A = '1; onebit_B = '1; onebit_Cin = '1; 
	#500 $finish;


end 


endmodule 
					

