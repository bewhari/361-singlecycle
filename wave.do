onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /single_cycle_test/clk
add wave -noupdate -format Logic /single_cycle_test/rst
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/pc
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/instr
add wave -noupdate -format Logic /single_cycle_test/cpu_map/d_mem/cs
add wave -noupdate -format Logic /single_cycle_test/cpu_map/d_mem/oe
add wave -noupdate -format Logic /single_cycle_test/cpu_map/d_mem/we
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/d_mem/addr
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/d_mem/din
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/d_mem/dout
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__1/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__2/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__3/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__4/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__5/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__6/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__7/reg_i/z
add wave -noupdate -format Logic /single_cycle_test/cpu_map/memread
add wave -noupdate -format Logic /single_cycle_test/cpu_map/memwrite
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__8/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__9/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__10/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__11/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__12/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__13/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__14/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__15/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__16/reg_i/z
add wave -noupdate -format Literal -radix hexadecimal /single_cycle_test/cpu_map/reg_file/gen_reg__17/reg_i/z
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7779 ns} 0}
configure wave -namecolwidth 399
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {7719 ns} {7919 ns}
