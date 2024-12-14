library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk         : in std_logic;
    reset       : in std_logic;
    nul         : in std_logic;
    signal_in   : in std_logic;
    counter_out : out std_logic_vector (7 downto 0)
  );
end entity circuit;

architecture rtl of circuit is
  signal ff_signal_in_1 : std_logic;
  signal ff_signal_in_2 : std_logic;
  signal ff_signal_in_3 : std_logic;

  signal signal_in_rising : std_logic;

  signal counter : integer range 0 to 255;
begin
  signal_in_rising <= not ff_signal_in_3 and ff_signal_in_2;

  process (clk, reset)
  begin
    if (reset = '0') then
      counter             <= 0;
      ff_signal_in_1      <= '0';
      ff_signal_in_2      <= '0';
      ff_signal_in_3      <= '0';
    elsif (rising_edge(clk)) then
        ff_signal_in_1 <= signal_in;
        ff_signal_in_2 <= ff_signal_in_1;
        ff_signal_in_3 <= ff_signal_in_2;
      if (nul = '1') then
        counter <= 0;
      elsif (signal_in_rising = '1') then
        counter <= counter + 1;
      end if;
    end if;
  end process;
  counter_out <= std_logic_vector(to_unsigned(counter, 8));
end architecture;