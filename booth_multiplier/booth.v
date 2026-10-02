module booth_top #(parameter N=8) (
    input clk, rst, start,
    input signed [N-1:0] m, q,
    output reg [2*N-1:0] result,
    output done
);

wire load, add_en, sub_en, shift_en;
wire q0, qm1, count_zero;
wire [2*N-1:0] out;

datapath #(N) dp (
    .clk(clk), .rst(rst),
    .load(load), .add_en(add_en), .sub_en(sub_en), .shift_en(shift_en),
    .m(m), .q(q),
    .q0(q0), .qm1(qm1), .out(out), .count_zero(count_zero)
);

controlpath cp (
    .clk(clk), .rst(rst), .start(start),
    .q0(q0), .qm1(qm1), .count_zero(count_zero),
    .load(load), .add_en(add_en), .sub_en(sub_en), .shift_en(shift_en), .done(done)
);

always @(posedge clk) begin
    if(done)
        result <= out;
    else if(rst)
        result <= 0;
end
endmodule

