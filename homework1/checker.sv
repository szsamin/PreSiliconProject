// =======================================================================
//   Filename:     checker.sv
//   Created by:   Shadman Samin 
//   Date:         April 13th, 2017
//
//   Description:  Top level Checker Designed to use assertion to check for 
//				   correct data at the output 
// =======================================================================
`timescale 1ns/1ps

`define DATA_WIDTH 64
`define FIB_ORDER  16

module fib_gen_chkr(
   input                   clk,
   input                   reset_n,
   input                   load,
   input                   clear,
   input [`FIB_ORDER-1:0]  order,
   input [`DATA_WIDTH-1:0] data_in,
   input                    done,
   input                    error,
   input                    overflow,
   input  [`DATA_WIDTH-1:0] data_out
);

/* Checker assertion */ 

/* Sequence Defines:
   |-> :: RHS Evaluated and looked at @ the same clock edge 
   |=> :: LHS Evaluated and looked at @ the next clock edge
   ##[X:Y] :: between clocks X and Y 
   $isunknown :: returns 1 if output is X or Z 
*/ 

/* Check 1 */ 
/* When reset_n is assserted (driven to 0), all outputs must becomes
   0 within 1 clock cycle
 */ 
property check1; // NOT WORKING
	@(posedge clk) !reset_n ##[0:1] ((data_out === '0) && (error=== '0) &&  (done === '0) && (overflow === '0));
endproperty

/* Check 2 */ 
/* When load is asserted, valid data_in and valid order (no X or Z) 
   must be driven on the same cycle 
 */ 
property check2; 
	@(posedge clk)
	load |-> ((!$isunknown(data_in)) && (!$isunknown(order))) ;
endproperty

/* Check 3 */ 
/* One done is asserted, output data_out must be correct 
   on the same cycle
 */ 
property check3; // NOT WORKING
	@(posedge clk)
	done |-> golden_data_check(data_in,order,data_out);
endproperty

/* Check 4 */ 
/* Once overflow is asserted output data_out must be all 1's on 
   the same cycle 
 */ 
property check4;
	@(posedge clk)
	overflow |-> (data_out === '1);
endproperty

/* Check 5 */ 
/* Once error is asserted, output data_out must be al x's 
   on the same cycle 
 */ 
property check5; // NOT WORKING
	@(posedge clk)
	error |-> $isunknown(data_out);
endproperty

/* Check 6 */ 
/* Unless its an error or overflow condition, done and correct data
   must show up on the output 'order+2' cycles after load is asserted
 */ 
property check6; // NOT WORKING
	@(posedge clk)
	(!error && !overflow && load) ##10 (done && golden_data_check(data_in,order,data_out));
endproperty

function logic golden_data_check; 
	input [`DATA_WIDTH-1:0] data_in;
	input [`FIB_ORDER-1:0] order;
	input [`DATA_WIDTH-1:0] data_out;
	
	int currentprevious; 
	int previousprevious; 
	int output_data;
	begin 
		for (int i = 1; i < order; i++) begin
			currentprevious = (i < 2) ? data_in : currentprevious; 
			previousprevious = (i<2) ? 0: previousprevious; 
			output_data = currentprevious + previousprevious; 
			previousprevious = currentprevious; 
			currentprevious = output_data;
		end 
		golden_data_check = (output_data === data_out);
	end
endfunction 

//assert_check1 : assert property (check1) else $display("Checker Scenerio 1 failed"); 
assert_check2 : assert property (check2) else $display("Checker Scenerio 2 failed");
assert_check3 : assert property (check3) else $display("Checker Scenerio 3 failed");
assert_check4 : assert property (check4) else $display("Checker Scenerio 4 failed");
assert_check5 : assert property (check5) else $display("Checker Scenerio 5 failed");
//assert_check6 : assert property (check6) else $display("Checker Scenerio 6 failed");

endmodule 