library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clka  : in std_logic;
    clkb  : in std_logic;
    rsta  : in std_logic;
    rstb  : in std_logic;
    dataa : in std_logic;
    datab : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal ff_1 : std_logic;
  signal ff_2 : std_logic;
  signal ff_3 : std_logic;
begin
  process (clka, rsta)
  begin
    if (rsta = '0') then
      ff_1 <= '0';
    elsif (rising_edge(clka)) then
      ff_1 <= dataa;
    end if;
  end process;

  process (clkb, rstb)
  begin
    if (rstb = '0') then
      ff_2 <= '0';
      ff_3 <= '0';
    elsif (rising_edge(clkb)) then
      ff_2 <= ff_1;
      ff_3 <= ff_2;
    end if;
  end process;
  datab <= ff_3;
end architecture;