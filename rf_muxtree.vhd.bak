library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;
use work.arraytypes.all;

entity rf_muxtree is
    port(
        x: in array32_32;
        sel: in std_logic_vector(4 downto 0);
        z: out std_logic_vector(31 downto 0)
    );
end rf_muxtree;
    
    
architecture structural of rf_muxtree is
    signal out0: array16_32;
    signal out1: array8_32;
    signal out2: array4_32;
    signal out3: array2_32;
    
    begin
        gen_0: for i in 0 to 15 generate
           mux_0i: mux_32 port map (sel => sel(0), src0 => x(2*i), src1 => x(2*i+1), z => out0(i));
        end generate;
        
        gen_1: for i in 0 to 7 generate
           mux_1i: mux_32 port map (sel => sel(1), src0 => out0(2*i), src1 => out0(2*i+1), z => out1(i));
        end generate;
        
        gen_2: for i in 0 to 3 generate
           mux_2i: mux_32 port map (sel => sel(2), src0 => out1(2*i), src1 => out1(2*i+1), z => out2(i));
        end generate;
        
        gen_3: for i in 0 to 1 generate
           mux_3i: mux_32 port map (sel => sel(3), src0 => out2(2*i), src1 => out2(2*i+1), z => out3(i));
        end generate;
        
        res: mux_32 port map(sel => sel(4), src0 => out3(0), src1 => out3(1), z => z);
end structural;