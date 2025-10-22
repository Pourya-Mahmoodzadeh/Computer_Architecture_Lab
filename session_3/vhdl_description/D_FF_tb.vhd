library ieee;
use ieee.std_logic_1164.all;



entity D_FF_tb is
end entity D_FF_tb;



architecture rtl of D_FF_tb is

    component D_FF 
        port (
            D, clk, load, reset : in std_logic;
            Q, Qn : out std_logic
        );
    end component D_FF;

    signal D : std_logic := '0';
    signal clk : std_logic := '0';
    signal load : std_logic := '1';
    signal reset : std_logic := '1'; -- Warning: The reset is active-low.
    signal Q : std_logic;
    signal Qn : std_logic;

    constant  clk_period : time := 20 ns;
    constant clk_half : time := 10 ns;
    

begin

    UUT_D_FF : component D_FF
        port map (
            D => D,
            clk => clk,
            load => load,
            reset => reset,
            Q => Q,
            Qn => Qn
        );

    clock_generator : process 
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
        clk <= '0';
    end process;

    test_precess : process
    begin
        wait for clk_period * 2;        
        D <= '1';
        wait for 5 ns;
        D <= '0';
        wait for 30 ns;
        D <= '1';
        load <= '0';
        wait for 30 ns;
        load <= '1';
        wait for 30 ns;
        reset <= '0';
        wait for 50 ns;
        reset <= '1';
        wait for 30 ns;
        report "Testing is done." severity failure;
        wait;
    end process;

end architecture rtl;
