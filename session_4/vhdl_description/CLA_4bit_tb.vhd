library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity CLA_4bit_tb is
end entity;



architecture behavior of CLA_4bit_tb is

    component CLA_4bit is
        port (
        i1, i2 : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        sum : out std_logic_vector(3 downto 0);
        cout : out std_logic
        );
    end component CLA_4bit;
    signal i1 : std_logic_vector(3 downto 0) := "0000";
    signal i2 : std_logic_vector(3 downto 0) := "0000";
    signal sum : std_logic_vector(3 downto 0);
    signal cout : std_logic;
    signal cin : std_logic := '0';

    signal waiting_time : time := 20 ns;

begin

    uut : component CLA_4bit
     port map(
        i1 => i1,
        i2 => i2,
        cin => cin,
        sum => sum,
        cout => cout
    );

    test : process 
    begin
        wait for waiting_time;
        i1 <= "0001";
        wait for waiting_time;
        i1 <= "0010";
        wait for waiting_time;
        i2 <= "0001";
        wait for waiting_time;
        i2 <= "0010";
        wait for waiting_time;
        i1 <= "1001";
        i2 <= "0110";
        wait for waiting_time;
        i1 <= "1010";
        i2 <= "1010";
        wait for waiting_time;
        i1 <= "1111";
        i2 <= "1111";
        wait for waiting_time;
        i1 <= "0001";
        wait for waiting_time;
        cin <= '1';
        wait for waiting_time;
        i1 <= "0001";
        wait for waiting_time;
        i1 <= "0010";
        wait for waiting_time;
        i2 <= "0001";
        wait for waiting_time;
        i2 <= "0010";
        wait for waiting_time;
        i1 <= "1001";
        i2 <= "0110";
        wait for waiting_time;
        i1 <= "1010";
        i2 <= "1010";
        wait for waiting_time;
        i1 <= "1111";
        i2 <= "1111";
        wait for waiting_time;
        i1 <= "0001";
        wait for waiting_time;
        wait;
    end process;
end architecture behavior;