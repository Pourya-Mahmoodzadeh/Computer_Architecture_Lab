library ieee;
use ieee.std_logic_1164.all;



entity ripple_counter is
    port (
        clk, resetn, stopn : in std_logic;
        count : out std_logic_vector(3 downto 0)
    );
    end entity ripple_counter;



architecture rtl of ripple_counter is 
    component T_FF 
        port (
            T, resetn, clk : in std_logic;
            Q, Qn : out std_logic
         );
        end component T_FF;

        signal Qn_0 : std_logic;
        signal Qn_1 : std_logic;
        signal Qn_2 : std_logic;
        signal Qn_3 : std_logic;
        

    begin

        S0 : component T_FF
         port map(
            T => stopn,
            resetn => resetn,
            clk => clk,
            Q => count(0),
            Qn => Qn_0
        );

        S1 : component T_FF
         port map(
            T => stopn,
            resetn => resetn,
            clk => Qn_0,
            Q => count(1),
            Qn => Qn_1
        );

        S2 : component T_FF
         port map(
            T => stopn,
            resetn => resetn,
            clk => Qn_1,
            Q => count(2),
            Qn => Qn_2
        );

        S3 : component T_FF
         port map(
            T => stopn,
            resetn => resetn,
            clk => Qn_2,
            Q => count(3),
            Qn => Qn_3
        );

    end architecture rtl;
