library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity full_adder_tb is
end entity full_adder_tb;



architecture behavior of full_adder_tb is

    component full_adder is
        port (
        i1, i2, i3 : in std_logic;
        sum, cout : out std_logic
    );
    end component full_adder;

    signal i1 : std_logic := '0';
    signal i2 : std_logic  := '0';
    signal i3 : std_logic := '0';
    signal cout : std_logic;
    signal sum : std_logic;

    signal waiting_time : time := 20 ns;

begin

    uut : component full_adder
        port map (
            i1 => i1,
            i2 => i2,
            i3 => i3,
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
        i1 <= '0';
        wait for waiting_time;
        i3 <= '1';
        wait for waiting_time;
        i1 <= '1';
        wait for waiting_time;

        wait;
    end process;

end architecture behavior;

