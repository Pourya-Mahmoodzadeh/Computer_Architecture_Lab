library ieee;
use ieee.std_logic_1164.all;



entity D_FF_behavioral is
	port (
		reset_n, clk, D : in std_logic;
		Q, Q_n : out std_logic
	);
end entity;



architecture behavior of D_FF_behavioral is

begin
	seq : process (clk, reset_n)
	begin
		if reset_n = '0' then
			Q <= '0';
			Q_n <= '1';
		else 
			if rising_edge(clk) then
				Q <= D;
				Q_n <= not D;
			end if;
		end if;
	end process seq;
	

end architecture;