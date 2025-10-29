library ieee;
use ieee.std_logic_1164.all;



entity seq_1101_detector_mealy_no_reset_on_detection is
    port (
        x, resetn_async, clk : in std_logic; -- asynchronous active-low reset
        seq_detected : out std_logic
    );
end entity;



architecture behavior of seq_1101_detector_mealy_no_reset_on_detection is

    type state_t is (start, got_1_1st, got_1_2nd, got_0);

    signal current_state : state_t;
    signal next_state : state_t;

begin

    COM : process (current_state, x)
    begin
        next_state <= current_state;
        seq_detected <= '0';
        case current_state is 
            when start =>
                if x = '0' then
                    next_state <= start;
                else 
                    next_state <= got_1_1st;
                end if;
            when got_1_1st => 
                if x = '0' then
                    next_state <= start;
                else 
                    next_state  <= got_1_2nd;
                end if;
            when got_1_2nd => 
                if x = '0' then
                    next_state <= got_0;
                else 
                    next_state <= got_1_2nd;
                end if;
            when got_0 =>
                    if x = '0' then
                        next_state <= start;
                    else
                        seq_detected <= '1';
                        next_state <= got_1_1st;
                    end if;
            when others => 
                    next_state <= start;
        end case;
    end process COM;

    state_reg : process (resetn_async, clk)
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


