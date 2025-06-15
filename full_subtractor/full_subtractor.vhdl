library ieee;
use ieee.std_logic_1164.all;

entity full_subtractor is
    port (
        a, b, borrow_in: in std_logic;
        diff, borrow_out: out std_logic
    );
end full_subtractor;

architecture part of full_subtractor is
    component half_subtractor
        port(
            a, b: in std_logic;
            diff, borrow: out std_logic
        );
    end component;

    signal s_borrow_1, s_diff_1, s_borrow_2: std_logic;

begin
    p_half_subtractor_1: half_subtractor port map(a => a, b => b, diff => s_diff_1, borrow => s_borrow_1);
    p_half_subtractor_2: half_subtractor port map(a => s_diff_1, b => borrow_in, borrow => s_borrow_2, diff => diff);
    borrow_out <= s_borrow_1 or (not s_diff_1 and borrow_in);
end part;