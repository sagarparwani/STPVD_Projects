module tb_mux_4x1;

reg [3:0] in;
reg [1:0] sel;
wire out;

mux_4x1 uut(.in(in[3:0]), .sel(sel[1:0]), .out(out));

initial begin
    in=4'b1010;
    sel=2'b00; #10;
    sel=2'b01; #10;
    sel=2'b10; #10;
    sel=2'b11; #10;
    $finish;
end
endmodule
