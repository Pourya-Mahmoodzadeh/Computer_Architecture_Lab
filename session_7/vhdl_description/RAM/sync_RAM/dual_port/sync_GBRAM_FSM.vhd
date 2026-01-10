-- Note: If you try to both read and write to the same address at the same time (clk), this tells the sync_GBRAM to first write and then read
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity sync_GBRAM_FSM is 
    generic ( 
        ADDR_WIDTH : positive := 2
    );
    port(
        wresetn, rresetn, rready, wready, dec_reg_resetn, mux_reg_resetn, dec_reg_clk, mux_reg_clk : out std_logic;
        clk, resetn : in std_logic;
        w, r, uset_rready, uset_wready : in std_logic;
        waddr_reg_out, raddr_reg_out : in std_logic_vector(ADDR_WIDTH - 1 downto 0)
    );
end entity;



architecture behavior of sync_GBRAM_FSM is

    type state_type is (wait_raddr, wait_waddr, start_point, idle, wait_both_addr, unset_rready, unset_wready, set_wready, set_rready, conflict, no_conflict);
    signal pr_state, next_state : state_type;

begin

    seq : process (clk, resetn)
    begin
        if (rising_edge(clk) or falling_edge(resetn)) then 
            if resetn = '0' then 
                pr_state <= start_point;
            else 
                pr_state <= next_state;
            end if;
        end if;
    end process;

    com : process (pr_state, w, r, uset_rready, uset_wready, raddr_reg_out, waddr_reg_out) 
    begin

        case  (pr_state) is 

            when start_point => 
                wresetn <= '0';
                rresetn <= '0';
                dec_reg_resetn <= '0';
                mux_reg_resetn <= '0';
                dec_reg_clk <= '0';
                mux_reg_clk <= '0';
                rready <= '0';
                wready <= '0';

                next_state <= idle;

            when idle => 
                mux_reg_resetn <= '1';
                dec_reg_resetn <= '1';
                wresetn <= '1';
                rresetn <= '1';

                if w = '1' and r = '0' and uset_rready = '0' and uset_wready = '0' then 
                    next_state <= wait_waddr;
                end if;
                if uset_rready = '1' and  uset_wready = '0' then 
                    next_state <= unset_rready;
                end if;
                if uset_wready = '1' then 
                    next_state <= unset_wready;
                end if;
                if w = '0' and r = '1' and uset_rready = '0' and uset_wready = '0' then 
                    next_state <= wait_raddr;
                end if;
                if w = '1' and r = '1' and uset_rready = '0' and uset_wready = '0' then 
                    next_state <= wait_both_addr;
                end if;

            when wait_waddr => 
                dec_reg_clk <= '1';

                next_state <= set_wready;
            

            when set_wready => 
                dec_reg_clk <= '0';
                dec_reg_resetn <= '0';
                wready <= '1';
                wresetn <= '0';

                next_state <= idle;

            when unset_rready => 
                rready <= '0';
                
                next_state <= idle;

            when unset_wready => 
                wready <= '0';

                next_state <= idle;

            when wait_raddr => 
                mux_reg_clk <= '1';

                next_state <= set_rready;

            when set_rready => 
                rready <= '1';
                rresetn <= '0';
                mux_reg_clk <= '0';

                next_state <=  idle;

            when wait_both_addr => 

                dec_reg_clk <= '1';

                if raddr_reg_out = waddr_reg_out then 

                    next_state <= conflict;
                    
                else 
                    mux_reg_clk <= '1';
                    
                    next_state <= no_conflict;
                end if;


            when no_conflict => 
                -- for reading:
                mux_reg_clk <= '0';
                rready <= '1';
                rresetn <= '0';
                -- for writing: 
                dec_reg_clk <= '0';
                dec_reg_resetn <= '0';
                wready <= '1';
                wresetn <= '0';

                next_state <= idle;

            when conflict => 
                dec_reg_clk <= '0';
                dec_reg_resetn <= '0';
                wready <= '1';
                wresetn <= '0';

                next_state <= wait_raddr;

            when others => 
                next_state <= idle;      

        end case;


    end process;

    

end architecture;