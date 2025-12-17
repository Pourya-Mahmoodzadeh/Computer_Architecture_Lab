library ieee;
use ieee.std_logic_1164.all;



entity carry_select_adder_4bit is 
    port (
        i1, i2 : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end entity;



architecture rtl of carry_select_adder_4bit is

    component ripple_carry_adder_2bit is
        port (
            i1, i2 : in std_logic_vector(1 downto 0);
            cin : in std_logic;
            sum : out std_logic_vector(1 downto 0);
            cout : out std_logic
        );
    end component ripple_carry_adder_2bit;

    component mux_2x1_2bit is 
        port (
            i0, i1 : in std_logic_vector(1 downto 0);
            s : in std_logic;
            o : out std_logic_vector(1 downto 0)
        );
    end component mux_2x1_2bit;

    component mux_2x1 is
        port(
        i0, i1 : in std_logic;
        s : in std_logic; -- the select of the mux
        o : out std_logic
    );
    end component mux_2x1;

    signal tmp_sum0 : std_logic_vector(1 downto 0);
    signal tmp_sum1 : std_logic_vector(1 downto 0);
    signal tmp_cout0 : std_logic;
    signal tmp_cout1 : std_logic_vector(1 downto 0);


begin

    sig0 : component ripple_carry_adder_2bit -- significant 0
     port map(
        i1 => i1(1 downto 0),
        i2 => i2(1 downto 0),
        cin => cin,
        sum => sum(1 downto 0),
        cout => tmp_cout0
    );

    sig0_c0 : component ripple_carry_adder_2bit
     port map(
        i1 => i1(3 downto 2),
        i2 => i2(3 downto 2),
        cin => '0',
        sum => tmp_sum0,
        cout => tmp_cout1(0)
    );

    sig0_c1 : component ripple_carry_adder_2bit
     port map(
        i1 => i1(3 downto 2),
        i2 => i2(3 downto 2),
        cin => '1',
        sum => tmp_sum1,
        cout => tmp_cout1(1)
    );

    mux_for_sum : component mux_2x1_2bit
     port map(
        i0 => tmp_sum0,
        i1 => tmp_sum1,
        s => tmp_cout0,
        o => sum(3 downto 2)
    );

    mux_for_cout : component mux_2x1
     port map(
        i0 => tmp_cout1(0),
        i1 => tmp_cout1(1),
        s => tmp_cout0,
        o => cout
    );



end architecture;