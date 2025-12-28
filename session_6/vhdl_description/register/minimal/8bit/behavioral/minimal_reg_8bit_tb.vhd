library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity minimal_reg_8bit_tb  is
end entity;



architecture behavior of minimal_reg_8bit_tb is

    component minimal_reg_8bit
        port(
            data : in std_logic_vector(7 downto 0);
            clear_n, clk : in std_logic;
            Q, Q_n : out std_logic_vector(7 downto 0)
        );
    end component;

    signal Q, Q_n : std_logic_vector(7 downto 0);
    signal data : std_logic_vector(7 downto 0) := "10101011";
    signal clear_n, clk : std_logic := '0';

    constant clk_period : time := 20 ns;
    constant clk_half : time := 10 ns;
    constant clk_quarter : time := 5 ns;

begin

    UUT: component minimal_reg_8bit
     port map(
        data => data,
        clear_n => clear_n,
        clk => clk,
        Q => Q,
        Q_n => Q_n
    );

    CLOCK_GENERATOR:    process
    begin
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
        clk <= '0';        
    end process;

    TEST: process 
    begin
        wait for clk_quarter;
        wait for clk_period * 2;
        clear_n <= '1';
            for i in 255 downto 0 loop
                data <= std_logic_vector(to_unsigned(i, 8));
                wait for clk_period;
                assert Q = data;
                assert Q = not Q_n;            
            end loop;
        clear_n <= '0';
        wait for clk_period;
        report "Testing done" severity failure;
        wait;
    end process;  
end architecture;