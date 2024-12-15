library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity circuit is
  port (
    clka      : in std_logic;
    clkb      : in std_logic;
    rsta      : in std_logic;
    rstb      : in std_logic;
    dataa     : in std_logic_vector (7 downto 0);
    new_dataa : in std_logic;
    datab     : out std_logic_vector (7 downto 0);
    new_datab : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal b_1 : std_logic_vector (7 downto 0);
  signal b_2 : std_logic_vector (7 downto 0);

  signal ff_1 : std_logic;
  signal ff_2 : std_logic;
  signal ff_3 : std_logic;
  signal ff_4 : std_logic;

  signal new_data_signal : std_logic;
begin
  new_data_signal <= ff_3 and not ff_4;
  process (clka, rsta)
  begin
    if (rsta = '0') then
      b_1  <= (others => '0');
      ff_1 <= '0';
    elsif (rising_edge(clka)) then
      b_1  <= dataa;
      ff_1 <= new_dataa;
    end if;
  end process;

  process (clkb, rstb)
  begin
    if (rstb = '0') then
      b_2  <= (others => '0');
      ff_2 <= '0';
      ff_3 <= '0';
      ff_4 <= '0';
    elsif (rising_edge(clkb)) then
      ff_2 <= ff_1;
      ff_3 <= ff_2;
      ff_4 <= ff_3;
      if (new_data_signal = '1') then
        b_2 <= b_1;
      end if;
    end if;
  end process;
  datab     <= b_2;
  new_datab <= new_data_signal;

end architecture;