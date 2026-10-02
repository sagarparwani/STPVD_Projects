module counter_7bit(
    input clk,rst,
    
    output reg [6:0] count
    );

    always@(posedge clk) begin
    if(rst)
    count<=7'b0;
    else
    count<=count+1;
end
endmodule


