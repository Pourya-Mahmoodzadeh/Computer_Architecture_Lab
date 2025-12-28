library ieee;
use ieee.std_logic_1164.all;



entity minimal_reg_8bit is
    port(
        data : in std_logic_vector(7 downto 0);
        clear_n, clk : in std_logic;
        Q, Q_n : out std_logic_vector(7 downto 0)
    );
end entity;



architecture behavior of minimal_reg_8bit is

    component D_FF 
        port (
		    reset_n, clk, D : in std_logic;
		    Q, Q_n : out std_logic
	    );
    end component;

begin

    CONNECT_WIRES : for i in 7 downto 0 generate 
        D_FF_INS : component D_FF
            port map (
                reset_n => clear_n,
                clk => clk,
                D => data(i),
                Q => Q(i),
                Q_n => Q_n(i)
            );
    end generate CONNECT_WIRES;

end architecture;