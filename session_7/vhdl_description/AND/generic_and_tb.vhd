library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity generic_and_tb is 
    generic(
        WIDTH : positive := 3;
        WAITING_TIME : time := 10 ns;
        NUM : positive := 10; -- Number of iterations
        SEED1 : positive := 1;
        SEED2 : positive := 2
    );
end entity;




architecture behavior of generic_and_tb is

    subtype data_type is std_logic_vector(WIDTH - 1 downto 0);

    signal input : data_type := std_logic_vector(to_unsigned(0, WIDTH));
    signal output : std_logic;

begin

    UUT : entity work.generic_and 
        generic map(
            WIDTH => WIDTH
        )
        port map(
            input => input,
            output => output
        );

    TEST : process 
        variable seed1_copy : positive := SEED1;
        variable seed2_copy : positive := SEED2;
        variable rand_real : real;
        variable rand_input : data_type;

    begin

        report "Starting the test" severity note;

        for i in 1 to NUM loop 

            uniform(seed1_copy, seed2_copy, rand_real);
            rand_input := std_logic_vector(to_unsigned(integer(rand_real * real(2**WIDTH - 1)), WIDTH));

            input <= rand_input;
            wait for WAITING_TIME;
        end loop;
            report "Testing done" severity note;
        wait;
    end process;

    

end architecture;