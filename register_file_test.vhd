library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity register_file_test is
end register_file_test;

architecture arch of register_file_test is
  
component register_file is
    port(
        write_en:  in std_logic;
        clk:       in std_logic;
        busW:      in std_logic_vector(31 downto 0);
        RW,RA,RB:  in std_logic_vector(4 downto 0);
        busA,busB: out std_logic_vector(31 downto 0)
    );
end component;
  
  signal write_en, clk: std_logic;
  signal busW, busA, busB: std_logic_vector(31 downto 0);
  signal RW, RA, RB: std_logic_vector(4 downto 0);
  
  begin
    rf_test : register_file
    port map (write_en, clk, busW, RW, RA, RB, busA, busB);
      
    process 
    begin
    
    clk <= '1';
    write_en <= '1';
    wait for 5 ns;
    
    RW <= "00101";
    busW <= x"55555555";
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
    
    clk <= '1';
    RW <= "00110";
    busW <= x"66666666";
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
    
    RA <= "00101";
    RB <= "00110";
    clk <= '1';
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
    
    wait;
  end process;
end arch;
    


