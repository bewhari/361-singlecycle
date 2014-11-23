library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity ALU_1_test is
    port (
        cout: out std_logic;
        R   : out std_logic
    );
end ALU_1_test;


architecture structural of ALU_1_test is
    component ALU_1
        port (
            ctrl: in std_logic_vector(1 downto 0);   -- 00 add, 01 sub, 10 and, 11 or
            A   : in std_logic;
            B   : in std_logic;
            cin : in std_logic;
            cout: out std_logic;
            R   : out std_logic
        );
    end component;
    
    signal Ain: std_logic;
    signal Bin: std_logic;
    signal ctrlin: std_logic_vector(1 downto 0);
    signal carryin: std_logic;
    
    
    begin
        ALU_1_map: ALU_1 port map (ctrl => ctrlin, A => Ain, B => Bin, cin => carryin, cout => cout, R => R);
        
        test_proc : process
        begin
            Ain <= '0';
            Bin <= '0';
            ctrlin <= "00";   -- add
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '1';
            ctrlin <= "00"; 
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '0';
            ctrlin <= "00";
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '1';
            ctrlin <= "00"; 
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '0';
            ctrlin <= "01";   -- sub
            carryin <= '1';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '1';
            ctrlin <= "01"; 
            carryin <= '1';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '0';
            ctrlin <= "01";
            carryin <= '1';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '1';
            ctrlin <= "01"; 
            carryin <= '1';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '0';
            ctrlin <= "10";   -- and
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '1';
            ctrlin <= "10"; 
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '0';
            ctrlin <= "10";
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '1';
            ctrlin <= "10"; 
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '0';
            ctrlin <= "11";   -- or
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '0';
            Bin <= '1';
            ctrlin <= "11"; 
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '0';
            ctrlin <= "11";
            carryin <= '0';
            wait for 5 ns;
            
            Ain <= '1';
            Bin <= '1';
            ctrlin <= "11";
            carryin <= '0';
            wait for 5 ns;
            
            wait;
       end process;
    
end structural; 

