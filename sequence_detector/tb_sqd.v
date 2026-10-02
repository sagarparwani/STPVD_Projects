module tb_sqd;
reg in,clk,rst;
wire out;

sqd uut(.in(in), .clk(clk), .rst(rst), .out(out));

reg [15:0] pattern= 16'b1000101011010110;
integer i;

always #5 clk=~clk;

initial begin
    clk=0;
    rst=1;
    in=0;
    #10;
    rst=0;
    for(i=15; i>=0; i=i-1) begin
    in=pattern[i]; #10;
    
end
$finish;
end
endmodule