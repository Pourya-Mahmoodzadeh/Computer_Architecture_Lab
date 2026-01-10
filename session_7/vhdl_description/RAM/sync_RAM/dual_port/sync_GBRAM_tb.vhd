library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;



entity sync_GBRAM_tb is 
    generic (
        ADDR_WIDTH : positive := 2;
        DATA_WIDTH : positive := 4;
        CLK_QUARTER : time := 5 ns;
        WAITING_TIME : time := 40 ns;
        RANDOM_RNUM : integer := 5;
        RANDOM_WNUM : integer := 5;
        RANDOM_CONFLICTING_RW_NUM : integer := 3;
        MAX_RANDOM_DELAY : integer := 100
    );
end entity;



architecture behavior of sync_GBRAM_tb is

    signal clk, write, read, resetn, uset_rready, uset_wready: std_logic := '0';
    signal  rready, wready : std_logic;

    subtype data_type is std_logic_vector(DATA_WIDTH - 1 downto 0);
    subtype addr_type is std_logic_vector(ADDR_WIDTH - 1 downto 0);

    signal rdata, rdatan : data_type;
    signal wdata : data_type := std_logic_vector(to_unsigned(0, DATA_WIDTH));
    signal raddr, waddr : addr_type := std_logic_vector(to_unsigned(0, ADDR_WIDTH));

    signal write_test_done, read_test_done : std_logic := '0';

    constant clk_half : time := CLK_QUARTER * 2;
    constant clk_period : time := clk_half * 2;

    component sync_GBRAM
    generic (
        ADDR_WIDTH : integer := 10; 
        DATA_WIDTH : integer := 32
    );
    port (
        clk : in  std_logic;
        write : in  std_logic;
        read : in std_logic; -- we are asked to take a read signal as input
        waddr : in  std_logic_vector(ADDR_WIDTH - 1 downto 0); -- address to be wrtten to
        raddr : in std_logic_vector(ADDR_WIDTH - 1 downto 0); -- address to be read
        wdata : in  std_logic_vector(DATA_WIDTH - 1 downto 0); -- data to write
        rdata, rdatan : out std_logic_vector(DATA_WIDTH - 1 downto 0); -- the data that has been read
        resetn : in std_logic; -- asynchronous active-low reset
        -- conflict : out std_logic; -- when simultaneous read and write are happening using same address, this reliably writes, but reading output is not reliable, warned by this signal.
        wready : out std_logic;
        rready : out std_logic;
        uset_wready : in std_logic;
        uset_rready : in std_logic
    );
    end component;



begin

    UUT: component sync_GBRAM
     generic map(
        ADDR_WIDTH => ADDR_WIDTH,
        DATA_WIDTH => DATA_WIDTH
    )
     port map(
        clk => clk,
        write => write,
        read => read,
        waddr => waddr,
        raddr => raddr,
        wdata => wdata,
        rdata => rdata,
        rdatan => rdatan,
        resetn => resetn,
        wready => wready,
        rready => rready,
        uset_wready => uset_wready,
        uset_rready => uset_rready
    );

    clk_gen : process 
    begin
        -- report "clock is working." severity note;
        clk <= '0';
        -- report "clock is still working." severity note;
        wait for clk_half;
        -- report "clock is working." severity note;
        clk <= '1';
        wait for clk_half;
        -- report "clock is working." severity note;
    end process;


    test_read : process
        variable seed1 : positive := 1;
        variable seed2 : positive := 2;
        variable rand_real : real;
        variable rand_int : integer;

        variable rand_data : data_type;
        variable rand_read_addr : addr_type;
    begin
        report "read: start of process." severity note;
        wait for WAITING_TIME;

        report "read: resetting." severity note;
        resetn <= '1';
        report "read: reset." severity note;
        -- for i in RANDOM_RNUM - 1 downto 0 loop 

        --     uniform(seed1, seed2, rand_real);
        --     rand_read_addr := std_logic_vector(to_unsigned(integer(rand_real * real(2**ADDR_WIDTH - 1)), ADDR_WIDTH));
        --     raddr <= rand_read_addr;

        --     uniform(seed1, seed2, rand_real);
        --     rand_write_addr := std_logic_vector(to_unsigned(integer(rand_real * real(2**ADDR_WIDTH - 1)), ADDR_WIDTH));
        --     waddr <= rand_write_addr;

        --     read <= '1';
        --     write <= '1';

        --     wait until wready = '1';
        --     uset_wready <= '1';
        --     wait until rready = '1';
        --     uset_rready <= '1';

        --     wait until wready = '0';
        --     uset_wready <= '0';
        --     wait until rready = '0';
        --     uset_rready <= '0';

        --     wait for WAITING_TIME;            

        -- end loop; 

        for i in RANDOM_RNUM - 1 downto 0 loop 

            report "read: start of the reading loop." severity note;

            uniform(seed1, seed2, rand_real);

            report "read: random number set." severity note;
            rand_read_addr := std_logic_vector(to_unsigned(integer(rand_real * real(2**ADDR_WIDTH - 1)), ADDR_WIDTH));
            raddr <= rand_read_addr;

            -- raddr <= std_logic_vector(to_unsigned(i, ADDR_WIDTH));

            wait for WAITING_TIME;


            report "read: initiating read." severity note;

            read <= '1';

            report "read: reading initiated. Waiting for rready." severity note;
            wait until rready = '1';
            read <= '0';
            uset_rready <= '1';

            report "read: reading done. Waiting for uset_rready." severity note; 

            wait until rready = '0';
            uset_rready <= '0';

            report "read: reading and unsetting (the whole process) is done for one iteration." severity note;

            wait for WAITING_TIME;            

        end loop; 

            read_test_done <= '1';
        wait;
    end process;



























    

    test_write : process 
        variable seed1 : positive := 3;
        variable seed2 : positive := 4;
        variable rand_real : real;
        variable rand_real_data : real;
        variable rand_real_delay : real;
        variable rand_int_delay : integer;

        variable rand_data : data_type;
        variable rand_write_addr : addr_type;
        variable rand_write_data : data_type;
    begin
        wait for WAITING_TIME;
        resetn <= '1';

        for i in RANDOM_RNUM - 1 downto 0 loop 

            report "write: Start of the writing loop." severity note;

            uniform(seed1, seed2, rand_real);

            report "write: Random real number set. The amount is: " & real'image(rand_real) severity note;

            rand_write_addr := std_logic_vector(to_unsigned(integer(rand_real * real(2**ADDR_WIDTH - 1)), ADDR_WIDTH));
            waddr <= rand_write_addr;

            uniform(seed1, seed2, rand_real_data);
            rand_write_data := std_logic_vector(to_unsigned(integer(rand_real_data * real(2**DATA_WIDTH - 1)), DATA_WIDTH));
            wdata <= rand_write_data;

            wait for WAITING_TIME;

            report "write: initiating write." severity note;

            write <= '1';

            report "write: writing initiated. Waiting for wready." severity note;

            wait until wready = '1';
            write <= '0';

            -- insert random delay
            uniform(seed1, seed2, rand_real_delay);
            rand_int_delay := integer(rand_real_delay * real(MAX_RANDOM_DELAY));
            wait for rand_int_delay * 1 ns;

            report "trying to unset wready." severity note;
            uset_wready <= '1';

            wait until wready = '0';
            uset_wready <= '0';

            wait for WAITING_TIME;            

        end loop; 

        write_test_done <= '1';


        wait;
    end process;


    FINISH_DETERMINER : process 
    begin 
        if write_test_done = '1' and read_test_done = '1' then 
            -- report "boooom." severity note;
            std.env.finish;
        end if;
        wait for clk_period;
    end process;
        

    

end architecture;