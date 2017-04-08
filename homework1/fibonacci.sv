module fibonacci(clk, reset_n, load, data_in, order, data_out, done)

parameter width = 64; 

input clk;
input reset_n;
input load;
input logic [width-1:0] data_in; 
input logic [width-1:0] order;

output data_out; 
output done;

logic [width-1:0] data_A; 
logic [width-1:0] data_B; 
logic Cin; 
logic Cout;  

typedef enum logic[7:0] { RESET, IDLE, LOAD, ERROR, ADD, OVRFLW, DONE} states; 
						  
states currentState,nextState;

/* Module instantiation */ 
fullAdder adder1(
					.A(),
					.B(),
					.Cin(),
					.S(), 
					.Cout()); 

always_ff @ (posedge clk or posedge reset_n)
begin
	if(reset_n) begin 
		currentState <= RESET; 
	end
	else begin 
		currentState <= nextState; 
	end 
end 

/* Next state logic */ 
always_comb begin 

end 

/* Combinational Logic */ 
always_comb begin 


end  


