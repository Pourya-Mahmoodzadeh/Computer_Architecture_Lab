library ieee;
use ieee.std_logic_1164.all;



entity ripple_carry_adder_2bit is
    port (
        i1, i2 : in std_logic_vector(1 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(1 downto 0);
        cout : out std_logic
    );
end entity;



architecture rtl of ripple_carry_adder_2bit is 

    component full_adder is 
        port (
        i1, i2, i3 : in std_logic;
        sum, cout : out std_logic
    );
    end component full_adder;

    signal prev_cout : std_logic;

begin

    sig0 : component full_adder -- sig stands for significance of the inputs and outputs related to half/full adder.
     port map(
        i1 => i1(0),
        i2 => i2(0),
        i3 => cin,
        sum => sum(0),
        cout => prev_cout
    );

    sig1 : component full_adder
     port map(
        i1 => i1(1),
        i2 => i2(1),
        i3 => prev_cout,
        sum => sum(1),
        cout => cout
    );

    

end architecture rtl;