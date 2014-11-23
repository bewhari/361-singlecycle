library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity register_32 is
    port(
        clk:       in std_logic;
        write:  in std_logic;
        x: in std_logic_vector(31 downto 0);
        z: out std_logic_vector(31 downto 0)
    );
end register_32;

architecture structural of register_32 is
    component dff_32 is
        port(
            clk: in std_logic;
            x: in std_logic_vector(31 downto 0);
            z: out std_logic_vector(31 downto 0)
        );
    end component;
    
    
    signal prev: std_logic_vector(31 downto 0);
    signal temp: std_logic_vector(31 downto 0); 
   
    begin 
        mux: mux_32 port map(sel => write, src0 => prev, src1 => x, z => temp);
        dff: dff_32 port map(clk => clk, x => temp, z => prev);
        
        z <= prev;
end structural;