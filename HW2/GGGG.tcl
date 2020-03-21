gui_start
read_file -format verilog {/users/student/topic/zscaxd5651/VLSI_system/HW2/hw02.v}
analyze -library WORK -format verilog {/users/student/topic/zscaxd5651/VLSI_system/HW2/hw02.v}
elaborate GCD -architecture verilog -library WORK
create_clock -name "CLK" -period 10 -waveform { 0 5  }  { CLK  }
check_design
compile -exact_map
uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 1 -significant_digits 2 -sort_by group }
write -format verilog -hierarchy -output hw02_syn.v
write_script > hw02.dc
write_sdf -version 2.0 -context verilog hw02.sdf