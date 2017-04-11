// =======================================================================
//   Filename:     OR.v
//   Created by:   Shadman Zaman Samin
//   Date:         April 10th, 2017
//
//   Description:  Hardware design for 2 input OR gate 
// =======================================================================

`timescale 1ns/1ps

module OR(out1,in1,in2);

/* Input Signals */  
input in1,in2; 

/* Output Signals */ 
output logic out1; 

/* Output assignment */ 
assign out1 = in1 | in2; 

endmodule 