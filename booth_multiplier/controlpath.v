module controlpath(

    input clk,rst,start,q0,qm1,count_zero,
    output reg load,add_en,sub_en,shift_en,done
);

parameter IDLE=0,INIT=1,CHECK=2,SHIFT=3,DONE=4,ADD=5,SUB=6;
reg [2:0] state,next;

always@(posedge clk) begin
    if(rst) begin
        state<=IDLE;
    end
    else
        state<=next;
end

always@(*) begin
    load=0; add_en=0; sub_en=0; shift_en=0; done=0;
    next=state;

    case(state)
    IDLE: begin
        if(start) next=INIT;
    end

    INIT: begin
        load=1;
        next=CHECK;
    end

    CHECK: begin
        if (q0 && !qm1) next=SUB;
        else if(!q0 && qm1) next=ADD;
        else next=SHIFT;
    end

    ADD: begin
        add_en=1;
        next=SHIFT;
    end

    SUB: begin
        sub_en=1;
        next = SHIFT;
    end

    SHIFT: begin
        shift_en = 1;
        if (count_zero) next = DONE;
        else            next = CHECK;
    end

    DONE: begin
        done = 1;
        next = IDLE;
    end
    endcase
end        
endmodule

