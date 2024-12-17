library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk           : in std_logic;
    as_reset_n    : in std_logic;
    logic_input   : in std_logic;
    counter_max_0 : in std_logic_vector (7 downto 0);
    counter_max_1 : in std_logic_vector (7 downto 0);
    fsk_output    : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal counter : integer range 0 to 255;
  signal out_ff  : std_logic;
begin
  process (clk, as_reset_n)
  begin
    if (as_reset_n = '0') then
      counter <= 0;
      out_ff  <= '0';
    elsif (rising_edge(clk)) then
      if (logic_input = '1') then
        if (counter >= to_integer(unsigned(counter_max_1))) then
          counter <= 0;
          out_ff  <= not out_ff;
        else
          counter <= counter + 1;
        end if;
      else
        if (counter >= to_integer(unsigned(counter_max_0))) then
          counter <= 0;
          out_ff  <= not out_ff;
        else
          counter <= counter + 1;
        end if;
      end if;
    end if;
  end process;
  fsk_output <= out_ff;
end architecture;