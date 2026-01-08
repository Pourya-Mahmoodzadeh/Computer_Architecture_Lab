library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;



entity mux is 
    generic(
        SEL_WIDTH : integer := 2;
        DATA_WIDTH : integer := 8
    );
    port(
        sel : in std_logic_vector(SEL_WIDTH - 1 downto 0);
        data : in std_logic_vector(DATA_WIDTH * (2**SEL_WIDTH) - 1 downto 0); -- Another reason to dislike VHDL (93). Can't you just give me a simple 2D array?
        output : out std_logic_vector(DATA_WIDTH - 1 downto 0);
        enable : in std_logic
    );
end entity;



architecture behavior of mux is

    signal sel_MSB_not : std_logic;
    signal s0out : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal s1out : std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal out_before_en : std_logic_vector(DATA_WIDTH -1  downto 0);



begin

    sel_MSB_not <= not sel(SEL_WIDTH - 1);

    BASIS: if SEL_WIDTH = 1 generate
        output <= std_logic_vector(to_unsigned(0, DATA_WIDTH)) when enable = '0' else 
            data(2*DATA_WIDTH - 1 downto DATA_WIDTH) when sel = std_logic_vector(to_unsigned(1, 1)) else 
            data(DATA_WIDTH - 1 downto 0);
    end generate;

    STEP: if SEL_WIDTH > 1 generate

        S1: entity work.mux 
        generic map(
            SEL_WIDTH => SEL_WIDTH - 1,
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            sel => sel(SEL_WIDTH - 2 downto 0),
            data => data(DATA_WIDTH * (2** SEL_WIDTH) -1 downto DATA_WIDTH * (2** (SEL_WIDTH - 1))),
            enable => sel(SEL_WIDTH - 1),
            output => s1out
        );

        S0: entity work.mux 
        generic map(
            SEL_WIDTH => SEL_WIDTH - 1,
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            sel => sel(SEL_WIDTH - 2 downto 0),
            data => data(DATA_WIDTH * 2** (SEL_WIDTH - 1) - 1 downto 0),
            enable => sel_MSB_not,
            output => s0out
        );
        out_before_en <= (s0out or s1out);

        ENABLE_LOGIC: for i in DATA_WIDTH -1 downto 0 generate 
            output(i) <= out_before_en(i) and enable;
        end generate;
    end generate;

end architecture;