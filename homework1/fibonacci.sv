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

/* wires */ 
logic [DATA_WIDTH-1:0] data_A; 
logic [DATA_WIDTH-1:0] data_B;
logic [DATA_WIDTH-1:0] data_sum; 
logic Cin; 
logic Cout;

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
				 
always_ff @ (posedge clk or negedge reset_n)
begin
	if(!reset_n) begin 
		currentState <= RESET; 
		count <= '0; 
	    // clear <= '0;
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
			ERROR: begin
				   if(clear) begin
						nextState <= IDLE; 
				   end 
				   else begin 
				        error = '1;  
						nextState <= ERROR; 
				   end 
			end 
			ADD: begin 
					data_A <= (count < 2) ? data_in : prevcurrent;
					data_B <= (count < 2) ? '0 :prevprev;
					prevprev <= data_A; 
					count <= (prevcurrent != data_sum)? count : count + 1;
					prevcurrent <= data_sum;
					// done <= (count == order) ? 1:0; 
					// overflw <= (Cout == 1) ? 1:0; 
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
			DONE: begin
				  done <= '1; 	
				  data_out <= data_sum;
				  nextState <= IDLE; 
			end 
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


/* 

// Next state logic / 
always_comb begin 
	nextState = currentState; 
	case(currentState)
		RESET: begin
			   if(reset_n) begin
					nextState = IDLE; 
			   end
		end 
		IDLE: begin
			  if(load) begin
					nextState = LOAD; 
			  end 
			  else begin
					nextState = IDLE; 
			  end 
		end 
		LOAD: begin
			  if((order == '0) || (data_in == '0)) begin 
					nextState = ERROR; 
			  end 
			  else begin 
					nextState = ADD; 
			  end 		
		end 
		ERROR: begin
			   if(clear) begin
					nextState = IDLE; 
			   end 
			   else begin 
					nextState = ERROR; 
			   end 
		end 
		ADD: begin 
			   // if(done) begin 
					// nextState = DONE; 
			   // end 
			   // else if(overflw) begin 
					// nextState = OVRFLW; 
			   // end 
			   // else begin 
					nextState = ADD; 
			   // end 
		end 
		DONE: begin
			  nextState = IDLE; 
		end 
		OVRFLW: begin 
			    if(clear) begin 
					nextState = IDLE; 
				end 
				else begin 
					nextState = OVRFLW; 
				end 
		end 
	endcase 
end 

// Combinational Logic // 
always_comb begin
	case(currentState)
		RESET: begin 
			   clear = '0; data_out = '0; done = '0; overflw = '0; 
			   tempA = '0; tempB = '0; data_sum = '0; Cout = '0; 
			   prevcurrent = '0; prevprev = '0; tempCin = '0; 
		end 
		IDLE: begin 
			   tempA = '0; tempA = '0; prevcurrent = '0; prevprev = '0; 
			   clear = '0; done = '0; overflw = '0; tempCin = '0; 
		end 
		LOAD: begin 
			  prevprev = data_in; 
			  prevcurrent = '0; tempCin = '0; 
		end 
		ERROR: begin
			  clear = '1; data_out = '0; 
		end 
		ADD: begin
			   data_A = prevprev;
			   data_B = prevcurrent;
			   prevprev = prevcurrent; 
			   prevcurrent = data_sum; 
			   // if(count==order-1) begin 
					// data_out = tempS; 
					// done = '1; 
			   // end
			   // else if(Cout) begin
					// data_out = '1; 
					// overflw = '1; 
			   // end
   			   // count = count + 1;
		end 
		DONE: begin
			   done = '1; 
		end 
		OVRFLW: begin 
			   overflw = '1;  
		end		
	endcase
end  
 */
endmodule 

