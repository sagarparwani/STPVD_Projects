module jk_ff(
    input [1:0] jk,
    input clk,
    output reg qout
);

always @(posedge clk) begin
    case(jk)
    2'b00: qout<=qout;
    2'b01: qout<=1'b0;
    2'b10: qout<=1'b1;
    2'b11: qout<=~qout;
    endcase
end
endmodule