library ieee;
use ieee.std_logic_1164.all;


entity full_adder is
    port (
        in_1, in_2, c_in : in std_logic;
        sum, c_out : out std_logic
    );
    end entity full_adder;



architecture rtl of full_adder is

    component half_adder
        port (
            in_1, in_2 : in std_logic;
            sum, c_out : out std_logic
        );
        end component half_adder;

    component or_2in
        port (
            in_1, in_2 : in std_logic;
            out_1 : out std_logic
        );
        end component or_2in;

        signal intermediate_c_out_1 : std_logic;
        signal intermediate_c_out_2 : std_logic;
        signal intermediate_sum : std_logic;

    begin

        first_half_adder : component half_adder 
            port map (
                in_1 => in_1,
                in_2 => in_2,
                c_out => intermediate_c_out_1,
                sum => intermediate_sum
            );

        second_half_adder : component half_adder
            port map (
                in_1 => intermediate_sum,
                in_2 => c_in,
                c_out => intermediate_c_out_2,
                sum => sum
            );

        my_or : component or_2in
         port map(
            in_1 => intermediate_c_out_1,
            in_2 => intermediate_c_out_2,
            out_1 => c_out
        );       

    end architecture rtl;