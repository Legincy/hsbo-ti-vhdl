library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit_shifter_tb is
end bit_shifter_tb;

architecture testbench of bit_shifter_tb is
    component bit_shifter
        port(
            rst: in std_logic;
            d_in: in std_logic_vector(1 downto 0);
            d_out: out std_logic_vector(3 downto 0)
        );
    end component;

    constant CLK_PERIOD: time := 20 ns;

    signal s_rst: std_logic;
    signal s_d_in: std_logic_vector(1 downto 0);
    signal s_d_out: std_logic_vector(0 to 3);
begin
    dut: bit_shifter port map(rst => s_rst, d_in => s_d_in, d_out => s_d_out);

    TEST_PROCESS: process
    begin
        s_rst <= '1';
        wait for CLK_PERIOD;

        s_rst <= '0';

        for i in 0 to 3 loop
            s_d_in <= std_logic_vector(to_unsigned(i, 2));
            wait for CLK_PERIOD;
        end loop;
        
        assert false report "Reached end of test";
        wait;
    end process TEST_PROCESS;
end architecture testbench;