module tb_jk;

reg clk;
reg[1:0] jk;
wire qout;

jk_ff uut(.clk(clk), .jk(jk), .qout(qout));

initial clk=0;
always #5 clk=~clk;

initial begin
    jk=2'b01; #10;
    jk=2'b10; #10;
    jk=2'b00; #10;
    jk=2'b11; #10;
    jk=2'b11; #10;
    $finish;
end
endmodule