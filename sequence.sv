



class fifo_write_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_write_sequence)
  
  //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name="fifo_write_sequence");
    super.new(name);
  endfunction
  bit full;
  
  virtual task body();
    fifo_seq_item seq;
    fifo_seq_item rsp;
    rsp=new();
    //---------------------------------------
    //Write sequence
    //---------------------------------------
    while(rsp.full!=1)
    begin
      seq=new();
      start_item(seq);
      assert(seq.randomize()with{seq.wr==1;});
      finish_item(seq);
      get_response(rsp);
      `uvm_info(get_type_name(),$sformatf("Write Respose: Full flag=%0d",rsp.full),UVM_LOW)
      $display("-----------------------------------------------------------------------------");
    end
    //---------------------------------------
    //Read sequence
    //---------------------------------------
    while(rsp.empty!=1)
    begin
      seq=new();
      start_item(seq);
      assert(seq.randomize()with{seq.rd==1;});
      finish_item(seq);
      get_response(rsp);
      `uvm_info(get_type_name(),$sformatf("Read Respose: Empty flag=%0d",rsp.empty),UVM_LOW)
      $display("-----------------------------------------------------------------------------");
    end 
    
  endtask
  

endclass
