class adder_sequence_item extends uvm_sequence_item;

//inputs and outputs
parameter N=4;
rand logic [N-1:0] in1;
rand logic [N-1:0] in2;

logic [N:0] out;
logic rst;
//////////////////////

//Factory registration
`uvm_object_utils_begin(adder_sequence_item)
    `uvm_field_int(in1, UVM_ALL_ON)
    `uvm_field_int(in2, UVM_ALL_ON)
    `uvm_field_int(out, UVM_ALL_ON)
    `uvm_field_int(rst, UVM_ALL_ON)
`uvm_object_utils_end
//Factory registration done


function new(string name = "adder_sequence_item");
    super.new(name);    
endfunction

//constraints if you want


endclass : adder_sequence_item