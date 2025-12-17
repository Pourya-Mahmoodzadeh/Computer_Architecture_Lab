library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity seq_1101_detector_moore_no_reset_on_detection_tb is
end entity;



architecture rtl of seq_1101_detector_moore_no_reset_on_detection_tb is

    component seq_1101_detector_moore_no_reset_on_detection
        port (
        x, resetn_async, clk : in std_logic; -- asynchronous active-low reset
        seq_detected : out std_logic
    );
    end component seq_1101_detector_moore_no_reset_on_detection;

    signal clk : std_logic := '0';
    signal resetn_async : std_logic := '1';
    signal x : std_logic := '0';
    signal seq_detected : std_logic;

    constant clk_period : time := 20 ns;
    constant clk_half : time := 10 ns;
    constant clk_quarter : time := 5 ns;

begin

    uut : component seq_1101_detector_moore_no_reset_on_detection
        port map (
            clk => clk,
            resetn_async => resetn_async,
            x => x,
            seq_detected => seq_detected
        );

    clk_gen : process 
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half; 
        clk <= '0';
    end process clk_gen;

    test : process
    begin
        wait for 2 * clk_period;
        wait for clk_quarter;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        resetn_async <= '0';
        wait for 2 * clk_period;
        resetn_async <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '1';
        wait for clk_period;
        x <= '0';
        wait for clk_period;
        x <= '1';
        wait for 2 * clk_period;
        report "Testing done." severity failure;
        wait;
    end process test;
end architecture;