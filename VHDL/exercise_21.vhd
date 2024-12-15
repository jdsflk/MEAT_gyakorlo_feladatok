library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity circuit is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        pause: in std_logic;
        dir: in std_logic;
        parallel_in: in std_logic_vector (7 downto 0);
        load: in std_logic;
        counter_out: out std_logic_vector (7 downto 0)
    );
end entity circuit;

architecture rtl of circuit is
    signal ff_pause_1: std_logic;
    signal ff_pause_2: std_logic;

    signal ff_dir_1: std_logic;
    signal ff_dir_2: std_logic;

    signal ff_load_1: std_logic;
    signal ff_load_2: std_logic;

    signal term: integer range 0 to 255;
    signal counter: integer range 0 to 255;
begin
    term <= 1 when ff_dir_2 = '0' else 255;
    process (clk, reset)
    begin
        if(reset = '0') then
            ff_pause_1 <= '0';
            ff_pause_2 <= '0';
            ff_dir_1 <= '0';
            ff_dir_2 <= '0';
            ff_load_1 <= '0';
            ff_load_2 <= '0';
            counter <= 0;
        elsif(rising_edge(clk)) then
            ff_pause_1 <= pause;
            ff_pause_2 <= ff_pause_1;
            ff_dir_1 <= dir;
            ff_dir_2 <= ff_dir_1;
            ff_load_1 <= load;
            ff_load_2 <= ff_load_1;
            if (ff_load_2 = '1') then
                counter <= to_integer(unsigned(parallel_in));
            elsif (ff_pause_2 = '0') then
                counter <= counter + term;
            end if;
        end if;
    end process;
    counter_out <= std_logic_vector(to_unsigned(counter, 8));
end architecture;