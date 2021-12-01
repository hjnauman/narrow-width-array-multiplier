`include "full_adder.v"
 
module ripple_carry_adder 
    #(parameter WIDTH = 4)
    (
        input carry_in,
        input [WIDTH-1:0] a,
        input [WIDTH-1:0] b,
        output [WIDTH-1:0]  sum,
        output carry_out
    );
     
    wire [WIDTH:0]     carry_bits;
    wire [WIDTH-1:0]   sum_bits;
   
    // No carry input on first full adder  
    assign carry_bits[0] = carry_in;        
   
    genvar             i;
    generate 
        for (i=0; i<WIDTH; i=i+1) 
        begin
            full_adder full_adder_inst
            ( 
                .a(a[i]),
                .b(b[i]),
                .carry_in(carry_bits[i]),
                .sum(sum_bits[i]),
                .carry_out(carry_bits[i+1])
            );
        end
    endgenerate
   
//   assign sum = {carry_bits[WIDTH], sum_bits};   // Verilog Concatenation
    assign sum = sum_bits;
    assign carry_out = carry_bits[WIDTH];
 
endmodule // ripple_carry_adder