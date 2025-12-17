library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;




entity shift_reg_4bit_tb is
end entity shift_reg_4bit_tb;



architecture  behavior of shift_reg_4bit_tb is

    component shift_reg_4bit
        port( 
            data, data_n : out std_logic_vector(3 downto 0);
            load, reset_n, clk: in std_logic;
            l, r: in std_logic;
            parallel_in : in std_logic_vector(3 downto 0)
        );
    end component shift_reg_4bit;

    signal clk : std_logic := '0';
    signal l : std_logic := '0';
    signal r : std_logic := '0';
    signal parallel_in : std_logic_vector(3 downto 0) := "1010";
    signal reset_n : std_logic := '0';
    signal data : std_logic_vector(3 downto 0);
    signal data_n : std_logic_vector(3 downto 0);
    signal load : std_logic := '0';

    constant waiting_time : time := 20 ns;
    constant clk_period : time := 20 ns;
    constant clk_half : time := 10 ns;
    constant clk_quarter : time := 5 ns;

begin

    uut : component shift_reg_4bit
     port map(
        data => data,
        data_n => data_n,
        load => load,
        reset_n => reset_n,
        clk => clk,
        l => l,
        r => r,
        parallel_in => parallel_in
    );

    clk_generator : process 
        begin
            wait for clk_half;
            clk <= '1';
            wait for clk_half;
            clk <= '0';        
    end process clk_generator;

    test : process 
    begin

        wait for waiting_time * 2;
        wait for clk_quarter;
        
        reset_n <= '1';
        wait for waiting_time;

        load <= '1';
        wait for waiting_time;

        load <= '0';
        r <= '1';
        wait for waiting_time;

        l <= '1';
        wait for waiting_time;

        r <= '0';
        wait for waiting_time;

        report "Testing done." severity failure;

        wait;

    end process test;


end architecture behavior;