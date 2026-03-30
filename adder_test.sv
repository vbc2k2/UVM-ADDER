class adder_test extends uvm_test;

`uvm_component_utils(adder_test)

function new(string name = "adder_test", uvm_component parent);
    super.new(name, parent);
endfunction

adder_env env_h;

adder_sequence seq;
adder_add_zero_in1 seq1;


function void build_phase(uvm_phase phase);
    env_h = adder_env::type_id::create("env_h", this);
    seq = adder_sequence::type_id::create("seq", this);
    seq1 = adder_add_zero_in1::type_id::create("seq1", this);
endfunction

    function void end_of_elobartion_phase(uvm_phase phase);
      //super.end_of_elobartion_phase(phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env_h.agent_h.sequencer_h);
    seq1.start(env_h.agent_h.sequencer_h);
    #10;
    phase.drop_objection(this);
endtask



endclass: adder_test