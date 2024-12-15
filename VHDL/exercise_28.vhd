library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk       : in std_logic;
    reset     : in std_logic;
    signal_in : in std_logic;
    new_data  : out std_logic;
    dout      : out std_logic_vector (7 downto 0)
  );
end entity circuit;

architecture rtl of circuit is
  signal ff_signal_in_1 : std_logic;
  signal ff_signal_in_2 : std_logic;
  signal ff_signal_in_3 : std_logic;

  signal counter : integer range 0 to 255;
  signal ff_dout : integer range 0 to 255;

  signal signal_in_rising_edge : std_logic;
begin
  signal_in_rising_edge <= ff_signal_in_2 and not ff_signal_in_3;
  process (clk, reset)
  begin
    if (reset = '0') then
      ff_signal_in_1 <= '0';
      ff_signal_in_2 <= '0';
      ff_signal_in_3 <= '0';
      counter        <= 0;
      ff_dout        <= 0;
    elsif (rising_edge(clk)) then
      ff_signal_in_1 <= signal_in;
      ff_signal_in_2 <= ff_signal_in_1;
      ff_signal_in_3 <= ff_signal_in_2;
      if (signal_in_rising_edge = '1') then
        ff_dout <= counter;
        counter <= 0;
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;
  new_data <= signal_in_rising_edge;
  dout     <= std_logic_vector(to_unsigned(ff_dout, 8));
end architecture;