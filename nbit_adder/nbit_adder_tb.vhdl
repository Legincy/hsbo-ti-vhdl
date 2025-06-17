library ieee;
use ieee.std_logic_1164.all;

entity nbit_adder_tb is
end entity;

architecture testbench of nbit_adder_tb is
    component nbit_adder
    generic(n: integer := 4);
        port(
            a, b: in std_logic_vector(n-1 downto 0);
            sum: out std_logic_vector(n-1 downto 0);
            carry_out: out std_logic
        );
    end component;

    signal s_a, s_b, s_sum: std_logic_vector(3 downto 0);
    signal s_carry_out: std_logic;

begin
    dut: nbit_adder port map(a => s_a, b => s_b, sum => s_sum, carry_out => s_carry_out);

    process
    begin
        s_a <= "0000"; s_b <= "0000";
        wait for 10 ns;
        s_a <= "0001"; s_b <= "0001";
        wait for 10 ns;
        s_a <= "0010"; s_b <= "0010";
        wait for 10 ns;
        s_a <= "0100"; s_b <= "0100";
        wait for 10 ns;
        s_a <= "1000"; s_b <= "1000";
        wait for 10 ns;
        s_a <= "1111"; s_b <= "1111";
        wait;
    end process;

end testbench ; -- testbench