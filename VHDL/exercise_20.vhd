library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk         : in std_logic;
    reset       : in std_logic;
    dir         : in std_logic;
    pause       : in std_logic;
    parallel_in : in std_logic_vector (7 downto 0);
    load        : in std_logic;
    counter_out : out std_logic_vector (7 downto 0)
  );
end entity circuit;

architecture rtl of circuit is
  signal counter : integer range 0 to 255;
  signal term    : integer range 0 to 255;
begin
  term <= 1 when dir = '1' else
    255;
  process (clk, reset)
  begin
    if (reset = '0') then
      counter <= 0;
    elsif (rising_edge(clk)) then
      if (load = '1') then
        counter <= to_integer(unsigned(parallel_in));
      elsif (pause = '1') then
        counter <= counter + term;
      end if;
    end if;
  end process;
  counter_out <= std_logic_vector(to_unsigned(counter, 8));
end architecture;