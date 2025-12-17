library ieee;
use ieee.std_logic_1164.all;



entity ripple_carry_adder_subtrator is
    port (
        i1, i2 : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end entity ripple_carry_adder_subtrator;



architecture rtl of ripple_carry_adder_subtrator is

    component ripple_carry_adder_4bit is 
        port (
        i1, i2 : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
    end component ripple_carry_adder_4bit;

    signal not_cin : std_logic;
    signal not_in1 : std_logic_vector(3 downto 0);
    signal adder_in1 : std_logic_vector(3 downto 0);

begin

    



    

end architecture;