module datapath #(parameter N=8) (
    input clk, rst,
    input load,
    input add_en, sub_en,
    input shift_en,
    input signed [N-1:0] m, q,
    output q0,
    output qm1,
    output [2*N-1:0] out,
    output count_zero
);

reg [N-1:0] Qmul, Mult, count;
reg [N:0] A;    // one extra bit so A+Mult and A-Mult cannot overflow (e.g. Mult = -2^(N-1))
reg qn;

wire [N:0] Mult_ext = {Mult[N-1], Mult};    // sign-extended multiplicand

always @(posedge clk) begin
    if(rst) begin
        Qmul<=0;
        Mult<=0;
        A<=0;
        qn<=0;
        count<=0;
    end

    else if(load) begin
        Qmul<=q;
        Mult<=m;
        A<=0;
        qn<=0;
        count<=N;
    end

    else if(add_en) begin
        A<=A+Mult_ext;
    end

    else if(sub_en) begin
        A<=A-Mult_ext;
    end

    else if(shift_en) begin
        A<={A[N],A[N:1]};
        Qmul<={A[0],Qmul[N-1:1]};
        qn<=Qmul[0];
        count<=count-1;
    end

end

assign q0=Qmul[0];
assign qm1=qn;
assign out={A[N-1:0],Qmul};
assign count_zero=(count==1);

endmodule