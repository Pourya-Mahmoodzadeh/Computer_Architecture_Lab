library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4x1_tb is
end entity mux_4x1_tb;

architecture behavior of mux_4x1_tb is

    component mux_4x1
        port (
            I : in std_logic_vector(3 downto 0);
            S : in std_logic_vector(1 downto 0);
            O : out std_logic
        );        
    end component mux_4x1;

    signal selectt : std_logic_vector(1 downto 0) := "00";
    signal input : std_logic_vector(3 downto 0) := "0000";
    signal output : std_logic;

    constant wait_time : time := 10 ns;

begin

    UUT_mux : component mux_4x1
     port map(
        I => input,
        S => selectt,
        O => output
    );

    test_process : process
    begin

        wait for wait_time;

        input(0) <= '1';
        wait for wait_time;

        selectt <= "01";
        wait for wait_time;

        input(1) <= '1';
        wait for wait_time;

        input <= "1001";
        wait for wait_time;

        selectt <= "10";
        wait for wait_time;

        input(2) <= '1';
        wait for wait_time;

        input <= "0000";
        wait for wait_time;


        selectt <= "11";
        wait for wait_time;

        input(3) <= '1';
        wait for wait_time;

        input <= "1100";
        wait for wait_time;

        report "Testing mux completed." severity failure;

        wait;


        
    end process;
end architecture behavior;