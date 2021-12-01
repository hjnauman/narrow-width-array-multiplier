`include "ripple_carry_adder.v"
`include "generic_n_x_n_mult.v"

// The width parameter for this design represents the logical width of the desired multiplier behavior
module narrow_array_multiplier
    #(parameter WIDTH = 16)
    (
        input [WIDTH-1:0] a,
        input [WIDTH-1:0] b,
        output [(WIDTH * 2) - 1:0]  product
    );

    // multiplier wires
    wire [WIDTH -1: 0] mult_H_H_out;
    wire [WIDTH -1: 0] mult_L_H_out;
    wire [WIDTH -1: 0] mult_H_L_out;
    wire [WIDTH -1: 0] mult_L_L_out;

    //adder wires, number notation denoted by adders top down right to left
    wire [(WIDTH / 2) - 1:0] add_0_sum;
    wire add_0_carry_out;
    wire add_1_carry_out;
    wire [(WIDTH / 2) - 1:0] add_2_sum;
    wire add_2_carry_out;
    wire add_3_carry_out;
    wire add_4_carry_out;
    reg [(WIDTH/2)-1:1] add_4_a_in = 0;

    ArrayMultiplier_generic #(.m(WIDTH/2), .n(WIDTH/2)) mult_H_H(
        .product(mult_H_H_out),
        .a(a[WIDTH -1: WIDTH/2]),
        .b(b[WIDTH -1: WIDTH/2])
    );

    ArrayMultiplier_generic #(.m(WIDTH/2), .n(WIDTH/2)) mult_H_L(
        .product(mult_H_L_out),
        .a(a[(WIDTH / 2) - 1:0]),
        .b(b[WIDTH -1: WIDTH/2])
    );

    ArrayMultiplier_generic #(.m(WIDTH/2), .n(WIDTH/2)) mult_L_H(
        .product(mult_L_H_out),
        .a(a[WIDTH -1: WIDTH/2]),
        .b(b[(WIDTH / 2) - 1:0])
    );

    ArrayMultiplier_generic #(.m(WIDTH/2), .n(WIDTH/2)) mult_L_L(
        .product(mult_L_L_out),
        .a(a[(WIDTH / 2) - 1:0]),
        .b(b[(WIDTH / 2) - 1:0])
    );

    ripple_carry_adder #(.WIDTH(WIDTH/2)) add_0(
        .carry_in(1'b0),
        .a(mult_L_L_out[WIDTH -1: WIDTH/2]),
        .b(mult_H_L_out[(WIDTH/2) -1:0]),
        .sum(add_0_sum),
        .carry_out(add_0_carry_out)
    );

    ripple_carry_adder #(.WIDTH(WIDTH/2)) add_1
    (
        .carry_in(1'b0),
        .a(add_0_sum),
        .b(mult_L_H_out[(WIDTH/2) -1:0]),
        .sum(product[WIDTH -1: WIDTH/2]),
        .carry_out(add_1_carry_out)
    );

    ripple_carry_adder #(.WIDTH(WIDTH/2)) add_2(
        .carry_in(add_0_carry_out),
        .a(mult_H_L_out[WIDTH -1: WIDTH/2]),
        .b(mult_L_H_out[WIDTH -1: WIDTH/2]),
        .sum(add_2_sum),
        .carry_out(add_2_carry_out)
    );

    ripple_carry_adder #(.WIDTH(WIDTH/2)) add_3
    (
        .carry_in(add_1_carry_out),
        .a(add_2_sum),
        .b(mult_H_H_out[(WIDTH/2) -1:0]),
        .sum(product[WIDTH + (WIDTH/2) - 1: WIDTH]),
        .carry_out(add_3_carry_out)
    );

    ripple_carry_adder #(.WIDTH(WIDTH/2)) add_4
    (
        .carry_in(add_3_carry_out),
        .a({add_4_a_in, add_2_carry_out}),
        .b(mult_H_H_out[WIDTH -1: WIDTH/2]),
        .sum(product[(WIDTH*2) -1: WIDTH + (WIDTH/2)])
    );

    assign product[(WIDTH/2) -1: 0] = mult_L_L_out[(WIDTH/2) -1: 0];

endmodule