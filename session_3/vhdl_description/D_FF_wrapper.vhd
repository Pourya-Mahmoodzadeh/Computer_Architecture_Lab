library ieee;
use ieee.std_logic_1164.all;



entity D_FF_wrapper is
    port (
        D, clk, load, reset : in std_logic; -- Warning: the reest is active-low
        Q, Qn : out std_logic
    );
end entity D_FF_wrapper;



architecture rtl of D_FF_wrapper is

    component clk_div
        Port (
        clk_in  : in  STD_LOGIC;   
        clk_out : out STD_LOGIC   
    );
    end component clk_div;

    component D_FF
        port (
            D, clk, load, reset : in std_logic; -- Warning: the reest is active-low
            Q, Qn : out std_logic
        );
    end component D_FF;

    signal clk_out : std_logic;

begin

    my_D_FF : component D_FF
     port map(
        D => D,
        clk => clk_out,
        load => load,
        reset => reset,
        Q => Q,
        Qn => Qn
    );

    my_clk_div : component clk_div
     port map(
        clk_in => clk,
        clk_out => clk_out
    );

end architecture rtl;