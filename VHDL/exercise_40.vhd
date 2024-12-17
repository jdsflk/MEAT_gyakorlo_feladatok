library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk               : in std_logic;
    as_reset_n        : in std_logic;
    fsk_input         : in std_logic;
    counter_max_0     : in std_logic_vector (7 downto 0);
    counter_max_1     : in std_logic_vector (7 downto 0);
    fsk_input_present : out std_logic;
    logic_output      : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal ff_1 : std_logic;
  signal ff_2 : std_logic;
  signal ff_3 : std_logic;

  signal counter         : integer range 0 to 255;
  signal counter_reached : integer range 0 to 255;

  signal fip_ff : std_logic;
  signal lo_ff  : std_logic;

  signal fsk_input_rising : std_logic;
begin
  fsk_input_rising <= ff_2 and not ff_3;
  process (clk, as_reset_n)
  begin
    if (as_reset_n = '0') then
      ff_1            <= '0';
      ff_2            <= '0';
      ff_3            <= '0';
      counter         <= 0;
      counter_reached <= 0;
      fip_ff          <= '0';
      lo_ff           <= '0';
    elsif (rising_edge(clk)) then
      ff_1 <= fsk_input;
      ff_2 <= ff_1;
      ff_3 <= ff_2;
      if (fsk_input_rising = '1') then
        counter         <= 0;
        counter_reached <= counter;
      elsif (counter < to_integer(unsigned(counter_max_0))) then
        counter <= counter + 1;
      end if;

      if (counter = to_integer(unsigned(counter_max_0))) then
        fip_ff <= '0';
      else
        fip_ff <= '1';
      end if;
      if (counter >= to_integer(unsigned(counter_max_1))) then
        lo_ff <= '0';
      else
        lo_ff <= '1';
      end if;
    end if;
  end process;
  fsk_input_present <= fip_ff;
  logic_output      <= lo_ff;
end architecture;