library ieee;
use ieee.std_logic_1164.all;
use work.eecs361_gates.all;

entity signext16_32 is
    port(
        x: in std_logic_vector(15 downto 0);
        z: out std_logic_vector(31 downto 0)
    );
end signext16_32;

architecture structural of signext16_32 is
    begin
       z(15 downto 0) <= x;
       z(31 downto 16) <= x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15) & x(15);
       
end structural;
    