library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clka      : in std_logic;
    clkb      : in std_logic;
    rsta      : in std_logic;
    rstb      : in std_logic;
    dataa     : in std_logic_vector (7 downto 0);
    new_dataa : in std_logic;
    datab     : out std_logic_vector (7 downto 0);
    new_datab : out std_logic;
    acka      : out std_logic
  );
end entity circuit;

architecture rtl of circuit is
  signal b1 : std_logic_vector (7 downto 0);
  signal b2 : std_logic_vector (7 downto 0);

  signal f1 : std_logic;
  signal f2 : std_logic;
  signal f3 : std_logic;
  signal f4 : std_logic;
  signal f5 : std_logic;
  signal f6 : std_logic;

  signal new_datab_signal: std_logic;
begin
    new_datab_signal <= not f4 and f3;
    process (clka, rsta)
    begin 
        if(rsta = '0') then
            f1 <= '0';
            f5 <= '0';
            f6 <= '0';
            b1 <= (others => '0');
        elsif(rising_edge(clka)) then
            b1 <= dataa;
            f5 <= f3;
            f6 <= f5;
            if(new_dataa = '1') then
                f1 <= '1';
            elsif (f6 = '1') then
                f1 <= '0';
            end if;
        end if;
    end process;

    process (clkb, rstb)
    begin 
        if (rstb = '1') then
            f2 <= '0';
            f3 <= '0';
            f4 <= '0';
            b2 <= (others => '0');
        elsif(rising_edge(clkb)) then
            f2 <= f1;
            f3 <= f2;
            f4 <= f3;
            if (new_datab_signal = '1') then
                b2 <= b1;
            end if;
        end if;
    end process;

    datab <= b2;
    new_datab <= new_datab_signal;
    acka <= f1 or f6;
end architecture;