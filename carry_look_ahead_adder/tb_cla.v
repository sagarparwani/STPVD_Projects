module tb_carry_lookahead_adder_4bit;    

reg [3:0] A, B;   
 reg Cin;  
   wire [3:0] Sum;   
    wire Cout; 
    
       carry_lookahead_adder_4bit uut (A, B, Cin, Sum, Cout);   
        initial begin           
                 A = 4'b1100; B = 4'b0011; Cin = 0; #10;  
                       A = 4'b1001; B = 4'b0110; Cin = 1; #10;       
                        A = 4'b1111; B = 4'b1111; Cin = 0; #10;      
                          $finish;  
                            end
 endmodule