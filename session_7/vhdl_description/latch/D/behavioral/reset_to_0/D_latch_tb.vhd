library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity D_latch_tb is
end entity D_latch_tb;



architecture behavior of D_latch_tb is

    component D_latch 
        port(
            enable, clear_n, D : in std_logic;
            Q, Q_n : out std_logic
        );
    end component D_latch;

    signal enable : std_logic := '1';
    signal clear_n : std_logic := '0';
    signal D : std_logic := '1';
    signal Q : std_logic;
    signal Q_n : std_logic;
    signal waiting_time : time := 20 ns;

begin

    uut : component D_latch
     port map(
        enable => enable,
        clear_n => clear_n,
        D => D,
        Q => Q,
        Q_n => Q_n
    );

    TEST : process 
    begin
        wait for waiting_time;
        clear_n <= '1';
        wait for waiting_time;
        D <= '0';
        wait for waiting_time;
        D <= '0';
        wait for waiting_time;
        enable <= '0';
        wait for waiting_time;
        D <= '1';
        wait for waiting_time;
        enable <= '1';
        wait for waiting_time;
        clear_n <= '0';
        wait for waiting_time;
        report "Testing done." severity failure;
        wait;
    end process TEST;

    

end architecture;