library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;


package arraytypes is
    type array32_32 is array(31 downto 0) of std_logic_vector (31 downto 0);
    type array16_32 is array(15 downto 0) of std_logic_vector (31 downto 0);
    type array8_32 is array(7 downto 0) of std_logic_vector (31 downto 0);
    type array4_32 is array(3 downto 0) of std_logic_vector (31 downto 0);
    type array2_32 is array(1 downto 0) of std_logic_vector (31 downto 0);
end package;
