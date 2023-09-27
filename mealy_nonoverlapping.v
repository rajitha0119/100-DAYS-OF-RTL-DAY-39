`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2023 14:25:09
// Design Name: 
// Module Name: mealy_nonoverlapping
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mealy_nonoverlapping(input clk, rst, x, output z);
  parameter s0 = 2'b00;
  parameter s1 = 2'b01;
  parameter s2 = 2'b10;
  parameter s3 = 2'b11;
  
  reg [3:0] ps, ns;
  always @(posedge clk or negedge rst) begin
    if(!rst) begin 
      ps <= s0;
    end
    else ps <= ns;
  end
  
  always @(ps or x) begin
    case(ps)
      s0: begin
           if(x == 0) ns = s0;
           else       ns = s1;
         end
      s1: begin
           if(x == 0) ns= s2;
           else       ns= s1;
         end
      s2: begin
           if(x == 0) ns = s3;
           else       ns = s1;
         end
      s3: begin
        if(x == 0)    ns = s0; //This state only differs when compared with Mealy Overlaping Machine
           else       ns = s0;
         end
      default: ns = s0;
    endcase
  end
  assign z = (ps == s3)? 1:0;
endmodule
