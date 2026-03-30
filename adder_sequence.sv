
// virtual class uvm_sequence #(type REQ = uvm_sequence_item,
//                              type RSP = REQ) extends uvm_sequence_base;
//   REQ req;
//   RSP rsp;
//   // lots of methods using REQ/RSP
// endclass

// class adder_sequence extends uvm_sequence; // no #(adder_sequence_item)
//   adder_sequence_item txn;
//   ...
// endclass
//this will compile, because uvm_sequence has default parameters REQ = uvm_sequence_item
// The base class’s req and methods are typed as uvm_sequence_item, not adder_sequence_item.
// Every time you use req/rsp or other APIs, you’d need casts or you risk type mismatches.
// You lose the safety and clarity that this sequence is meant for a specific transaction type.
//sequence, sequencer, driver are parameterised

//generate random in1 and in2
class adder_sequence extends uvm_sequence #(adder_sequence_item);

//Factory registration
`uvm_object_utils(adder_sequence);

adder_sequence_item txn;

int count = 20;
function new(string name = "adder_sequence");
    super.new(name);
endfunction


virtual task body();
repeat (count) begin
    txn = adder_sequence_item::type_id::create("txn");
    start_item(txn);//The call blocks until the sequencer arbitrates among all active sequences, 
                    //your sequence wins and “gets the driver”
    assert(txn.randomize());//when ready you can randomize your packet
    txn.rst = 0;
    finish_item(txn);//now you can send to driver and waits until its fully processed before starting new packet
                    //after this again go back to creating another transaction and keeps on going until whatever repeat has to do
end
//There should be no time delay (#, @(posedge clk) etc.) between start_item and finish_item. 
//All time‑consuming behavior belongs in the driver, not in the sequence.
//This pattern repeats loop_count times, so you generate that many transactions one after another.
endtask: body
//can add pre_body task and post_body task if needed


endclass : adder_sequence



class adder_add_zero_in1 extends adder_sequence;

//Factory registration
`uvm_object_utils(adder_add_zero_in1);

adder_sequence_item txn;

int count = 20;
function new(string name = "adder_add_zero_in1");
    super.new(name);
endfunction


virtual task body();
repeat (count) begin
    txn = adder_sequence_item::type_id::create("txn");
    start_item(txn);//The call blocks until the sequencer arbitrates among all active sequences, 
                    //your sequence wins and “gets the driver”
    assert(txn.randomize() with {txn.in1==0;});//when ready you can randomize your packet
    txn.rst = 0;
    finish_item(txn);//now you can send to driver and waits until its fully processed before starting new packet
                    //after this again go back to creating another transaction and keeps on going until whatever repeat has to do
end
//There should be no time delay (#, @(posedge clk) etc.) between start_item and finish_item. 
//All time‑consuming behavior belongs in the driver, not in the sequence.
//This pattern repeats loop_count times, so you generate that many transactions one after another.
endtask: body
//can add pre_body task and post_body task if needed


endclass : adder_add_zero_in1



//can add multiple sequences as needed by extending the base class "adder_sequence"