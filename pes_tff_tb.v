module pes_tff_tb;
reg clk,rst,t;
wire q,qbar;	
pes_tff uut (.q(q), .qbar(qbar), .clk(clk), .rst(rst), .t(t));
initial begin
$dumpfile("pes_tff_tb.vcd");
$dumpvars(0, pes_tff_tb);
rst = 1'b0;	
clk = 1'b0;	
t = 1'b0;
end
always #10 clk=~clk;
always #20 t=~t;
always #200 rst=~rst;
endmodule
