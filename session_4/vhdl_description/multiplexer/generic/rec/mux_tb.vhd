library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity mux_tb is 
    generic(
        SEL_WIDTH : integer := 2;
        DATA_WIDTH : integer := 3;
        WAITING_TIME : time := 20 ns
    );
end entity;



architecture behavior of mux_tb is

    signal enable : std_logic := '1';
    signal output : std_logic_vector(DATA_WIDTH - 1 downto 0);
    signal sel : std_logic_vector(SEL_WIDTH - 1 downto 0) := std_logic_vector(to_unsigned(0, SEL_WIDTH));
    signal data : std_logic_vector(DATA_WIDTH * (2** SEL_WIDTH) - 1 downto 0);

    type vector2D is array(2** SEL_WIDTH - 1 downto 0) of std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal matrix : vector2D;


begin

    ORG_DATA:for i in 2**SEL_WIDTH downto 1  generate 
        data(DATA_WIDTH * i - 1 downto  DATA_WIDTH * i - DATA_WIDTH) <= matrix(i - 1);
    end generate;

    UUT : entity work.mux 
        generic map(
            SEL_WIDTH => SEL_WIDTH,
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
            enable => enable,
            sel => sel,
            output => output,
            data => data
        );

    TEST : process 
        variable expected_out : std_logic_vector(DATA_WIDTH - 1 downto 0);
    begin
            for i in 2**SEL_WIDTH downto 1  loop 
                matrix(i - 1) <= std_logic_vector(to_unsigned(i, DATA_WIDTH));
            end loop;
            wait for WAITING_TIME;

            for i in 0 to 2**SEL_WIDTH - 1 loop 
                sel <= std_logic_vector(to_unsigned(i, SEL_WIDTH));
                expected_out := matrix(i);
                wait for WAITING_TIME;
                assert expected_out = output 
                    report "Assertion failed when sel = " & integer'image(i)
                    severity error;
                wait for WAITING_TIME;
            end loop;
            wait for WAITING_TIME;
        report "Testing done." severity NOTE;
        std.env.finish;
        wait;
    end process;   

end architecture;