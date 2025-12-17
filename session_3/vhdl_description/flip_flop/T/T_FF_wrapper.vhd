library ieee;
use ieee.std_logic_1164.all;



entity T_FF_wrapper is 
    port (
        T, resetn, clk : in std_logic; -- The n after an input implies that it is active-low. (read: input-not)
        Q, Qn : out std_logic
    );
end entity T_FF_wrapper;



architecture rtl of T_FF_wrapper is 

    component clk_div 
        port (
        clk_in  : in  STD_LOGIC;   
        clk_out : out STD_LOGIC   
    );
    end component clk_div;

    component T_FF 
        port (
        T, resetn, clk : in std_logic; -- The n after an input implies that it is active-low. (read: input-not)
        Q, Qn : out std_logic
    );
    end component T_FF;

    signal clk_out : std_logic;

begin

    my_clk : component clk_div
     port map(
        clk_in => clk,
        clk_out => clk_out
    );

    my_T_FF : component T_FF
     port map(
        T => T,
        resetn => resetn,
        clk => clk_out,
        Q => Q,
        Qn => Qn
    );

end architecture rtl;
