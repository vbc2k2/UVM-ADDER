class adder_agent extends uvm_agent;

`uvm_component_utils(adder_agent)

function new(string name = "agent", uvm_component parent);
    super.new(name, parent);
endfunction

adder_sequencer sequencer_h;
adder_driver driver_h;
adder_monitor monitor_h;

function void build_phase(uvm_phase phase);

super.build_phase(phase);// must
if (UVM_ACTIVE == is_active) begin
    sequencer_h = adder_sequencer::type_id::create("sequencer_h", this);
    driver_h = adder_driver::type_id::create("adder_driver", this);
end

monitor_h = adder_monitor::type_id::create("adder_monitor", this);

endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase); // not necessary
if (UVM_ACTIVE == is_active)
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);// connect method is called from port and takes export as an argument
endfunction




endclass: adder_agent