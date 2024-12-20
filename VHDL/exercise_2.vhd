library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk         : in std_logic;
    reset       : in std_logic;
    signal_in   : in std_logic;
    nul         : in std_logic;
    counter_out : out std_logic_vector(7 downto 0)
  );
end entity circuit;

architecture rtl of circuit is
    signal ff_1_signal_in: std_logic;
    signal ff_2_signal_in: std_logic;
    signal ff_3_signal_in: std_logic;
    signal signal_in_rising: std_logic;
    signal counter: integer range 0 to 255;
begin

    signal_in_rising <= not ff_2_signal_in and ff_3_signal_in;

    process (clk, reset)
    begin
        if (reset = '0') then
            ff_1_signal_in <= '0';
            ff_2_signal_in <= '0';
            ff_3_signal_in <= '0';
            counter <= 0;
        elsif(rising_edge(clk)) then
            ff_1_signal_in <= signal_in;
            ff_2_signal_in <= ff_1_signal_in;
            ff_3_signal_in <= ff_2_signal_in;
            if(nul = '0') then
                counter <= 0;
            elsif(signal_in_rising = '1') then
                if(counter < 255) then
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    counter_out <= std_logic_vector(to_unsigned(counter, 8));
end architecture;