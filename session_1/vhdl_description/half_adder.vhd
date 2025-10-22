library ieee;
use ieee.std_logic_1164.all;



entity half_adder is
    port (
        in_1, in_2 : in std_logic;
        sum, c_out : out std_logic
    );
end entity half_adder;



architecture rtl of half_adder is

    component and_2in
        port (
            in_1, in_2 : in std_logic;
            out_1 : out std_logic
        );
    end component and_2in;

    component xor_2in
        port (
            in_1, in_2 : in std_logic;
            out_1 : out std_logic
        );
    end component xor_2in;  

    begin

        my_or : component and_2in
            port map (
                in_1 => in_1,
                in_2 => in_2,
                out_1 => c_out
            );

        my_xor : component xor_2in
         port map(
            in_1 => in_1,
            in_2 => in_2,
            out_1 => sum
        );
        
end architecture rtl;