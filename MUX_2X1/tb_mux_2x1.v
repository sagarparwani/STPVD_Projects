module tb_mux2x1;

reg a,b,sel;
wire out;

mux_2x1 uut(.a(a), .b(b), .sel(sel), .out(out));

initial begin
    sel=1; a=0; b=0; #10;
    sel=1; a=0; b=1; #10;
    sel=1; a=1; b=0; #10;
    sel=1; a=1; b=1; #10;
    sel=0; a=0; b=0; #10;
    sel=0; a=0; b=1; #10;
    sel=0; a=1; b=0; #10;
    sel=0; a=1; b=1; #10;
    $finish;
end
endmodule