// =======================================================================
//   Filename:     fibonacci.v
//   Created by:   Shadman Zaman Samin
//   Date:         April 10th, 2017
//
//   Description:  This is the top module for the Fibonacci FSM. 
//				   The FSM instantiates the lower level modules 
//				   and calculates the output value based on the initial 
//				   data_in and order number. 
// =======================================================================

`timescale 1ns/1ps

module fibonacci(clk, reset_n, clear, load, data_in, order, data_out, done, overflw, error);

/* input parameter */ 
parameter DATA_WIDTH = 64;
parameter FIB_ORDER  = 16;

/* input signals */ 
input clk;
input reset_n;
input load;
input clear; 
input logic [DATA_WIDTH-1:0] data_in; 
input logic [FIB_ORDER-1:0] order;

/* output signals */ 
output logic [DATA_WIDTH-1:0] data_out; 
output logic error, done, overflw;

/* Signal Wires */ 
logic [DATA_WIDTH-1:0] data_A; 
logic [DATA_WIDTH-1:0] data_B;
logic [DATA_WIDTH-1:0] data_sum; 
logic Cin; 
logic Cout;

/* Counter Intiation */ 
// The counter starts a value of 1
int count = '1; 		

/* wires */ 
logic [DATA_WIDTH-1:0] prevprev,prevcurrent, tempdata; 


typedef enum logic[7:0] { RESET, IDLE, LOAD, ERROR, ADD, OVRFLW, DONE} states; 
						  
states currentState,nextState;

/* Module instantiation */ 
fullAdder adder1(
					.A(data_A),
					.B(data_B),
					.Cin(Cin),
					.S(data_sum), 
					.Cout(Cout)); 

/* Designed the FSM using one block FSM instead of the standard three always* blocks */					
always_ff @ (posedge clk or negedge reset_n)
begin
	/* active low reset_n */ 
	if(!reset_n) begin 
		currentState <= RESET; 
		count <= '0; 
		data_out <= '0;
		done <= '0;
		error <= '0; 
		overflw <= '0; 
	    data_B <= '0;
		data_A <= '0;
		data_out <= '0; 
	    prevcurrent <= '0;
		prevprev <= '0;
		Cin <= '0; 
	end
	else begin 
		currentState <= nextState;
		case(currentState)
			/* Reset state */
			/* Invalidate everything if in reset state */ 
			/* Otherwise go into IDLE state */  
			RESET: begin
				   if(reset_n) begin	
						nextState <= IDLE; 
				   end
				   else begin 
				   	count <= '1; 
					// clear <= '0; 
					data_out <= '0;
					done <= '0;
					overflw <= '0; 
					error <= '0; 
					data_B <= '0;
					data_A <= '0;
					data_out <= '0; 
					prevcurrent <= '0;
					prevprev <= '0;
					Cin <= '0; 			
				   end 
			end 
			/* IDLE state */ 
			/* If in IDLE state stay in IDLE state if load is not asserted
			   otherwise stay in IDLE state 
			*/ 
			IDLE: begin
					count <= '1; 
					// clear <= '0;
					data_out <= '0;
					done <= '0; 
					overflw <= '0;
					error <= '0; 
					data_B <= '0;
					data_A <= '0; 
					data_out <= '0; 
					prevcurrent <= '0; 
					prevprev <= '0; 
					Cin <= '0; 			
				  if(load) begin
						nextState <= LOAD; 
				  end 
				  else begin
						nextState <= IDLE; 
				  end 
			end 
			/* LOAD state */
			/* If in LOAD state go back into IDLE if load is not asserted
			   else if order is equal to zero or initial data is zero go into the Error state 
			   otherwise go into the add state 
			*/
			LOAD: begin
				  if((order == '0) || (data_in == '0)) begin
						nextState <= ERROR; 
				  end
				  else if(!load) begin
						nextState <= IDLE; 
				  end 
				  else begin 
						nextState <= ADD; 
				  end 		
			end 
			/* ERROR state */ 
			/* If in ERROR state stay in ERROR state if clear is not asserted and assert error to one 
			   if Clear is asserted go into the IDLE state 			
			*/
			ERROR: begin
				   if(clear) begin
						nextState <= IDLE; 
				   end 
				   else begin 
				        error = '1;  
						nextState <= ERROR; 
				   end 
			end 
			/* ADD state */
			/* If in ADD state stay in ADD state if the counter hasn't reached the order provided by the user  
			   if the counter has reached the order go into the DONE state 
			   if Carry out is one go into the OVRFLW state 
			*/ 
			ADD: begin 
					data_A <= (count < 2) ? data_in : prevcurrent;
					data_B <= (count < 2) ? '0 :prevprev;
					prevprev <= data_A; 
					count <= (prevcurrent != data_sum)? count : count + 1;
					prevcurrent <= data_sum;
					if(count == order) begin
						nextState <= DONE; 
					end
					else if(Cout == 1) begin
						nextState <= OVRFLW; 
					end 
					else if(count < order) begin 
						nextState <= ADD;
					end
			end 
			/* DONE state */
			/* 
			   If in DONE state assert done to one and out the data. 
			*/ 
			DONE: begin
				  done <= '1; 	
				  data_out <= data_sum;
				  nextState <= IDLE; 
			end 
			/* OVRFLW state */ 
			/* 
			   If in OVRFLW state, stay in OVRFLW state and assert overflw to one and set data_out to MAX 
			   If clear is asserted go into IDLE state 
			*/ 
			OVRFLW: begin 
					if(clear) begin 
						nextState <= IDLE; 
					end 
					else begin
					    overflw <= '1; 
						data_out <= '1; 
						nextState <= OVRFLW; 
					end 
			end 
		endcase 
		end
end 
endmodule 

