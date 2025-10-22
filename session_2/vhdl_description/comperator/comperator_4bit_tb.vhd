library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comperator_4bit_tb is
end entity comperator_4bit_tb;

architecture behaviour of comperator_4bit_tb is

    component comperator_4bit
        port (
        a4, b4 : in STD_LOGIC_VECTOR(3 downto 0);
        a_gt_b_final, a_lt_b_final, a_eq_b_final : out STD_LOGIC
    );
    end component comperator_4bit;

    signal a_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal b_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal output_a_gt_b : STD_LOGIC;
    signal output_a_eq_b : STD_LOGIC;
    signal output_a_lt_b : STD_LOGIC;

    constant wait_time : time := 10 ns;

begin

    uut : component comperator_4bit
        port map(
           a4 => a_in,
           b4 => b_in,
           a_gt_b_final => output_a_gt_b,
           a_eq_b_final => output_a_eq_b,
           a_lt_b_final => output_a_lt_b
        );

    test_process : process
    begin
        wait for wait_time;

        a_in <= "0001";
        wait for wait_time;

        b_in <= "0001";
        wait for wait_time;

        b_in <= "1100";
        wait for wait_time;

        report "Testing is done." severity failure;
        wait;
        
    end process;
end architecture behaviour;