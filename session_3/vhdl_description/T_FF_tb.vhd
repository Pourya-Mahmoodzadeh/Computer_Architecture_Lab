library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity T_FF_tb is 
end entity T_FF_tb;



architecture rtl of T_FF_tb is

    component T_FF
        port (
            T, resetn, clk : in std_logic; -- The n after an input implies that it is active-low. (read: input-not)
            Q, Qn : out std_logic
        );
    end component T_FF;

    signal T : std_logic := '0';
    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal Q : std_logic;
    signal Qn : std_logic;

    constant clk_half : time := 10 ns;
    constant clk_period : time := 20 ns;
    constant clk_quarter : time := 5 ns;

begin

    UUT_TFF : component T_FF
     port map(
        T => T,
        resetn => resetn,
        clk => clk,
        Q => Q,
        Qn => Qn
    );

    clk_generator : process 
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
        clk <= '0';        
    end process;

    test : process
    begin
        wait for clk_period * 2;
        wait for clk_quarter;
        resetn <= '1';
        T <= '1';
        wait for clk_half;
        T <= '0';
        wait for clk_half;
        wait for clk_period;
        T <= '1';
        wait for clk_period * 2;
        resetn <= '0';
        wait for clk_period;
        T <= '0';
        wait for clk_period;
        resetn <= '1';
        wait for clk_period;
        T <= '1';
        wait for clk_period;
        report "Testing is done." severity failure;
        wait;        
    end process;


end architecture rtl;