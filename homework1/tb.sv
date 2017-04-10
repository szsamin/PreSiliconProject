`timescale 1ns/1ps

module tb;
/* Wires to use with the instantiations */ 
// logic onebit_A,onebit_B,onebit_S, onebit_Cin, onebit_Cout; 

// logic [width-1:0] data_A, data_B, data_sum; 
// logic Cin;

parameter DATA_WIDTH = 64;
parameter FIB_ORDER  = 16;


/* FSM Wires */ 
logic clk, reset_n, load, done, overflw, clear, error; 
logic [DATA_WIDTH-1:0] data_in, data_out;
logic [FIB_ORDER-1:0] order;    

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
				.overflw(overflw),
				.error(error));

/* FIB NUM Test module instantiation */ 
fib_num_test fibTest(
				.clk(clk),
				.reset_n(reset_n),
				.load(load),
				.clear(clear),
				.order(order),
				.data_in(data_in),
				.done(done),
				.error(error),
				.overflow(overflw),
				.data_out(data_out));



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
	clk = '0; 
	//reset_n = '0; clear = '0; 
	// #500 reset_n = '0; load = '0; data_in = '0; order = '0; 
	// #500 reset_n = '1; data_in = 1; order = 100; load = '1;
	// #5000 clear = '1; 
	// #5000 clear = '1; reset_n = '0; 
	// #5000 reset_n = '1; data_in = '0; order = '0; 
	// #100 data_A = 1; data_B = 1; Cin = '0; 
	// #100 data_A = 1; data_B = 1; Cin = '0; 
	// #100 data_A = 10; data_B = 10; Cin = '0; 
	// #100 data_A = 12; data_B = 0; Cin = '1; 
	// #100 data_A = 15; data_B = 15; Cin = '0;
	// #100 data_A = 25; data_B = 10; Cin = '0; 
	// #100 data_A = 1; data_B = 2; Cin = '0; 
	// #100 data_A = '1; data_B = '1; Cin = '0; 
	// #1000000 $finish;
end 


endmodule 
					

