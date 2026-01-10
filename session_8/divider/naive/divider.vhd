-- uni = suffering.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity divider is 
    port(
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0);
        R : out std_logic_vector(3 downto 0);
        overflow : out std_logic;
        resetn : in std_logic;
        clk : in std_logic;
        start : in std_logic;
        done : out std_logic
    );
end entity;



architecture behavior of divider is

    type state_type is (check_overflow, divide_loop_begining, wait_for_adder_from_check_overflow, wait_for_adder_input_reg_from_check_overflow, check_n_or_n_plus_1_bits, n_bits, R_is_smaller, R_is_not_smaller, wait_for_adder_from_R_is_smaller, done_waiting_for_adder_from_R_is_smaller, wait_for_adder_calculating_sc, adder_done_calculating_sc, hold_results, n_plus_1_bits, wait_for_adder_before_n_plus_1_bits, wait_for_adder_before_n_bits, wait_for_inputs, idle);

    signal sc, sc_next : std_logic_vector(3 downto 0);
    signal pr_state, next_state : state_type;

    signal R_reg, R_reg_next, B_reg_next, B_reg, B_regn : std_logic_vector(3 downto 0);
    signal A_reg, A_reg_next : std_logic_vector(3 downto 0);
    signal E, E_next : std_logic;

    signal overflow_reg, overflow_reg_next, done_reg, done_reg_next : std_logic;


    signal adder_i1_reg, adder_i1_reg_next, adder_i2_reg, adder_i2_reg_next : std_logic_Vector(3 downto 0);
    signal adder_cin_reg, adder_cin_reg_next, adder_cout : std_logic;
    signal adder_sum : std_logic_vector(3 downto 0);

    signal cin : std_logic;
    signal i1, i2 : std_logic_vector(3 downto 0);

    component ripple_carry_adder_4bit is
        port (
            i1, i2 : in std_logic_vector(3 downto 0);
            cin : in std_logic;
            sum : out std_logic_vector(3 downto 0);
            cout : out std_logic
        );
    end component;

begin

    B_regn <= not B_reg;
    Q <= A_reg;
    R <= R_reg;
    done <= done_reg;
    overflow <= overflow_reg;
    cin <= adder_cin_reg;
    i1 <= adder_i1_reg;
    i2 <= adder_i2_reg;


    ADDER_INST : component ripple_carry_adder_4bit
     port map(
        i1 => i1,
        i2 => i2,
        cin => cin,
        sum => adder_sum,
        cout => adder_cout
    );


    SEQ : process (clk) 
    begin
        
            if (rising_edge(clk)) then 
                if resetn = '0' then 
                    overflow_reg <= '0';
                    A_reg <= "0000";
                    B_reg <= "0000";
                    R_reg <= "0000";
                    done_reg <= '0';
                    sc <= "0100";
                    E <= '0';
                    pr_state <= idle;
                else
                    pr_state <= next_state;
                    A_reg <= A_reg_next;
                    B_reg <= B_reg_next;
                    R_reg <= R_reg_next;
                    overflow_reg <= overflow_reg_next;
                    done_reg <= done_reg_next;
                    adder_i1_reg <= adder_i1_reg_next;
                    adder_i2_reg <= adder_i2_reg_next;
                    adder_cin_reg <= adder_cin_reg_next;
                    E <= E_next;
                    sc <= sc_next;
                end if;
            end if;
    end process;

    COM : process (A, B, pr_state, start, A_reg, R_reg, sc, B_regn, R_reg, E, adder_sum, adder_cout, adder_i1_reg, adder_i2_reg, adder_cin_reg, done_reg, overflow_reg) 
    begin 
        case pr_state is
            when idle => 
                done_reg_next <= '0';
                overflow_reg_next <= '0';
                A_reg_next <= "0000";
                B_reg_next <= "0000";
                R_reg_next <= "0000";
                sc_next <= "0100";
                if start = '1' then                     
                    next_state <= wait_for_inputs;
                else 
                    next_state <= idle;
                end if;


            when wait_for_inputs => 
                    A_reg_next <= A(3 downto 0);
                    B_reg_next <= B;
                    R_reg_next <= A(7 downto 4);
                    next_state <= check_overflow;
            when check_overflow => 
                    adder_cin_reg_next <= '1';
                    adder_i1_reg_next <= B_regn;
                    adder_i2_reg_next <= R_reg;

                    next_state <= wait_for_adder_input_reg_from_check_overflow;

            when wait_for_adder_input_reg_from_check_overflow => 
                next_state <= wait_for_adder_from_check_overflow;

            when wait_for_adder_from_check_overflow =>
                if adder_cout = '1' then 
                    done_reg_next <= '1';
                    overflow_reg_next <= '1';

                    next_state <= hold_results;
                else 
                    overflow_reg_next <= '0';

                    next_state <= divide_loop_begining;
                end if;

            when divide_loop_begining => 
                    E_next <= R_reg(3);
                    for i in 2 downto 0 loop 
                        R_reg_next(i + 1) <= R_reg(i);
                        A_reg_next(i + 1) <= A_reg(i);
                    end loop;
                    R_reg_next(0) <= A_reg(3);
                    A_reg_next(0) <= '0';
                    next_state <= check_n_or_n_plus_1_bits;


            when check_n_or_n_plus_1_bits => 
                adder_i1_reg_next <= R_reg;
                adder_i2_reg_next <= B_regn;
                adder_cin_reg_next <= '1';
                if  E = '1' then 
                    next_state <= wait_for_adder_before_n_plus_1_bits;
                else 
                    next_state <= wait_for_adder_before_n_bits;
                end if;

            when wait_for_adder_before_n_plus_1_bits => 
                next_state <= n_plus_1_bits;

            when wait_for_adder_before_n_bits => 
                next_state <= n_bits;

            when n_plus_1_bits =>
                R_reg_next <= adder_sum;
                E_next <= adder_cout;
                A_reg_next(0) <= '1';
                adder_cin_reg_next <= '1';
                adder_i1_reg_next <= sc;
                adder_i2_reg_next <= "1110";
                next_state <= wait_for_adder_calculating_sc;

            when n_bits => 
                R_reg_next <= adder_sum;
                E_next <= adder_cout;
                if adder_cout = '0' then 
                    next_state <= R_is_smaller;
                else 
                    next_state <= R_is_not_smaller;
                end if;

            when R_is_smaller =>
                A_reg_next(0) <= '0';
                adder_cin_reg_next <= '0';
                adder_i1_reg_next <= R_reg;
                adder_i2_reg_next <= B_reg;
                next_state <= wait_for_adder_from_R_is_smaller;

            when wait_for_adder_from_R_is_smaller => 
                next_state <= done_waiting_for_adder_from_R_is_smaller;
                

            when done_waiting_for_adder_from_R_is_smaller =>
                R_reg_next <= adder_sum;
                adder_cin_reg_next <= '1';
                adder_i1_reg_next <= sc;
                adder_i2_reg_next <= "1110";
                next_state <= wait_for_adder_calculating_sc;


            when wait_for_adder_calculating_sc => 
                next_state <= adder_done_calculating_sc;

            when adder_done_calculating_sc =>
                sc_next <= adder_sum;
                if adder_sum = "0000" then 
                    done_reg_next <= '1';
                    next_state <= hold_results;
                else 
                    next_state <= divide_loop_begining;
                end if;

            when R_is_not_smaller => 
                A_reg_next(0) <= '1';
                adder_cin_reg_next <= '1';
                adder_i1_reg_next <= sc;
                adder_i2_reg_next <= "1110";
                next_state <= wait_for_adder_calculating_sc;

            when hold_results => 
                done_reg_next <= '1';
                A_reg_next <= A_reg;
                R_reg_next <= R_reg;
                next_state <= hold_results;











        end case;
    end process;



    

end architecture;