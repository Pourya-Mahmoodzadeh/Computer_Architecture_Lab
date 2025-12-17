-- a prototype for booth multiplier, behavioral

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity booth_prototype is
    port (
        in1, in2 : in std_logic_vector(3 downto 0);
        clk, reset, start : in std_logic;
        nloaded, done : out std_logic;
        output: out std_logic_vector(7 downto 0)
    );
end entity booth_prototype;



architecture behavior of booth_prototype is

    component ripple_carry_adder_4bit is
        port (
        i1, i2 : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
    end component ripple_carry_adder_4bit;

    type state_t is (idle, bit0, bit1, bit2, bit3);

    signal current_state : state_t;
    signal next_state : state_t;
    signal in1_reg : std_logic_vector(3 downto 0);
    signal res : std_logic_vector(7 downto 0);
    signal bit_storage : std_logic := '0';

begin

    adder : component ripple_carry_adder_4bit
        port map(
            i1 : 
        )

    COM : process (current_state)
    begin
        done <= '0';
        nloaded <= '1';
        next_state <= current_state;

        case current_state

        when idle =>
            if reset = '0' then
                if start = '1'
                    nloaded <= '0';
                    in1_reg <= in1;
                    res(3 downto 0) <= in2;
                    next_state <= bit0;
                end if;
            end if;

        when bit0 =>
            if reset = '1'
                nloaded <= '1';
                done <= '0';
                next_state <= idle;
            else
                if res(0) & bit_storage = "10"





        when loa




        end case;



    end process COM;
end architecture;