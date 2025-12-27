library ieee;
use ieee.std_logic_1164.all;



entity shift_reg_4bit is 
    port( 
        data, data_n : out std_logic_vector(3 downto 0);
        load, reset_n, clk: in std_logic;
        l, r: in std_logic;
        parallel_in : in std_logic_vector(3 downto 0)
    );
end entity shift_reg_4bit;



architecture rtl of shift_reg_4bit is

    component D_FF
        port (
        D, clk, load, reset : in std_logic; -- Warning: the reest is active-low
        Q, Qn : out std_logic
        );
    end component D_FF;

    signal D : std_logic_vector(3 downto 0);
    signal l_not : std_logic;
    signal r_not : std_logic;
    signal anded_parallel : std_logic_vector(3 downto 0);
    signal control : std_logic;
    signal load_not : std_logic;
    signal left_shift : std_logic;
    signal left_shift_d : std_logic_vector(3 downto 0);
    signal q : std_logic_vector(3 downto 0);
    signal q_not : std_logic_vector(3 downto 0);
    signal logical_right_shift : std_logic;
    signal logical_right_shift_d : std_logic_vector(3 downto 0);
    signal arithmetic_right_shift : std_logic;
    signal arithmetic_right_shift_d : std_logic_vector(3 downto 0);

begin

    l_not <= not l;
    r_not <= not r;
    load_not <= not load;

    control <= r or l or load;

    anded_parallel(3) <= parallel_in(3) and load;
    anded_parallel(2) <= parallel_in(2) and load;
    anded_parallel(1) <= parallel_in(1) and load;
    anded_parallel(0) <= parallel_in(0) and load;

    left_shift <= l and r_not and load_not;
    logical_right_shift <= l_not and r and load_not;
    arithmetic_right_shift <= l and r and load_not;



    d_ff0 : component D_FF
     port map(
        D => D(0),
        clk => clk,
        load => control,
        reset => reset_n,
        Q => q(0),
        Qn => q_not(0)
    );

    d_ff1 : component D_FF
     port map(
        D => D(1),
        clk => clk,
        load => control,
        reset => reset_n,
        Q => q(1),
        Qn => q_not(1)
    );

    d_ff2 : component D_FF
     port map(
        D => D(2),
        clk => clk,
        load => control,
        reset => reset_n,
        Q => q(2),
        Qn => q_not(2)
    );

    d_ff3 : component D_FF
     port map(
        D => D(3),
        clk => clk,
        load => control,
        reset => reset_n,
        Q => q(3),
        Qn => q_not(3)
    );

    left_shift_d(3) <= q(2) and left_shift;
    left_shift_d(2) <= q(1) and left_shift;
    left_shift_d(1) <= q(0) and left_shift;
    left_shift_d(0) <= '0' and left_shift;

    logical_right_shift_d(3) <= '0' and logical_right_shift;
    logical_right_shift_d(2) <= q(3) and logical_right_shift;
    logical_right_shift_d(1) <= q(2) and logical_right_shift;
    logical_right_shift_d(0) <= q(1) and logical_right_shift;

    arithmetic_right_shift_d(3) <= q(3) and arithmetic_right_shift;
    arithmetic_right_shift_d(2) <= q(3) and arithmetic_right_shift;
    arithmetic_right_shift_d(1) <= q(2) and arithmetic_right_shift;
    arithmetic_right_shift_d(0) <= q(1) and arithmetic_right_shift;

    D(0) <= anded_parallel(0) or left_shift_d(0) or logical_right_shift_d(0) or arithmetic_right_shift_d(0);
    D(1) <= anded_parallel(1) or left_shift_d(1) or logical_right_shift_d(1) or arithmetic_right_shift_d(1);
    D(2) <= anded_parallel(2) or left_shift_d(2) or logical_right_shift_d(2) or arithmetic_right_shift_d(2);
    D(3) <= anded_parallel(3) or left_shift_d(3) or logical_right_shift_d(3) or arithmetic_right_shift_d(3);

    data(0) <= q(0);
    data(1) <= q(1);
    data(2) <= q(2);
    data(3) <= q(3);

    data_n(0) <= q_not(0);
    data_n(1) <= q_not(1);
    data_n(2) <= q_not(2);
    data_n(3) <= q_not(3);

end architecture;