library ieee;
use ieee.std_logic_1164.all;



entity mux_2x1_2bit is 
    port (
        i0, i1 : in std_logic_vector(1 downto 0);
        s : in std_logic;
        o : out std_logic_vector(1 downto 0)
    );
end entity;



architecture rtl of mux_2x1_2bit is

    component mux_2x1 is
        port(
            i0, i1 : in std_logic;
            s : in std_logic; -- the select of the mux
            o : out std_logic
        );
    end component mux_2x1;

begin

    sig0 : component mux_2x1
     port map(
        i0 => i0(0),
        i1 => i1(0),
        s => s,
        o => o(0)
    );

    sig1 : component mux_2x1
     port map(
        i0 => i0(1),
        i1 => i1(1),
        s => s,
        o => o(1)
    );


end architecture;