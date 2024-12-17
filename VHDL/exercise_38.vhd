library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
    port (
        clk   : in std_logic;
        as_reset_n : in std_logic;
        signal_in: in std_logic;
        counter_max: in std_logic_vector (7 downto 0);
        edge_type: in std_logic_vector (1 downto 0);
        counter_out: out std_logic_vector (7 downto 0)
    );
end entity circuit;

architecture rtl of circuit is
    signal ff_1: std_logic;
    signal ff_2: std_logic;
    signal ff_3: std_logic;

    signal counter: integer range 0 to 255;
    signal counter_out_ff: integer range 0 to 255;

    signal signal_in_falling_edge: std_logic;
    signal signal_in_rising_edge: std_logic;
    signal signal_in_edge: std_logic;
    signal selected_edge: std_logic;
begin
    signal_in_rising_edge <= ff_2 and not ff_3;
    signal_in_falling_edge <= not ff_2 and ff_3;
    signal_in_edge <= ff_2 xor ff_3;

    process (all)
    begin
        case edge_type is
            when "00" => selected_edge <= signal_in_rising_edge;
            when "01" => selected_edge <= signal_in_falling_edge;
            when "10" => selected_edge <= signal_in_edge;
            when others => NULL;
        end case;
    end process;

    process (clk, as_reset_n)
    begin
        if (as_reset_n = '0') then
            ff_1 <= '0';
            ff_2 <= '0';
            ff_3 <= '0';
            counter <= 0;
            counter_out_ff <= 0;
        elsif(rising_edge(clk)) then
            ff_1 <= signal_in;
            ff_2 <= ff_1;
            ff_3 <= ff_2;
            if(selected_edge = '1') then
                counter <= 0;
                counter_out_ff <= counter;
            elsif(counter < to_integer(unsigned(counter_max))) then
                counter <= counter + 1;
            end if;
        end if;
    end process;
    counter_out <= std_logic_vector(to_unsigned(counter_out_ff, 8));
end architecture;