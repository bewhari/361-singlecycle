library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity shift_32_test is
    port (
        R   : out std_logic_vector(31 downto 0)
    );
end shift_32_test;


architecture structural of shift_32_test is
    component shift_32 
        port (
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            R   : out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal Ain: std_logic_vector(31 downto 0);
    signal Bin: std_logic_vector(31 downto 0);
    
    begin
        shift_32_map: shift_32 port map (A => Ain, B => Bin, R => R);
        
        test_proc : process
        begin
            Ain <= "01010101010101010101010101010101";
            Bin <= "00000000000000000000000000000001";
            wait for 10 ns;
            
            Ain <= "01010101010101010101010101010101";
            Bin <= "00000000000000000000000000011111";
            wait for 10 ns;
            
            Ain <= "01010101010101010101010101010101";
            Bin <= "00000000000000000000100000000000";
            wait for 10 ns;
            
            Ain <= "01010101010101010101010101010101";
            Bin <= "00000000100000000000000000000011";
            wait for 10 ns;
            wait;
       end process;
    
end structural; 

