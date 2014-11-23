library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity dff_32 is
    port(
        clk: in std_logic;
        x: in std_logic_vector(31 downto 0);
        z: out std_logic_vector(31 downto 0)
    );
end dff_32;

architecture structural of dff_32 is
    begin
        gen_test: for i in 0 to 31 generate
           dff_i: dff port map (clk => clk, d => x(i), q => z(i));
        end generate;
end structural;