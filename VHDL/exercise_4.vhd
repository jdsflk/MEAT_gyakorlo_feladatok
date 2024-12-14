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
  signal ff_signal_in      : std_logic;
  signal counter           : integer range 0 to 255;
  signal signal_in_falling : std_logic;
begin
  signal_in_falling <= not signal_in and ff_signal_in;

  process (clk, reset)
  begin
    if (reset = '0') then
      ff_signal_in <= '0';
      counter      <= 0;
    elsif (rising_edge(clk)) then
      ff_signal_in <= signal_in;
      if (nul = '0') then
        counter <= 0;
      elsif (signal_in_falling = '1') then
        if (counter < 255) then
          counter <= counter + 1;
        end if;
      end if;
    end if;
  end process;
  counter_out <= std_logic_vector(to_unsigned(counter, 8));
end architecture;