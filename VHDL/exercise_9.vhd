library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  generic (
    N : integer := 8
  );
  port (
    clk     : in std_logic;
    reset   : in std_logic;
    trigger : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal cnt            : integer range 0 to N - 1;
  signal ff_trigger     : std_logic;
  signal trigger_signal : std_logic;
begin
  trigger_signal <= '1' when cnt = N - 1 else
    '0';
  process (clk, reset)
  begin
    if (reset = '0') then
      cnt        <= 0;
      ff_trigger <= '0';
    elsif (rising_edge(clk)) then
      ff_trigger <= trigger_signal;
      if (trigger_signal = '1') then
        cnt <= 0;
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  trigger <= ff_trigger;
end architecture;