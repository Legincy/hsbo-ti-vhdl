library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_flip_flop is
    port(
        clk, reset, d: in std_logic;
        q, not_q: out std_logic
    );
end d_flip_flop;

architecture behave of d_flip_flop is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            q <= '0';
            not_q <= '1';
        elsif rising_edge(clk) then
            not_q <= not d;
            q <= d;
        end if;
    end process;
end behave;