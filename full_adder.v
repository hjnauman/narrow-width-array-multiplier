module full_adder 
  (
   a,
   b,
   carry_in,
   sum,
   carry_out
   );
 
  input  a;
  input  b;
  input  carry_in;
  output sum;
  output carry_out;
 
  wire   w_WIRE_1;
  wire   w_WIRE_2;
  wire   w_WIRE_3;
       
  assign w_WIRE_1 = a ^ b;
  assign w_WIRE_2 = w_WIRE_1 & carry_in;
  assign w_WIRE_3 = a & b;
 
  assign sum   = w_WIRE_1 ^ carry_in;
  assign carry_out = w_WIRE_2 | w_WIRE_3;

   
endmodule 