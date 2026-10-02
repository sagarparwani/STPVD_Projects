module sqd(
    input in,clk,rst,
    output out
);

reg [2:0] state, next;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;


always @(*) begin
    case(state)
    A: next=in?B:A;
    B: next=in?B:C;
    C: next=in?D:A;
    D: next=in?B:A;

    default: next=A;
    endcase
end

always@(posedge clk) begin
    if(rst)
    state<=A;
    else
    state<=next;
end

assign out= (state==D)&&(in==0);
endmodule

