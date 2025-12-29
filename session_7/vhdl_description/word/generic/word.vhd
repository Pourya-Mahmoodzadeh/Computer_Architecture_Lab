library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity word is 
    generic(
        word_size : integer := 8;
        reset_to_int_form : integer := 0
    );
    port (
        data2read, data2read_n : out std_logic_vector(word_size - 1 downto 0);
        reset_n, enable : in std_logic;
        data2write : in std_logic_vector(word_size - 1 downto 0)
    );
end entity;



architecture rtl of word is

    constant reset_to : std_logic_vector(word_size - 1 downto 0) := std_logic_vector(to_unsigned(reset_to_int_form, word_size));

begin

    GEN_WORD : for i in word_size - 1 downto 0 generate
        GEN_0 : if reset_to(i) = '1' generate
            RESET_TO_1_D_LATCH_INS : entity work.D_latch_async_fill
            port map(
                enable => enable,
                fill_n => reset_n,
                D => data2write(i),
                Q => data2read(i),
                Q_n => data2read_n(i)
            );
        end generate;
        GEN_1 : if reset_to(i) = '0' generate
            RESET_TO_1_D_LATCH_INS : entity work.D_latch
            port map(
                enable => enable,
                clear_n => reset_n,
                D => data2write(i),
                Q => data2read(i),
                Q_n => data2read_n(i)
            );
        end generate;        
    end generate;
    

end architecture;