-- a test bench for the naive divider (it is naive, but it doesn't mean it doesn't work or is too trash!)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity divider_tb is 
    generic ( 
        NUM : positive := 10
    );
end entity;




architecture behavior of divider_tb is

    signal A : std_logic_vector(7 downto 0) := "10000000";
    signal B : std_logic_vector(3 downto 0) := "0110";
    signal R, Q : std_logic_vector(3 downto 0);
    signal clk, resetn, start : std_logic := '0';
    signal overflow, done : std_logic;
    signal testing_done : std_logic := '0';

    constant clk_half : time := 10 ns;
    constant clk_period : time := 20 ns;
    constant waiting_time : time := 40 ns;

    component divider is 
    port(
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0);
        R : out std_logic_vector(3 downto 0);
        overflow : out std_logic;
        resetn : in std_logic;
        clk : in std_logic;
        start : in std_logic;
        done : out std_logic
    );
    end component;

begin

    UUT : component divider
     port map(
        A => A,
        B => B,
        Q => Q,
        R => R,
        overflow => overflow,
        resetn => resetn,
        clk => clk,
        start => start,
        done => done
    );

    CLK_GEN : process 
    begin 
        if testing_done = '1' then 
            wait;
        end if;
        clk <= '0';
        wait for clk_half;
        clk <= '1';
        wait for clk_half;
    end process;
        

    TEST : process 
        variable seed1 : positive := 1;
        variable seed2 : positive := 2;
        variable rand_real_A : real;
        variable rand_real_B : real;
        -- variable seed3 : positive := 3;
        -- variable seed4 : positive := 4;
    begin 
        for i in 1 to NUM loop 
            report integer'image(i) & "th iteration started." severity note;
            wait for waiting_time;
            resetn <= '1';
            wait for waiting_time;
            uniform(seed1, seed2, rand_real_A);
            A <= std_logic_vector(to_unsigned(integer(rand_real_A * real(255)), 8));
            uniform(seed1, seed2, rand_real_B);
            B <= std_logic_vector(to_unsigned(integer(rand_real_B * real(15)), 4));
            wait for waiting_time;
            start <= '1';
            wait until done <= '1';
            start <= '0';
            resetn <= '0';
        end loop;
        testing_done <= '1';
        report "Testing done." severity note;

        wait;
    end process;

    

end architecture;