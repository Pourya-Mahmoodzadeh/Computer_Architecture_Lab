library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity simillarity_checker_tb is 
    generic(
        DATA_WIDTH : positive := 4;
        WAITING_TIME : time := 20 ns;
        SEED1 : positive := 1;
        SEED2 : positive := 2;
        NUM : positive := 20
    );
end entity;



architecture behavior of simillarity_checker_tb is

    subtype in_type is std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal mask, data1, data2 : in_type := std_logic_vector(to_unsigned(0, DATA_WIDTH));
    signal simillar : std_logic;

begin

    UUT: entity work.simillarity_checker
     generic map(
        DATA_WIDTH => DATA_WIDTH
    )
     port map(
        mask => mask,
        data1 => data1,
        data2 => data2,
        simillar => simillar
    );

    TEST: process 
        variable seed1_copy : positive := SEED1;
        variable seed2_copy : positive := SEED2;
        variable rand_real_mask, rand_real_data1, rand_real_data2 : real;
        variable rand_mask, rand_data1, rand_data2 : in_type;
    begin
        report "Starting the test for DATA_WIDTH = " & integer'image(DATA_WIDTH) severity note;
        for j in 1 to NUM loop 
            report "Starting the " & integer'image(j) & "th iteration of the loop" severity note;
            uniform(seed1_copy, seed2_copy, rand_real_data1);
            uniform(seed1_copy, seed2_copy, rand_real_data2);
            uniform(seed1_copy, seed2_copy, rand_real_mask);

            rand_mask := std_logic_vector(to_unsigned(integer(rand_real_mask * real(2**DATA_WIDTH - 1)), DATA_WIDTH));
            rand_data1 := std_logic_vector(to_unsigned(integer(rand_real_data1 * real(2**DATA_WIDTH - 1)), DATA_WIDTH));
            rand_data2 := std_logic_vector(to_unsigned(integer(rand_real_data2 * real(2**DATA_WIDTH - 1)), DATA_WIDTH));

            data1 <= rand_data1;
            data2 <= rand_data2;
            mask <= rand_mask;

            wait for WAITING_TIME;

            for i in DATA_WIDTH - 1 downto 0 loop
                if mask(i) = '0' and simillar = '1' then 
                    assert data1(i) = data2(i)
                        -- report "Assertion failed for data1 = " & to_string(data1) & ", data2 = " & to_string(unsigned(data2)) & ", mask = " & to_string(mask)
                           report "Assertion failed."
                            severity error;
                end if;
            end loop;
        end loop;
        report "Testing done for DATA_WIDTH = " & integer'image(DATA_WIDTH) severity note;
        wait;
    end  process;

    

end architecture;