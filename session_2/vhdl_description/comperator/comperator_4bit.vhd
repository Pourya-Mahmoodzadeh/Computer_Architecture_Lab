library ieee;
use ieee.std_logic_1164.all;

entity comperator_4bit is 

    port (
        a4, b4 : in STD_LOGIC_VECTOR(3 downto 0);
        a_gt_b_final, a_lt_b_final, a_eq_b_final : out STD_LOGIC
    );

end entity comperator_4bit;

architecture rtl of comperator_4bit is 

    component comperator_1bit 
        port (
            a, b, gt, eq, lt : in STD_LOGIC;
            a_gt_b, a_eq_b, a_lt_b : out STD_LOGIC
        );
    end component comperator_1bit;

    signal intermediate_a_lt_b : std_logic_vector(2 downto 0);
    signal intermediate_a_eq_b : std_logic_vector(2 downto 0);
    signal intermediate_a_gt_b : std_logic_vector(2 downto 0);
    signal final_gt : STD_LOGIC;
    signal final_eq : STD_LOGIC;
    signal final_lt : STD_LOGIC;


begin 

    comp_1_prio_0 : component comperator_1bit
        port map(
            a => a4(0),
            b => b4(0),
            gt => '0',
            eq => '1',
            lt => '0',
            a_gt_b => intermediate_a_gt_b(0),
            a_eq_b => intermediate_a_eq_b(0),
            a_lt_b => intermediate_a_lt_b(0)
        );

    comp_1_prio_1 : component comperator_1bit
        port map(
            a => a4(1),
            b => b4(1),
            gt => intermediate_a_gt_b(0),
            eq => intermediate_a_eq_b(0),
            lt => intermediate_a_lt_b(0),
            a_gt_b => intermediate_a_gt_b(1),
            a_eq_b => intermediate_a_eq_b(1),
            a_lt_b => intermediate_a_lt_b(1)
        );

    comp_1_prio_2 : component comperator_1bit
        port map(
            a => a4(2),
            b => b4(2),
            gt => intermediate_a_gt_b(1),
            eq => intermediate_a_eq_b(1),
            lt => intermediate_a_lt_b(1),
            a_gt_b => intermediate_a_gt_b(2),
            a_eq_b => intermediate_a_eq_b(2),
            a_lt_b => intermediate_a_lt_b(2)
        );

    comp_1_prio_3 : component comperator_1bit
        port map(
            a => a4(3),
            b => b4(3),
            gt => intermediate_a_gt_b(2),
            eq => intermediate_a_eq_b(2),
            lt => intermediate_a_lt_b(2),
            a_gt_b => final_gt,
            a_eq_b => final_eq,
            a_lt_b => final_lt 
        );

        a_gt_b_final <= final_gt;
        a_lt_b_final <= final_lt;
        a_eq_b_final <= final_eq;



end architecture rtl;