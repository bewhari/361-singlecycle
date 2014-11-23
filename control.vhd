library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity control is
    port(
        instr: in std_logic_vector(31 downto 0);
        ALU_op: out std_logic_vector(4 downto 0);
        RegDst, RegWrite, ALUsrc_sel, MemRead, MemWrite, MemToReg, Branch: out std_logic
    );
end control;

architecture structural of control is
    
    -- signal to test for all 0's in opcode
    signal opcode_test: std_logic_vector(3 downto 0);
    
    -- instruction to opcode correspondence
    signal and_op: std_logic_vector(4 downto 0) := "00100";
    signal or_op: std_logic_vector(4 downto 0) := "00110";
    signal sll_op: std_logic_vector(4 downto 0) := "01000";
    signal slt_op: std_logic_vector(4 downto 0) := "10010";
    signal sltu_op: std_logic_vector(4 downto 0) := "11010";
    signal add_op: std_logic_vector(4 downto 0) := "00000";
    signal sub_op: std_logic_vector(4 downto 0) := "00010";
    
    -- signals for ALU function muxes
    signal R_andor, R_slt, R_add_andor, R_sub_slt, R_addsub, R_final, IJ_final: std_logic_vector(4 downto 0);
    signal R_IJ_sel: std_logic;
    
    -- signals for control bits
    signal imm, or_ib, not_ib, not29, memwr_or_28, read, write: std_logic;
    
    
    begin
        -- first check if opcode is all 0's
        op_test0: or_gate port map(x => instr(27), y => instr(26), z => opcode_test(0));
        op_test1: or_gate port map(x => instr(29), y => instr(28), z => opcode_test(1));
        op_test2: or_gate port map(x => instr(31), y => instr(30), z => opcode_test(2));
        op_test3: or_gate port map(x => opcode_test(1), y => opcode_test(0), z => opcode_test(3));
        op_test4: or_gate port map(x => opcode_test(3), y => opcode_test(2), z => R_IJ_sel);
        
        -- muxes to select correct ALU op
        op_mux0: mux_n generic map(n => 5) port map(sel => instr(0), src0 => and_op, src1 => or_op, z => R_andor);
        op_mux1: mux_n generic map(n => 5) port map(sel => instr(0), src0 => slt_op, src1 => sltu_op, z => R_slt);
        
        op_mux2: mux_n generic map(n => 5) port map(sel => instr(2), src0 => instr(4 downto 0), src1 => R_andor, z => R_add_andor);
        op_mux3: mux_n generic map(n => 5) port map(sel => instr(3), src0 => instr(4 downto 0), src1 => R_slt, z => R_sub_slt); 
        
        op_mux4: mux_n generic map(n => 5) port map(sel => instr(1), src0 => R_add_andor, src1 => R_sub_slt, z => R_addsub);
        
        op_mux5: mux_n generic map(n => 5) port map(sel => instr(5), src0 => sll_op, src1 => R_addsub, z => R_final);       
        op_mux6: mux_n generic map(n => 5) port map(sel => instr(28), src0 => add_op, src1 => sub_op, z => IJ_final);
        
        op_mux7: mux_n generic map(n => 5) port map(sel => R_IJ_sel, src0 => R_final, src1 => IJ_final, z => ALU_op);
        
        
        -- ALUsrc_sel
        or0: or_gate port map(x => opcode_test(2), y => instr(29), z => imm);
        ALUsrc_sel <= imm;
        
        -- RegDst
        or1: or_gate port map(x => imm, y => instr(28), z => or_ib); -- instr(28) = branch signal
        not0: not_gate port map(x => or_ib, z => not_ib);
        regdst_map: and_gate port map(x => not_ib, y => instr(5), z => RegDst);
        
        -- MemRead
        not1: not_gate port map(x => instr(29), z => not29);
        memread_map: and_gate port map(x => instr(31), y => not29, z => read);
        MemRead <= read;
        
        -- MemWrite
        memwrite_map: and_gate port map(x => instr(31), y => instr(29), z => write);
        MemWrite <= write;
        
        -- RegWrite
        or2: or_gate port map(x => instr(28), y => write, z => memwr_or_28);
        regwrite_map: not_gate port map(x => memwr_or_28, z => RegWrite);
        
        -- MemToReg
        MemToReg <= read;
        
        -- Branch
        Branch <= instr(28);
        
        
end structural;
        