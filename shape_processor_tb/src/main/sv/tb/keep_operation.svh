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


class keep_operation extends uvm_reg_cbs;

  function new();
    super.new(get_type_name());
  endfunction


  // XXX WORKAROUND Xcelium doesn't support scoped constructor calls.
  static function keep_operation new_instance();
    new_instance = new();
  endfunction


  virtual function void post_predict(
      input uvm_reg_field fld,
      input uvm_reg_data_t previous,
      inout uvm_reg_data_t value,
      input uvm_predict_e kind,
      input uvm_path_e path,
      input uvm_reg_map map);
    if (value == KEEP_OPERATION)
      value = previous;
  endfunction


  `m_uvm_get_type_name_func(keep_operation)

endclass
