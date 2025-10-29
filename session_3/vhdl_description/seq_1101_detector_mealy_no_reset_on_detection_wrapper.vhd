library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity seq_1101_detector_mealy_no_reset_on_detection_wrapper is
    port (
        x, resetn_async, clk : in std_logic; -- asynchronous active-low reset
        seq_detected : out std_logic
    );
end entity;



architecture rtl of seq_1101_detector_mealy_no_reset_on_detection_wrapper is

    component seq_1101_detector_mealy_no_reset_on_detection
        port (
        x, resetn_async, clk : in std_logic; -- asynchronous active-low reset
        seq_detected : out std_logic
        );
    end component seq_1101_detector_mealy_no_reset_on_detection;

    component clk_div 
        port (
        clk_in  : in  STD_LOGIC;   
        clk_out : out STD_LOGIC   
        );
    end component clk_div;

    signal clk_system : std_logic;

begin

    clock_divider : component clk_div 
        port map (
            clk_in => clk,
            clk_out => clk_system
        );

    seq_detector : component seq_1101_detector_mealy_no_reset_on_detection
        port map (
            clk => clk_system,
            x => x,
            resetn_async => resetn_async,
            seq_detected => seq_detected
        );
        
end architecture;
    

        