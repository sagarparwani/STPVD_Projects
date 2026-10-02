module tb_sr;

reg clk;
reg[1:0] sr;
wire qout;

sr_ff uut(.clk(clk), .SR(sr), .qout(qout));

initial clk=0;
always #5 clk=~clk;

initial begin
    sr=2'b01; #10;
    sr=2'b10; #10;
    sr=2'b00; #10;
    sr=2'b11; #10;
    $finish;
end
endmodule