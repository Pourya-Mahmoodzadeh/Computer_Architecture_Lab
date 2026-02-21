-- GBRAM = synchronous gate basesd random access memory
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sync_GBRAM is
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
end entity;

architecture rtl of sync_GBRAM is

    subtype data_type is std_logic_vector(DATA_WIDTH - 1 downto 0);
    subtype addr_type is std_logic_vector(ADDR_WIDTH - 1 downto 0);
    subtype mux_in_type is std_logic_vector(DATA_WIDTH * (2** ADDR_WIDTH) - 1 downto 0); 
    subtype dec_out_type is std_logic_vector(2** ADDR_WIDTH - 1 downto 0);
    
    signal dec_regD, dec_regQ, dec_regQn : dec_out_type;
    signal dec_reg_resetn, dec_reg_clk : std_logic; 

    signal mux_regQ, mux_regD, mux_regQn : data_type;
    signal mux_reg_resetn, mux_reg_clk : std_logic;

    signal wdata_regQ, wdata_regQn : data_type;
    signal wdata_reg_resetn, wdata_reg_clk : std_logic;

    signal waddr_regQ, waddr_regQn : addr_type;
    signal waddr_reg_resetn, waddr_reg_clk : std_logic; 

    signal raddr_regQ, raddr_regQn : addr_type;
    signal raddr_reg_resetn, raddr_reg_clk : std_logic; 

    signal wresetn, rresetn : std_logic;
    signal w, wn, r, rn : std_logic;

    signal mux_out : data_type;
    signal mux_in, mux_inn : mux_in_type;

    -- signal ram_flat : std_logic_vector(DATA_WIDTH * (2**ADDR_WIDTH) - 1 downto 0);
    -- signal mux_out : std_logic_vector(DATA_WIDTH - 1 downto 0);

    -- signal wplace : std_logic_vector(2**ADDR_WIDTH -1 downto 0);

    signal dec_out : dec_out_type;

    component minimal_D_FF is
	port (
		reset_n, clk, D : in std_logic;
		Q, Q_n : out std_logic
	);
    end component;

    component minimal_reg_nbit 
        generic (
            WIDTH : integer := 8
        );
        port(
            clear_n, clk : in std_logic;
            data : in std_logic_vector((WIDTH - 1) downto 0);
            Q, Q_n : out std_logic_vector((WIDTH - 1) downto 0)
        );
    end component;

    component decoder_rec
    generic (
        width : integer := 3
    );
    port(
        input : in std_logic_vector((width - 1) downto 0);
        enable : in std_logic;
        output : out std_logic_vector((2**width - 1) downto 0)
    );
    end component;

    component mux
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
    end component;

    component word 
    generic(
        word_size : integer := 8;
        reset_to_int_form : integer := 0
    );
    port (
        data2read, data2read_n : out std_logic_vector(word_size - 1 downto 0);
        reset_n, enable : in std_logic;
        data2write : in std_logic_vector(word_size - 1 downto 0)
    );
end component;

    component sync_GBRAM_FSM is 
        generic ( 
            ADDR_WIDTH : positive := 2
        );
        port(
            wresetn, rresetn, rready, wready, dec_reg_resetn, mux_reg_resetn, dec_reg_clk, mux_reg_clk : out std_logic;
            clk, resetn : in std_logic;
            w, r, uset_rready, uset_wready : in std_logic;
            waddr_reg_out, raddr_reg_out : in std_logic_vector(ADDR_WIDTH - 1 downto 0)
        );
    end component;

begin

    WADDR_REG : component minimal_reg_nbit
        generic map( 
            WIDTH => ADDR_WIDTH
        )
        port map ( 
            clk => write,
            clear_n => waddr_reg_resetn, 
            data => waddr,
            Q => waddr_regQ,
            Q_n => waddr_regQn
        );

        waddr_reg_resetn <= resetn;

    READ_FF : component minimal_D_FF
     port map(
        reset_n => rresetn,
        clk => read,
        D => '1',
        Q => r,
        Q_n => rn
    ); 


    WRITE_FF : component minimal_D_FF
     port map(
        reset_n => wresetn,
        clk => write,
        D => '1',
        Q => w,
        Q_n => wn
    );

    DEC: component decoder_rec
     generic map(
        width => ADDR_WIDTH
    )
     port map(
        input => waddr_regQ,
        enable => '1',
        output => dec_out
    );

    DEC_REG : component minimal_reg_nbit
     generic map(
        WIDTH => 2**ADDR_WIDTH
    )
     port map(
        clear_n => dec_reg_resetn,
        clk => dec_reg_clk,
        data => dec_out,
        Q => dec_regQ,
        Q_n => dec_regQn
    );


    WDATA_REG : component minimal_reg_nbit
     generic map(
        WIDTH => DATA_WIDTH
    )
     port map(
        clear_n => wdata_reg_resetn,
        clk => write,
        data => wdata,
        Q => wdata_regQ,
        Q_n => wdata_regQn -- wasted
    );
    
    wdata_reg_resetn <= resetn;

    READ_ADDR_REG : component minimal_reg_nbit
     generic map(
        WIDTH => ADDR_WIDTH
    )
     port map(
        clear_n => raddr_reg_resetn,
        clk => read,
        data => raddr,
        Q => raddr_regQ,
        Q_n => raddr_regQn
    );

    MEMORY_GRID_GEN : for i in 2**ADDR_WIDTH - 1 downto 0 generate 
        WORDi : component word
         generic map(
            word_size => DATA_WIDTH,
            reset_to_int_form => i
        )
         port map(
            data2read => mux_in((i) * (DATA_WIDTH) + DATA_WIDTH - 1 downto i * DATA_WIDTH),
            data2read_n => mux_inn(i * DATA_WIDTH + DATA_WIDTH - 1 downto i * DATA_WIDTH), -- wasted!
            reset_n => resetn,
            enable => dec_regQ(i),
            data2write => wdata_regQ
        );
    end generate;

    MULTIPLEXER : component mux
     generic map(
        SEL_WIDTH => ADDR_WIDTH,
        DATA_WIDTH => DATA_WIDTH
    )
     port map(
        sel => raddr_regQ,
        data => mux_in,
        output => mux_out,
        enable => '1'
    );


    MUX_REG : component minimal_reg_nbit
     generic map(
        WIDTH => DATA_WIDTH
    )
     port map(
        clear_n => mux_reg_resetn,
        clk => mux_reg_clk,
        data => mux_out,
        Q => rdata,
        Q_n => rdatan
    );

    FSM_INS : component sync_GBRAM_FSM
     generic map(
        ADDR_WIDTH => ADDR_WIDTH
    )
     port map(
        wresetn => wresetn,
        rresetn => rresetn,
        rready => rready,
        wready => wready,
        dec_reg_resetn => dec_reg_resetn,
        mux_reg_resetn => mux_reg_resetn,
        dec_reg_clk => dec_reg_clk,
        mux_reg_clk => mux_reg_clk,
        clk => clk,
        resetn => resetn,
        w => w,
        r => r,
        uset_rready => uset_rready,
        uset_wready => uset_wready,
        waddr_reg_out => waddr_regQ,
        raddr_reg_out => raddr_regQ
    );







end architecture;