module tff(q,qbar,clk,rst,t);
 input clk;	 
input rst;
input t;
output q,qbar; 
reg q,qbar;
wire qq=t^q;
always @ (posedge clk,negedge rst)
begin              
if(rst==1'b0)
begin
q=1'b0;
qbar=1'b1;
end	    
else 
begin	 		  
q=qq;	  
qbar=~q;		  
end 
end
endmodule
