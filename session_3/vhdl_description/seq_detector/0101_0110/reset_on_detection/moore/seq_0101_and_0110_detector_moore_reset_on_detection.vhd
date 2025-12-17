library ieee;
use ieee.std_logic_1164.all;



entity seq_0101_and_0110_detector_moore_reset_on_detection is 
    port (
        clk, x, resetn_async : in std_logic;
        seq_detected : out std_logic
    );
end entity seq_0101_and_0110_detector_moore_reset_on_detection;



architecture behavior of seq_0101_and_0110_detector_moore_reset_on_detection is

    type state_t is (start, got_gen_0, got_gen_1, got_seq2_1, got_seq1_0, a_seq_detected);
    -- sequence 1: 0101, sequence 2: 0110

    signal current_state : state_t;
    signal next_state : state_t;

begin

    COM : process (x, current_state)
    begin

        seq_detected <= '0';
        next_state <= current_state;

        case current_state is

            when start => 
                if x = '0' then
                    next_state <= got_gen_0;
                else
                    next_state <= start;
                end if;

            when got_gen_0 => 
                if x = '0' then
                    next_state <= got_gen_0;
                else 
                    next_state <= got_gen_1;
                end if;

            when got_gen_1 =>
                if x = '0' then
                    next_state <= got_seq1_0;
                else
                    next_state <= got_seq2_1;
                end if;

            when got_seq1_0 =>
                if  x = '0' then 
                    next_state <= got_gen_0;
                else
                    next_state <= a_seq_detected;
                end if;
            
            when got_seq2_1 => 
                if x = '0' then
                    next_state <= a_seq_detected;
                else 
                    next_state <= start;
                end if;

            when a_seq_detected =>
                seq_detected <= '1';
                next_state <= start;
            
            when others =>
                next_state <= start;
        end case;
    end process COM;

    state_reg : process (clk, resetn_async)
    begin
        if resetn_async = '0' then
            current_state <= start;
        else
            if rising_edge(clk) then
                current_state <= next_state;
            end if;
        end if;
    end process state_reg;
end architecture behavior;
