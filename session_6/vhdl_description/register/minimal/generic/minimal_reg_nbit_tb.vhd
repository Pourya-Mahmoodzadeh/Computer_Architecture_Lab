library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity minimal_reg_nbit_tb is
    generic(
        WIDTH : integer := 8;
        CLK_QUARTER : time := 5 ns
    );
end entity;



architecture behavior of minimal_reg_nbit_tb is

    signal clk, clear_n : std_logic := '0';
    signal Q, Q_n : std_logic_vector((WIDTH - 1) downto 0);
    signal data : std_logic_vector((WIDTH - 1) downto 0) := std_logic_vector(to_unsigned(2**WIDTH - 1, WIDTH));
    
    constant CLK_HALF : time := 2 * CLK_QUARTER;
    constant CLK_PERIOD : time := 2 * CLK_HALF;

begin

    UUT : entity work.minimal_reg_nbit
        generic map(
            n => WIDTH
        )
        port map(
            clear_n => clear_n,
            clk => clk,
            data => data,
            Q => Q,
            Q_n => Q_n
        );

    clk <= not clk after CLK_HALF;

    TEST: process 
    begin

        wait for CLK_QUARTER;
        wait for CLK_PERIOD * 2;

        clear_n <= '1';

        TRY_EVERY_CASE : for i in (2**WIDTH - 1) downto 0 loop
            
            data <= std_logic_vector(to_unsigned(i, WIDTH));
            wait for CLK_PERIOD;

            assert (Q = data) and (Q = not Q_n)
                report "Fail at value " & integer'image(i)
                severity error;  

        end loop;

        report "Testing finished successfully." severity failure;
        wait;
    end process;



    

end architecture;