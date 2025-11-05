library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity half_adder_tb is
end entity half_adder_tb;



architecture behavior of half_adder_tb is

    component half_adder is
        port (
        i1, i2 : in std_logic;
        sum, cout : out std_logic
    );
    end component half_adder;

    signal i1 : std_logic := '0';
    signal i2 : std_logic := '0';
    signal cout : std_logic;
    signal sum : std_logic;

    signal waiting_time : time := 20 ns;

begin

    uut : component half_adder
        port map (
            i1 => i1,
            i2 => i2,
            cout => cout,
            sum => sum
        );

    test : process
    begin
        wait for waiting_time;
        i1 <= '1';
        wait for waiting_time;
        i2 <= '1';
        wait for waiting_time;
        i2 <= '0';
        wait for waiting_time;
        i1 <= '1';
        wait for waiting_time;
        wait;
    end process test;
end architecture behavior;
