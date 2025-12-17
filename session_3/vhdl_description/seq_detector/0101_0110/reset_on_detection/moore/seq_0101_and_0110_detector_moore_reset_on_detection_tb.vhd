library ieee;
use ieee.std_logic_1164.all;



entity seq_0101_and_0110_detector_moore_reset_on_detection_tb is
end entity seq_0101_and_0110_detector_moore_reset_on_detection_tb;



architecture rtl of seq_0101_and_0110_detector_moore_reset_on_detection_tb is

    component seq_0101_and_0110_detector_moore_reset_on_detection is
        port (
            clk, x, resetn_async : in std_logic;
            seq_detected : out std_logic
        );
    end component seq_0101_and_0110_detector_moore_reset_on_detection;

    signal clk : std_logic := '0';
    signal x : std_logic := '1';
    signal resetn_async : std_logic := '1';
    signal seq_detected : std_logic;

    constant clk_period : time := 20 ns;
    constant clk_half : time := 10 ns;
    constant clk_quarter : time := 5 ns;

begin

    uut : component seq_0101_and_0110_detector_moore_reset_on_detection 
        port map (
            clk => clk,
            x => x,
            resetn_async =>  resetn_async,
            seq_detected => seq_detected
        );

    clock_generator : process
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
        clk <= '0';
    end process clock_generator;

    test : process
    begin
        wait for 2 * clk_period;
        wait for clk_quarter;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period * 2;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period * 2;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        resetn_async <= '0';
        wait for 2 * clk_period;
        resetn_async <= '1';
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        resetn_async <= '0';
        wait for 2 * clk_period;
        resetn_async <= '1'; -- x is 0 from before.
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period * 3;
        x <= '1';
        wait for clk_period * 2;
        x <= '0';
        wait for clk_period * 2;
        report "Testing is done." severity failure;
        wait;
    end process test;
end architecture;


