library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;
use work.arraytypes.all;

entity register_file is
    port(
        write_en:  in std_logic;
        clk:       in std_logic;
        busW:      in std_logic_vector(31 downto 0);
        RW,RA,RB:  in std_logic_vector(4 downto 0);
        busA,busB: out std_logic_vector(31 downto 0)
    );
end register_file;

architecture structural of register_file is
    component register_32 is
        port(
            clk:       in std_logic;
            write:  in std_logic;
            x: in std_logic_vector(31 downto 0);
            z: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component rf_muxtree is
       port(
           x: in array32_32;
           sel: in std_logic_vector(4 downto 0);
           z: out std_logic_vector(31 downto 0)
       );
    end component;
    
    signal rw_dec_out: std_logic_vector(31 downto 0);
    signal write_signal: std_logic_vector(31 downto 0);
    signal reg_val: array32_32;
    
    begin
       -- decode RW signal 
       rw_dec: dec_n generic map(n => 5) port map(src => RW, z => rw_dec_out);
       
       -- create write signal for 32 32-bit registers
       write_map: mux_32 port map(sel => write_en, src0 => x"00000000", src1 => rw_dec_out, z => write_signal);
       
       -- register 0 constantly holds value 0
       --reg_0: register_32 port map(clk => clk, write => '0', x=> x"00000000", z=> reg_val(0));
       write_signal(0) <= '0';
       reg_val(0) <= x"00000000";
       
       -- generate all 31 other registers
       gen_reg: for i in 1 to 31 generate
          reg_i: register_32 port map(clk => clk, write => write_signal(i), x => busW, z => reg_val(i));
       end generate;
       
       -- create busA busB muxtrees
       busA_tree: rf_muxtree port map(x => reg_val, sel => RA, z => busA);
       busB_tree: rf_muxtree port map(x => reg_val, sel => RB, z => busB);
       
end structural;
