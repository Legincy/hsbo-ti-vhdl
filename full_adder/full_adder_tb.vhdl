library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture testbench of full_adder_tb is
    component full_adder
        port(
            a, b, carry_in: in std_logic;
            sum, carry_out: out std_logic
        );
    end component;

    signal s_a, s_b, s_carry_in, s_sum, s_carry_out: std_logic;

begin
    p_full_adder: full_adder port map(a => s_a, b => s_b, carry_in => s_carry_in, sum => s_sum, carry_out => s_carry_out);

    process 
    constant period: time := 100 ns;
    constant logic_vals : std_logic_vector(0 to 1) := "01";

    begin
    s_a <= '0';
    s_b <= '0';
    s_carry_in <= '0';
    wait for period;

    for i in 0 to 1 loop
        for j in 0 to 1 loop
            for k in 0 to 1 loop
                s_a        <= logic_vals(i);
                s_b        <= logic_vals(j);
                s_carry_in <= logic_vals(k);

                wait for period;
                report "Die Ausgabe bei (a): " & std_logic'image(s_a) & ", (b): " & std_logic'image(s_b) & " und (carry_in): " & std_logic'image(s_carry_in) & " -- (sum): " & std_logic'image(s_sum) & " | (carry_out): " & std_logic'image(s_carry_out);
                wait for period;

            end loop;
        end loop;
    end loop;

    assert false report "Reched end of test";
    wait;
    end process;

end testbench;