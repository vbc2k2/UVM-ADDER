class adder_driver extends uvm_driver #(adder_sequence_item);

//factory registration
`uvm_component_utils(adder_driver)

uvm_analysis_port #(adder_sequence_item) drv2sb;//driver to scoreboard for scoreboard to know what inputs we sent

function new(string name = "adder_driver", uvm_component parent);
    super.new(name, parent);
    drv2sb = new("drv2sb", this);
endfunction

virtual interface intf vif;//vif is a handle to your SystemVerilog interface that has clk, in1, in2, rst etc
//You can’t construct an interface inside a class, so the top testbench creates it, then passes the handle through the config DB

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db #(virtual intf)::get(this, "", "vif", vif))) begin
        `uvm_fatal(get_type_name(), "unable to get interface");
        //uvm_config_db::get fetches the virtual interface; if not found, it fatal‑errors.
        //After this, vif is valid and you can drive vif.in1, vif.in2, etc
    end
endfunction

task run_phase(uvm_phase phase);

adder_sequence_item txn;

forever begin//killed by objection_drop after sequence sends all packets
    seq_item_port.get_next_item(txn);
    @(posedge vif.clk);
    vif.in1 <= txn.in1;
    vif.in2 <= txn.in2;
    vif.rst <= txn.rst;
    drv2sb.write(txn);
    seq_item_port.item_done();
end
endtask





endclass: adder_driver