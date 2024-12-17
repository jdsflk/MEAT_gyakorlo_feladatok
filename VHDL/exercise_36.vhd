library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit is
    port(
        clk: in std_logic;
        as_reset_n: in std_logic;
        input_signal: in std_logic;
        counter_max: in std_logic_vector (7 downto 0);
        debounced_output: out std_logic
    );
end entity circuit;

architecture rtl of circuit is
    signal ff_1: std_logic;
    signal ff_2: std_logic;
    signal ff_3: std_logic;
    signal out_ff: std_logic;
    signal counter: integer range 0 to 255;

    signal input_edge: std_logic;
begin
    input_edge <= ff_3 xor ff_2;

    process (clk, as_reset_n)
    begin
        if(as_reset_n = '0') then
            ff_1 <= '0';
            ff_2 <= '0';
            ff_3 <= '0';
            out_ff <= '0';
            counter <= 0;
        elsif(rising_edge(clk)) then
            ff_1 <= input_signal;
            ff_2 <= ff_1;
            ff_3 <= ff_2;
            if(input_edge = '1') then
                counter <= 0;
            elsif(counter < to_integer(unsigned(counter_max))) then
                counter <= counter + 1;
            end if;
            if (counter = to_integer(unsigned(counter_max))) then
                out_ff <= ff_3;
            end if;
        end if;
    end process;
    debounced_output <= out_ff;
end architecture;