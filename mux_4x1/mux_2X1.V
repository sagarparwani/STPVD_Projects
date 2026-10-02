module mux_2X1(
    input a,b,sel,
    output out
);

assign out = sel ? b :a;
endmodule