library ieee;
use ieee.std_logic_1164.all;



entity system is
    port(
        seg_data : out std_logic_vector(6 downto 0);
        load, reset_n, clk: in std_logic;
        l, r: in std_logic;
        parallel_in : in std_logic_vector(3 downto 0);
        seg_select: out std_logic_vector(3 downto 0)
    );
    end entity system;






architecture rtl of system is

    component shift_reg_4bit
        port(
        data, data_n : out std_logic_vector(3 downto 0);
        load, reset_n, clk: in std_logic;
        l, r: in std_logic;
        parallel_in : in std_logic_vector(3 downto 0)
    );
    end component shift_reg_4bit;

    component seven_seg_interface 
        port(
            clk : in std_logic;
            seg_select : out std_logic_vector(3 downto 0);
            seg_data : out std_logic_vector(6 downto 0);
            data_to_show : in std_logic_vector(3 downto 0)
        );
    end component seven_seg_interface;

    component clk_div 
        Port (
        clk_in  : in  std_logic;   
        clk_out : out std_logic   
    );
    end component;

    signal data_n_in : std_logic_vector(3 downto 0);
    signal slow_clk : std_logic;
    signal data_to_show : std_logic_vector(3 downto 0);



begin
    SHIFT_REGISTER : component shift_reg_4bit
     port map(
        data => data_to_show,
        data_n => data_n_in,
        load => load,
        reset_n => reset_n,
        clk => slow_clk,
        l => l,
        r => r,
        parallel_in => parallel_in
    );

    CLOCK_DIVIDER : component clk_div
     port map(
        clk_in => clk,
        clk_out => slow_clk
    );

    COMMUNICATOR_WITH_7_SEG : component seven_seg_interface
     port map(
        clk => clk,
        seg_select => seg_select,
        seg_data => seg_data,
        data_to_show => data_to_show
    );


end architecture rtl;