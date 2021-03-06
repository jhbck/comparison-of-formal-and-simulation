// Copyright 2020 Tudor Timisescu (verificationgentleman.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


class agent extends uvm_agent;

  uvm_sequencer #(transaction) sequencer;
  bus::driver driver;
  bus::monitor monitor;

  bus::reg_adapter reg_adapter;


  function new(string name, uvm_component parent);
    super.new(name, parent);

    reg_adapter = bus::reg_adapter::type_id::create("reg_adapter");
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    sequencer = uvm_sequencer #(transaction)::type_id::create("sequencer", this);
    driver = bus::driver::type_id::create("driver", this);
    monitor = bus::monitor::type_id::create("monitor", this);
  endfunction


  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    virtual bus_interface bus_intf;

    super.end_of_elaboration_phase(phase);

    if (!uvm_config_db #(virtual bus_interface)::get(this, "", "bus_intf", bus_intf))
      `uvm_fatal("INTFERR", "Could not get interface")

    driver.set_intf(bus_intf);
    monitor.set_intf(bus_intf);
  endfunction

  `uvm_component_utils(bus::agent)

endclass
