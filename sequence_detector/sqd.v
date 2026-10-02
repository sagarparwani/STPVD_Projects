module sqd(
    input in,clk,rst,
    output out
);

reg [3:0] state, next;

parameter A = 4'd1;
parameter B = 4'd2;
parameter C = 4'd3;
parameter D = 4'd4;
parameter E = 4'd5;

always @(*) begin
    case(state)
    A: next=in?B:A;
    B: next=in?B:C;
    C: next=in?D:A;
    D: next=in?B:E;
    E: next=in?B:A;
    default: next=A;
    endcase
end

always@(posedge clk) begin
    if(rst)
    state<=A;
    else
    state<=next;
end

assign out= (state==E);
endmodule

