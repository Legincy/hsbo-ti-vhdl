library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        carry_in, a, b: in std_logic;
        sum, carry_out: out std_logic
    );
end full_adder;

architecture part of full_adder is
    component half_adder 
        port(
            a, b: in std_logic;
            sum, carry: out std_logic
        );
    end component;

    signal s_sum_1, s_carry_1, s_carry_2: std_logic;

begin
    p_half_adder_1: half_adder port map(a => a, b => b, sum => s_sum_1, carry => s_carry_1);
    p_half_adder_2: half_adder port map(a => s_sum_1, b => carry_in, sum => sum, carry => s_carry_2);
    carry_out <= s_carry_2 OR s_carry_1;
end part;
