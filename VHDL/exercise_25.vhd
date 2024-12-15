library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
  port (
    clk         : in std_logic;
    reset       : in std_logic;
    pause       : in std_logic;
    dir         : in std_logic;
    parallel_in : in std_logic_vector (7 downto 0);
    load        : in std_logic;
    shreg_out   : out std_logic_vector (7 downto 0)
  );
end entity circuit;

architecture rtl of circuit is
    signal ff_pause_1: std_logic;
    signal ff_pause_2: std_logic;
    
    signal ff_dir_1: std_logic;
    signal ff_dir_2: std_logic;

    signal ff_load_1: std_logic;
    signal ff_load_2: std_logic;

    signal shreg: std_logic_vector (7 downto 0);
begin
    process (clk, reset)
    begin
        if (reset = '0') then
            ff_pause_1 <= '0';
            ff_pause_2 <= '0';
            ff_dir_1 <= '0';
            ff_dir_2 <= '0';
            ff_load_1 <= '0';
            ff_load_2 <= '0';
            shreg <= (others => '0');
        elsif (rising_edge(clk)) then
            ff_pause_1 <= pause;
            ff_pause_2 <= ff_pause_1;
            ff_dir_1 <= dir;
            ff_dir_2 <= ff_dir_1;
            ff_load_1 <= load;
            ff_load_2 <= ff_load_1;
            if (ff_load_2 = '1') then
                shreg <= parallel_in;
            elsif (ff_pause_2 = '0') then
                if (ff_dir_2 = '1') then
                    shreg <= shreg (6 downto 0) & shreg (7);
                else 
                    shreg <= shreg(0) & shreg(7 downto 1);
                end if;
            end if;
        end if;
    end process;
    shreg_out <= shreg;
end architecture;