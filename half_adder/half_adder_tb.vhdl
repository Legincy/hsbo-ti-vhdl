library ieee;
use ieee.std_logic_1164.all;

entity half_adder_tb is
end half_adder_tb;

architecture testbench of half_adder_tb is
    component half_adder
        port
        (
            a: in std_logic;
            b: in std_logic;
            sum: out std_logic;
            carry: out std_logic
        );
    end component;

    signal a, b, sum, carry: std_logic;
begin
    p_half_adder: half_adder port map(a => a, b => b, sum => sum, carry => carry);

    process begin
        a <= 'X';
        b <= 'X';
        wait for 1 ns;

        a <= '0';
        b <= '0';
        wait for 1 ns;
        assert sum = '0' report "Testfall 1 FAILED: sum sollte 0 sein" severity error;
        assert carry = '0' report "Testfall 1 FAILED: carry sollte 0 sein" severity error;

        a <= '0';
        b <= '1';
        wait for 1 ns;

        a <= '1';
        b <= '0';
        wait for 1 ns;

        a <= '1';
        b <= '1';
        wait for 1 ns;

        assert false report "Reached end of test";
        wait;
    end process;
end testbench ; -- testbench