library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
    port (
        clk   : in std_logic;
        as_reset_n : in std_logic;
        counter_max: in std_logic_vector (7 downto 0);
        signal_in: in std_logic;
        signal_present: out std_logic
    );
end entity circuit;

architecture rtl of circuit is
    signal ff_1: std_logic;
    signal ff_2: std_logic;
    signal ff_3: std_logic;

    signal counter: integer range 0 to 255;

    signal presence_edge: std_logic;
begin
    presence_edge <= ff_3 xor ff_2;
    process (clk, as_reset_n)
    begin
        if (as_reset_n = '0') then
            ff_1 <= '0';
            ff_2 <= '0';
            ff_3 <= '0';
            counter <= 0;
        elsif(rising_edge(clk)) then
            ff_1 <= signal_in;
            ff_2 <= ff_1;
            ff_3 <= ff_2;
            if(presence_edge = '1') then
                counter <= to_integer(unsigned(counter_max));
            elsif(counter > 0) then
                counter <= counter - 1;
            end if;
        end if;
    end process;
    signal_present <= '1' when not (counter = 0) else '0';
end architecture;