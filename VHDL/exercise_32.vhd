library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clka   : in std_logic;
    clkb   : in std_logic;
    rsta   : in std_logic;
    rstb   : in std_logic;
    pulsea : in std_logic;
    busy   : out std_logic;
    pulseb : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal ff_1 : std_logic;
  signal ff_2 : std_logic;
  signal ff_3 : std_logic;
  signal ff_4 : std_logic;
  signal ff_5 : std_logic;
  signal ff_6 : std_logic;
begin
  process (clka, rsta)
  begin
    if (rsta = '0') then
      ff_1 <= '0';
      ff_5 <= '0';
      ff_6 <= '0';
    elsif (rising_edge(clka)) then
        ff_5 <= ff_3;
        ff_6 <= ff_5;
      if (pulsea = '1') then
        ff_1 <= '1';
      elsif (ff_6 = '1') then
        ff_1 <= '0';
      end if;
    end if;
  end process;

  process (clkb, rstb)
  begin
    if (rstb = '0') then
      ff_2 <= '0';
      ff_3 <= '0';
      ff_4 <= '0';
    elsif (rising_edge(clkb)) then
      ff_2 <= ff_1;
      ff_3 <= ff_2;
      ff_4 <= ff_3;
    end if;
    end process;
    busy   <= ff_6 or ff_1;
    pulseb <= not ff_4 and ff_3;
  end architecture;
