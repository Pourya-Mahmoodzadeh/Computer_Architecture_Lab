library ieee;
use ieee.std_logic_1164.all;



entity ripple_counter_tb is
end entity ripple_counter_tb;



architecture rtl of ripple_counter_tb is

    component ripple_counter
        port (
            clk, resetn, stopn : in std_logic;
            count : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal resetn : std_logic := '0';
    signal stopn : std_logic := '1';
    signal count : std_logic_vector(3 downto 0);

    constant clk_half : time  := 10 ns;
    constant clk_period : time := 20 ns;
    constant clk_quarter : time := 5 ns;
    
begin

    uut_ripple_counter : component ripple_counter
     port map(
        clk => clk,
        resetn => resetn,
        stopn => stopn,
        count => count
    );

    clk_generator : process 
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
        clk <= '0';
    end process clk_generator;

    test : process
    begin
        wait for clk_period ;
        resetn <= '1';
        wait for clk_period;
        wait for clk_quarter;
        wait for clk_period * 12;
        resetn <= '0';
        wait for clk_period * 2;
        resetn <= '1';
        wait for clk_period * 6;
        stopn <= '0';
        wait for clk_period * 4;
        stopn <= '1';
        wait for clk_period * 4;
        report "Finish testing." severity failure;
        wait;
    end process;
end architecture rtl;