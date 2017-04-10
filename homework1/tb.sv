module tb;

parameter width = 64; 

/* Wires to use with the instantiations */ 
// logic onebit_A,onebit_B,onebit_S, onebit_Cin, onebit_Cout; 

// logic [width-1:0] data_A, data_B, data_sum; 
// logic Cin;

/* FSM Wires */ 
logic clk, reset_n, load, done, overflw,clear; 
logic [width-1:0] data_in,order, data_out;   

/* Module FSM Instantiation */ 
fibonacci fsm(
				.clk(clk), 
				.reset_n(reset_n), 
				.clear(clear), 
				.load(load), 
				.data_in(data_in), 
				.order(order), 
				.data_out(data_out), 
				.done(done), 
				.overflw(overflw));


/* Module instantiation Full Adder */ 
// fullAdder adder1(
					// .A(data_A),
					// .B(data_B),
					// .Cin(Cin),
					// .S(data_sum), 
					// .Cout(Cout)); 
					

/* Module instantiation One bit Adder */ 
	// onebitAdder nadder(
				// .A(onebit_A),
				// .B(onebit_B),
				// .Cin(onebit_Cin),
				// .S(onebit_S),
				// .Cout(onebit_Cout));
				
initial begin 
	forever
	#5 clk = ~clk; 
end 

initial begin
	/* initialization */ 
	// onebit_A = '0; onebit_B = '0; onebit_Cin = '0;
	// data_A = '0; data_B = '0; 
	// Cin = '0; 
	clk = '0; reset_n = '0; clear = '0; 
	#500 reset_n = '0; load = '0; data_in = '0; order = '0; 
	#500 reset_n = '1; data_in = 1; order = 100; load = '1;
	#5000 clear = '1; 
	#5000 clear = '1; reset_n = '0; 
	#5000 reset_n = '1; data_in = '0; order = '0; 
	// #100 data_A = 1; data_B = 1; Cin = '0; 

	// #100 data_A = 1; data_B = 1; Cin = '0; 
	// #100 data_A = 10; data_B = 10; Cin = '0; 
	// #100 data_A = 12; data_B = 0; Cin = '1; 
	// #100 data_A = 15; data_B = 15; Cin = '0;
	// #100 data_A = 25; data_B = 10; Cin = '0; 
	// #100 data_A = 1; data_B = 2; Cin = '0; 
	// #100 data_A = '1; data_B = '1; Cin = '0; 
	
	#1000000 $finish;


end 


endmodule 
					

