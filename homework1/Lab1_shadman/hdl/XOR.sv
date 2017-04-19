// =======================================================================
//   Filename:     XOR.v
//   Created by:   Shadman Zaman Samin
//   Date:         April 10th, 2017
//
//   Description:  Hardware design for 2 input XOR gate 
// =======================================================================

`timescale 1ns/1ps

module XOR(out1,in1,in2);
/* Input signals */  
input in1,in2; 

/* Output signals */ 
output logic out1; 

/* Output assignment */ 
assign out1 = in1 ^ in2; 

endmodule 