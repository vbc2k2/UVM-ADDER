interface intf (input clk);
//inputs and outputs
parameter N=4;
logic [N-1:0] in1;
logic [N-1:0] in2;

logic [N:0] out;
logic rst;
//////////////////////

property p1;
@(posedge clk) disable iff (rst)
    (out == in1 + in2);
endproperty

assert property (p1)
    $display("Working");
else $display("not working");

endinterface