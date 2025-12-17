library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



-- This wrapper file allows adds the necessary tools so that this description could be used on FPGA, in this case, we just needed a clock divider for that purpose.
entity ripple_counter_wrapper is
    port (
        clk, resetn, stopn : in std_logic;
        count : out std_logic_vector(3 downto 0)
    );
end entity ripple_counter_wrapper;



architecture rtl of ripple_counter_wrapper is

    component clk_div
        port (
            clk_in  : in  STD_LOGIC;   
            clk_out : out STD_LOGIC   
        );
    end component clk_div;

    component ripple_counter 
        port (
            clk, resetn, stopn : in std_logic;
            count : out std_logic_vector(3 downto 0)
        );
    end component ripple_counter; 

    signal clk_out : std_logic;

begin

    the_clock_divider : component clk_div
     port map(
        clk_in => clk,
        clk_out => clk_out
    );

    the_ripple_counter : component ripple_counter
        port map (
            clk => clk_out,
            resetn => resetn,
            stopn => stopn,
            count => count
        );

end architecture rtl;