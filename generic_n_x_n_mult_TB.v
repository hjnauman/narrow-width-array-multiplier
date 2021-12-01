`timescale 1ns / 1ps

module generic_n_x_n_mult_TB #(parameter WIDTH = 64);
  wire [(WIDTH*2) -1:0] p;
  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] x;
  reg [WIDTH-1:0] i, j;

  ArrayMultiplier_generic #(.m(WIDTH), .n(WIDTH)) am (p, a, x);
//  initial $monitor("a=%b,x=%b,p=%b,", a, x, p);

  initial
  begin
    a = 0;
    x = 0;
    i = 0;
    j = 0;

    for ( i=0 ; i< WIDTH; i = i + 1) begin
          a = a + 1'b1;
        x = 0;
        for( j = 0; j<WIDTH; j = j + 1) begin
            #2 x = x + 1'b1;
        end
    end
    #10 $finish;
    end
endmodule