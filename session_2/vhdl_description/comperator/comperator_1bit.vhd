library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comperator_1bit is 
    port(
        a, b, gt, eq, lt : in STD_LOGIC;
        a_gt_b, a_eq_b, a_lt_b : out STD_LOGIC
    );
end entity comperator_1bit;

architecture rtl of comperator_1bit is
    
    signal simple_lt : STD_LOGIC;
    signal simple_eq : STD_LOGIC;
    signal simple_gt : STD_LOGIC;

begin

    simple_gt <= a and not b;
    simple_lt <= not a and b;
    simple_eq <= not (simple_gt or simple_lt);

    a_gt_b <= simple_gt or (simple_eq and gt);
    a_eq_b <= simple_eq and eq;
    a_lt_b <= simple_lt or (simple_eq and lt);


end architecture rtl;