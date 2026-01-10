-- an 100% useless ROM written in a trash way! Described only and only for the sake of grades (uni forced it!)
library ieee;
use ieee.std_logic_1164.all;



entity ROM is 
    port (
        data : out std_logic_vector(3 downto 0);
        addr : in std_logic_vector(1 downto 0)        
    );
end entity;




architecture rom_arch of ROM is

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


    subtype mux_in_type is std_logic_vector(15 downto 0);
    subtype data_type is std_logic_vector(3 downto 0);
    subtype addr_type is std_logic_vector(1 downto 0);

    signal mux_in : mux_in_type;
    signal mux_inn : mux_in_type; -- wasted
    signal data2write : data_type; -- wasted

begin

    GEN_WORD : for i in 3 downto 0 generate 
        word_inst: component word
         generic map(
            word_size => 4,
            reset_to_int_form => i
        )
         port map(
            data2read => mux_in(i * 4 + 3 downto i * 4),
            data2read_n => mux_inn(i * 4 + 3 downto i * 4),
            reset_n => '0',
            enable => '0',
            data2write => data2write
        );
    end generate;

    MUX_INST : component mux 
        generic map( 
            SEL_WIDTH => 2,
            DATA_WIDTH => 4
        )
        port map( 
            sel => addr,
            data => mux_in, 
            output => data,
            enable => '1'
        );  
end architecture;