library ieee;
use ieee.STD_LOGIC_1164.all;



entity seven_seg_interface is 
    port(
        clk : in std_logic;
        seg_select : out std_logic_vector(3 downto 0);
        seg_data : out std_logic_vector(6 downto 0);
        data_to_show : in std_logic_vector(3 downto 0)
    );
end entity seven_seg_interface;



architecture behavior of seven_seg_interface is

    component translator
        port (
            input : in std_logic;
            seg_data : out std_logic_vector(6 downto 0)
        );
    end component translator;

    signal iterator : std_logic_vector(3 downto 0) := "0000";
    signal next_iterator : std_logic_vector(3 downto 0);

    signal seg_value : std_logic_vector(6 downto 0);
    signal next_seg_value : std_logic_vector(6 downto 0);

    signal seg_data0 : std_logic_vector(6 downto 0);
    signal seg_data1 : std_logic_vector(6 downto 0);
    signal seg_data2 : std_logic_vector(6 downto 0);
    signal seg_data3 : std_logic_vector(6 downto 0);

begin

    translator0 : component translator
     port map(
        input => data_to_show(0),
        seg_data => seg_data0
    );

    translator1 : component translator
     port map(
        input => data_to_show(1),
        seg_data => seg_data1
    );

    translator2 : component translator
     port map(
        input => data_to_show(2),
        seg_data => seg_data2
    );

    translator3 : component translator
     port map(
        input => data_to_show(3),
        seg_data => seg_data3
    );

    COM : process (iterator)
        begin

            case iterator is

                when "0000" =>
                    next_iterator <= "0001";
                    next_seg_value <= seg_data0;
                when "0001" =>
                    next_iterator <= "0010";
                    next_seg_value <= seg_data1;
                when "0010" =>
                    next_iterator <= "0100";
                    next_seg_value <= seg_data2;
                when "0100" =>
                    next_iterator <= "1000";
                    next_seg_value <= seg_data3;
                when "1000" =>
                    next_iterator <= "0000";
                    next_seg_value <= seg_data0;
                when others =>
                    next_iterator <= "0000";
                    next_seg_value <= seg_data0;

            end case;

        end process;

    SEQ : process (clk)
        begin
        if (rising_edge(clk)) then 
            iterator <= next_iterator;
            seg_value <= next_seg_value;
        end if;
    end process SEQ;

    seg_select <= iterator;
    seg_data <= seg_value;


end architecture;