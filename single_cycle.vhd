library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity single_cycle is
    generic (
      prog: string;
      PC_init: std_logic_vector(31 downto 0)
    );
    
    port (
        clk: in std_logic;
        rst: in std_logic -- reset on low
    );
end single_cycle;

architecture structural of single_cycle is
    component fulladder32 is
        port (
            x      : in   std_logic_vector(31 downto 0);
            y      : in   std_logic_vector(31 downto 0);
            c      : in   std_logic;
            z      : out  std_logic_vector(31 downto 0);
            cout   : out  std_logic
        );
    end component;
    
    component signext16_32 is
        port(
            x: in std_logic_vector(15 downto 0);
            z: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component shift_32 is
        port (
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            R   : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component register_32 is
        port(
           clk:       in std_logic;
           write:  in std_logic;
           x: in std_logic_vector(31 downto 0);
           z: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component register_file is
        port(
            write_en:  in std_logic;
            clk:       in std_logic;
            busW:      in std_logic_vector(31 downto 0);
            RW,RA,RB:  in std_logic_vector(4 downto 0);
            busA,busB: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component ALU_32 is
       port (
           ctrl: in std_logic_vector(4 downto 0);
           A   : in std_logic_vector(31 downto 0);
           B   : in std_logic_vector(31 downto 0);
           cout: out std_logic;
           R   : out std_logic_vector(31 downto 0);
           ovf : out std_logic;
           zf  : out std_logic
       );
    end component;
    
    component control is
    port(
        instr: in std_logic_vector(31 downto 0);
        ALU_op: out std_logic_vector(4 downto 0);
        RegDst, RegWrite, ALUsrc_sel, MemRead, MemWrite, MemToReg, Branch: out std_logic
    );
    end component;
    
    -- PC-related signals
    signal PC, new_PC, set_PC: std_logic_vector(31 downto 0);
    --signal PC_init: std_logic_vector(31 downto 0) := x"0040001c"; -- will have +4 immediately
    signal PC_plus4, PC_plusOffset: std_logic_vector(31 downto 0);
    signal PC_sel, PC_sel_temp: std_logic;
    signal we_dont_frickin_care: std_logic;
    signal imm_offset, offset: std_logic_vector(31 downto 0);
    
    signal notZero: std_logic;
    signal branchZero: std_logic;
    
    -- instruction
    signal instr: std_logic_vector(31 downto 0);
    signal Imem_in: std_logic_vector(31 downto 0); -- unused but required
    
    -- control bits
    signal RegDst, RegWrite, ALUsrc_sel, MemRead, MemWrite, MemToReg, Branch: std_logic;
    
    -- register file ports
    signal busW, busA, busB: std_logic_vector(31 downto 0); 
    signal RW: std_logic_vector(4 downto 0);
    
    -- ALU ports
    signal ALUsrc, ALUres: std_logic_vector(31 downto 0); 
    signal ALU_op: std_logic_vector(4 downto 0);
    signal ovf, cout, zf: std_logic;
    signal sll_h, sll_check: std_logic_vector(31 downto 0);
    signal sll_sel: std_logic;
    
    -- data memory
    signal Dmem_out, data_point: std_logic_vector(31 downto 0);
    
    begin 
        -- PC logic
        setPC: mux_32 port map(sel => rst, src0 => PC_init, src1 => PC, z => set_PC);
        setBranch: mux port map(sel => rst, src0 => '0', src1 => PC_sel_temp, z => PC_sel);
          
        PC_map: register_32 port map(clk => clk, write => '1', x => new_PC, z => PC);
        add_4: fulladder32 port map(x => set_PC, y => x"00000004", c => '0', z => PC_plus4, cout => we_dont_frickin_care);
        add_offset: fulladder32 port map (x => PC_plus4, y => offset, c =>'0', z => PC_plusOffset, cout => we_dont_frickin_care);
        PC_mux: mux_32 port map(sel=> PC_sel, src0 => PC_plus4, src1 => PC_plusOffset, z => new_PC);
        imm_sign_ext: signext16_32 port map(x => instr(15 downto 0), z => imm_offset);
        instr_offset: shift_32 port map(A => imm_offset, B => x"00000002", R => offset);
        branch_and: and_gate port map(x => branchZero, y => Branch, z => PC_sel_temp);
        
        -- alter zero signal for different branch forms
        notZf: not_gate port map(x => zf, z => notZero);
        branchMux: mux port map(sel => instr(26), src0 => zf, src1 => notZero, z => branchZero);
        
        
        -- control logic
        ctrl: control port map (instr => instr, ALU_op => ALU_op, RegDst => RegDst, RegWrite => RegWrite, 
        ALUsrc_sel => ALUsrc_sel, MemRead => MemRead, MemWrite => MemWrite, MemToReg => MemToReg, Branch => Branch);
        
        -- instruction memory logic
        i_mem: sram generic map(mem_file => prog) port map(cs => '1', oe => '1', we => '0', addr => PC, din => Imem_in, dout => instr);
        
        -- register file logic
        RW_mux: mux_n generic map(n => 5) port map(sel => RegDst, src0 => instr(20 downto 16), src1 => instr(15 downto 11), z => RW);
        reg_file: register_file port map(write_en => RegWrite, clk => clk, busW => busW, RW => RW, RA => instr(25 downto 21), RB => instr(20 downto 16), busA => busA, busB => busB);
        
        -- ALU logic
        sll_h <= x"000000"&"000"&instr(10 downto 6);
        or_0: or_gate port map(x => RegDst, y=> Branch, z=> sll_sel);
        sll_check_mux: mux_32 port map(sel => sll_sel, src0 => sll_h, src1 => busB, z => sll_check);
        ALUsrc_mux: mux_32 port map(sel => ALUsrc_sel, src0 => sll_check, src1 => imm_offset, z => ALUsrc); -- reg vs imm
        ALU: ALU_32 port map(ctrl => ALU_op, A => busA, B => ALUsrc, cout => cout, R => ALUres, ovf => ovf, zf => zf);
        
        -- data memory logic
        --data_point <= ALUres;
        d_mem: syncram generic map(mem_file => prog) port map(clk => clk, cs => '1', oe => MemRead, we => MemWrite, addr => ALUres, din => busB, dout => Dmem_out);
        mem2reg_mux: mux_32 port map(sel => MemToReg, src0 => ALUres, src1 => Dmem_out, z => busW);
        
end structural;
    