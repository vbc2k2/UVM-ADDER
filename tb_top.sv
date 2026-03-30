`include "interface.sv"
`include "tb_pkg.sv"
`include "adder.v"

module top;
    import uvm_pkg::*;
    import tb_pkg::*;

    bit clk;
    intf i_intf(clk);
  adder DUT(.in1(i_intf.in1),
            .in2(i_intf.in2),
            .out(i_intf.out),
            .clk(i_intf.clk),
            .rst(i_intf.rst)
            );

            always #5 clk = ~clk;
initial clk <= 0;


initial begin
    uvm_config_db #(virtual intf) ::set(null,"*","vif",i_intf);
end

initial begin
    run_test("adder_test");
end

endmodule