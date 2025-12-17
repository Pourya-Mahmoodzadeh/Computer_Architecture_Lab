library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_div is
    Port (
        clk_in  : in  STD_LOGIC;   
        clk_out : out STD_LOGIC   
    );
end clk_div;

architecture Behavioral of clk_div is
    signal counter : unsigned(25 downto 0) := (others => '0');
    signal tmp_clk : std_logic := '0';
begin

    process(clk_in)
    begin
        if rising_edge(clk_in) then
            counter <= counter + 1;
            
            if counter = 50_000_000 - 1 then
                tmp_clk <= not tmp_clk;
                counter <= (others => '0');
            end if;
        end if;
    end process;

    clk_out <= tmp_clk;

end Behavioral;