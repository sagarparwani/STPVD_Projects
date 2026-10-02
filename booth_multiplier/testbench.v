`timescale 1ns/1ps

module tb_booth_top;

parameter N = 8;

reg clk, rst, start;
reg signed [N-1:0] m, q;
wire done;
wire [2*N-1:0] result;

booth_top #(N) uut (
    .clk(clk), .rst(rst), .start(start),
    .m(m), .q(q),
    .done(done), .result(result)
);

always #5 clk = ~clk;

task run_test(input signed [N-1:0] m_val, input signed [N-1:0] q_val);
    reg signed [2*N-1:0] expected;
    begin
        expected = m_val * q_val;
        @(negedge clk);
        m = m_val;
        q = q_val;
        start = 1;
        @(negedge clk);
        start = 0;
        wait(done);
        @(negedge clk);     // result is latched on the clock edge that ends the DONE state
        @(negedge clk);     // so sample one cycle after done is seen
        if ($signed(result) === expected)
            $display("PASS: M=%0d Q=%0d -> RESULT=%0d (expected=%0d)", m_val, q_val, $signed(result), expected);
        else
            $display("FAIL: M=%0d Q=%0d -> RESULT=%0d (expected=%0d)", m_val, q_val, $signed(result), expected);
        rst = 1;
        @(negedge clk);
        rst = 0;
    end
endtask

initial begin
    clk = 0;
    rst = 1;
    start = 0;
    m = 0;
    q = 0;

    @(negedge clk);
    rst = 0;

    run_test(0, 0);
    run_test(1, 1);
    run_test(6, 7);
    run_test(-6, 7);
    run_test(6, -7);
    run_test(-6, -7);
    run_test(15, 15);
    run_test(-15, -15);
    run_test(64, -64);
    run_test(-128, 1);
    run_test(127, 127);
    run_test(-128, -128);
    run_test(100, -1);
    run_test(-1, 100);

    $finish;
end

endmodule