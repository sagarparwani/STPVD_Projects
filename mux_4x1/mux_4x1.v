module mux_4x1(
    input [3:0] in,
    input [1:0] sel,
    output  out
);

wire r1,r2;

mux_2X1 m1(.a(in[0]), .b(in[1]), .sel(sel[0]), .out(r1));
mux_2X1 m2(.a(in[2]), .b(in[3]), .sel(sel[0]), .out(r2));
mux_2X1 m3(.a(r1), .b(r2), .sel(sel[1]), .out(out));


endmodule