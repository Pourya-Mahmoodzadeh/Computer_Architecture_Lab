library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity mux_2x1_tb is
end entity;



architecture behavior of mux_2x1_tb is

    component mux_2x1 is
        port(
        i0, i1 : in std_logic;
        s : in std_logic; -- the select of the mux
        o : out std_logic
    );
    end component mux_2x1;

    signal i0 : std_logic := '0';
    signal i1 : std_logic := '0';
    signal s : std_logic := '0';
    signal o : std_logic;

    signal waiting_time : time := 20 ns;

begin

    uut : component mux_2x1
     port map(
        i0 => i0,
        i1 => i1,
        s => s,
        o => o
    );

    test : process 
    begin
        wait for waiting_time;
        s <= '1';
        wait for waiting_time;
        i0 <= '1';
        wait for waiting_time;
        s <= '0';
        wait for waiting_time;
        i1 <= '1';
        wait for waiting_time;
        s <= '1';
        wait for waiting_time;
        i0 <= '0';
        wait for waiting_time;
        s <= '0';
        wait for waiting_time;
        wait;

    end process;

end architecture;