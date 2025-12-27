library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity D_FF_behavioral_tb is
end entity;



architecture behavior of D_FF_behavioral_tb is

    component D_FF_behavioral
        port (
		    reset_n, clk, D : in std_logic;
		    Q, Q_n : out std_logic
	    );
    end component;

    signal clk, reset_n : std_logic := '0';
    signal D : std_logic := '1';
    signal Q, Q_n : std_logic;

    signal clk_period : time := 20 ns;
    signal clk_half : time  := 10 ns;
    signal clk_quarter : time := 5 ns;
    signal waiting_time : time := clk_period;

begin

    uut : component D_FF_behavioral
     port map(
        D => D,
        clk => clk,
        reset_n => reset_n,
        Q => Q,
        Q_n => Q_n
    );

    CLK_GEN : process 
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
        clk <= '0';
    end process CLK_GEN;

    TEST : process
    begin
        wait for waiting_time;
        wait for clk_quarter;
        reset_n <= '1';
        wait for waiting_time * 2;
        D <= '0';
        wait for waiting_time;
        D <= '1';
        wait for waiting_time;
        reset_n <= '0';
        wait for waiting_time * 2;        
        report "Testing_done" severity failure;
        wait;
    end process;

    

end architecture;