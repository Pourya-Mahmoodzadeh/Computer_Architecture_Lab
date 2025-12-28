library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity minimal_reg_nbit is
    generic (
        n : integer := 8
    );
    port(
        clear_n, clk : in std_logic;
        data : in std_logic_vector((n - 1) downto 0);
        Q, Q_n : out std_logic_vector((n - 1) downto 0)
    );
end entity;



architecture rtl of minimal_reg_nbit is

begin

    CONNECT_WIRES: for i in (n - 1) downto 0 generate
        D_FF_INS : entity work.D_FF -- address: session_6/vhdl_description/flip_flop/minimal/behavioral/D_FF.vhd
            port map(
                reset_n => clear_n,
                clk => clk,
                D => data(i),
                Q => Q(i),
                Q_n => Q_n(i)
            );
    end generate;   

end architecture;