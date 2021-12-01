`timescale 1ns / 1ps

module narrow_array_multiplier_TB #(parameter WIDTH = 32);
  wire [(WIDTH*2)-1:0] product;
  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  reg [WIDTH-1:0] i, j;

  narrow_array_multiplier #(.WIDTH(WIDTH)) uut (a, b, product);
//  initial $monitor("a=%b,x=%b,p=%b,", a, x, p);

  initial
  begin
    a = 0;
    b = 0;
    i = 0;
    j = 0;
    for ( i=0 ; i< WIDTH; i = i + 1) begin
          a = a + 1'b1;
        b = 0;
        for( j = 0; j<WIDTH; j = j + 1) begin
            #2 b = b + 1'b1;
        end
    end
    #10 $finish;
    end
endmodule