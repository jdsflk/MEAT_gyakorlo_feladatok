library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk      : in std_logic;
    reset    : in std_logic;
    din      : in std_logic_vector (7 downto 0);
    intr_ack : in std_logic;
    intr     : out std_logic;
    dout     : out std_logic_vector (7 downto 0)
  );
end entity circuit;

architecture rtl of circuit is
  signal ff_din      : std_logic_vector (7 downto 0);
  signal ff_intr     : std_logic;
  signal ff_dout     : std_logic_vector(7 downto 0);
  signal intr_signal : std_logic;
begin
  intr_signal <= '1' when ff_din < std_logic_vector(to_unsigned(220, 8)) and ff_din > std_logic_vector(to_unsigned(34, 8)) and ff_intr = '0' else
    '0';
  process (clk, reset)
  begin
    if (reset = '0') then
      ff_din  <= (others => '0');
      ff_dout <= (others => '0');
      ff_intr <= '0';
    elsif (rising_edge(clk)) then
      ff_din <= din;
      if (intr_ack = '1') then
        ff_intr <= '0';
      elsif (intr_signal = '1') then
        ff_intr <= '1';
      end if;
      if (intr_signal = '1') then
        ff_dout <= ff_din;
      end if;
    end if;
  end process;
  intr <= intr_ack;
  dout <= ff_dout;
end architecture;