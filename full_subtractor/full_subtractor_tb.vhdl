library ieee;
use ieee.std_logic_1164.all;

entity full_subtractor_tb is
end full_subtractor_tb;

architecture testbench of full_subtractor_tb is
    component full_subtractor
        port(
            a, b, borrow_in: in std_logic;
            diff, borrow_out: out std_logic
        );
    end component;

    signal s_a, s_b, s_borrow_in, s_borrow_out, s_diff: std_logic;

begin
    p_full_subtractor: full_subtractor port map(a => s_a, b => s_b, borrow_in => s_borrow_in, diff => s_diff, borrow_out => s_borrow_out);

    process
    constant period: time := 100 ns;
    constant logic_vals: std_logic_vector(0 to 1) := "01";

    begin
    s_a <= 'X';
    s_b <= 'X';
    s_borrow_in <= 'X';
    wait for period;

    for i in 0 to 1 loop
        for j in 0 to 1 loop
            for k in 0 to 1 loop
                s_a <= logic_vals(i);
                s_b <= logic_vals(j);
                s_borrow_in <= logic_vals(k);
                
                wait for period;
                report "Die Ausgabe bei (a): " & std_logic'image(s_a) & ", (b): " & std_logic'image(s_b) & " und (borrow_in): " & std_logic'image(s_borrow_in) & " -- (diff): " & std_logic'image(s_diff) & " | (borrow_out): " & std_logic'image(s_borrow_out);
                wait for period;

            end loop;
        end loop;
    end loop;

    assert false report "Reched end of test";
    wait;
    end process;

end testbench;