library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity decoder_rec is
    generic (
        width : integer := 3
    );
    port(
        input : in std_logic_vector((width - 1) downto 0);
        enable : in std_logic;
        output : out std_logic_vector((2**width - 1) downto 0)
    );
end entity;



architecture rtl of decoder_rec is

    signal least_sig_en : std_logic;
    signal en0, en1 : std_logic;


begin

    least_sig_en <= not input(width - 1);

    BASE_GEN: if width = 1 generate
        output(0) <= enable and least_sig_en;
        output(1) <= enable and input(0);
    end generate;


    REC_GEN: if width > 1 generate

        en0 <= least_sig_en and enable;
        en1 <= input(width - 1) and enable;


        DEC0: entity work.decoder_rec
            generic map(
                width => (width - 1)
            )
            port map(
                input => input((width - 2) downto 0),
                enable => en0,
                output => output((2**(width - 1) - 1) downto 0)
            );

        DEC1: entity work.decoder_rec
        generic map( 
            width => (width - 1)
        )
        port map( 
            input => input((width - 2) downto 0),
            enable => en1,
            output => output(2**width - 1 downto 2**(width - 1))
        );
        end generate;

    

end architecture;