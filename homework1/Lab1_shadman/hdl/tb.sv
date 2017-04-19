// =======================================================================
//   Filename:     tb.v
//   Created by:   Shadman Samin 
//   Date:         April 10th, 2017
//
//   Description:  Top level 
// =======================================================================

`timescale 1ns/1ps

module tb;

/* Initial Parameters */ 
parameter DATA_WIDTH = 64;
parameter FIB_ORDER  = 16;
parameter CLOCK_PERIOD = 10; 
parameter CLOCK_WIDTH = CLOCK_PERIOD/2; 


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

/* 10 ns Period clock */ 				
initial begin 
	forever
	#CLOCK_WIDTH clk = ~clk; 
end 

initial begin
	clk = '0; 
end 


endmodule 
					

