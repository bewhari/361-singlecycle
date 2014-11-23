library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity register_32_test is
end register_32_test;

architecture arch of register_32_test is
  
    component register_32 is
        port(
            clk, write: in std_logic;
            x: in std_logic_vector(31 downto 0);
            z: out std_logic_vector(31 downto 0)
        );
    end component;
     
    signal clk, write: std_logic;
    signal x, z: std_logic_vector(31 downto 0);
  
  begin
    reg_test : register_32
    port map (clk, write, x, z);
      
    process 
    begin
    
    clk <= '1';
    write <= '1';
    x <= x"12345678";
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    x <= x"55555555";
    wait for 5 ns;
    clk <= '0';
    wait for 5 ns;
    
    wait;
  end process;
end arch;