library ieee;
use ieee.std_logic_1164.all;
use work.eecs361.all;
use work.eecs361_gates.all;

entity ALU_1 is
    port (
        ctrl: in std_logic_vector(1 downto 0);   -- 00 add, 01 sub, 10 and, 11 or
        A   : in std_logic;
        B   : in std_logic;
        cin : in std_logic;
        cout: out std_logic;
        R   : out std_logic
    );
end ALU_1;


architecture structural of ALU_1 is
    
    component fulladder is 
        port (
           x: in std_logic; 
           y: in std_logic;
           c: in std_logic;
           z: out std_logic;
           cout: out std_logic
        );
    end component;
        
    signal Bneg, Bsel: std_logic;
    signal and_r, or_r, andor, addsub: std_logic;
    
    begin
        Bneg_map: not_gate port map (x => B, z => Bneg);
        Bsel_map: mux port map (sel => ctrl(0), src0 => B, src1 => Bneg, z => Bsel);
        addsub_map: fulladder port map (x => A, y => Bsel, c => cin, z => addsub, cout => cout);
        
        and_map: and_gate port map (x => A, y => B, z => and_r);
        or_map: or_gate port map (x => A, y => B, z => or_r);
        andor_map: mux port map (sel => ctrl(0), src0 => and_r, src1 => or_r, z => andor);
        
        res_map: mux port map (sel => ctrl(1), src0 => addsub, src1 => andor, z => R);
        
end structural;
    