library ieee;
use ieee.std_logic_1164.all;

entity a3_fsm_moore_tb is
end a3_fsm_moore_tb;

architecture testbench of a3_fsm_moore_tb is
    component a3_fsm_moore
        port(
            rst, clk, d_in: in std_logic;
            d_out: out std_logic 
        );
    end component;

    constant CLK_PERIOD: time := 20 ns;
    signal s_rst, s_clk, s_d_in, s_d_out: std_logic;
    signal is_finished: boolean := false;

begin
    dut: a3_fsm_moore port map(rst => s_rst, clk => s_clk, d_in => s_d_in, d_out => s_d_out);

    CLK_PROCESS: process
    begin
        while not is_finished loop
            s_clk <= '0';
            wait for CLK_PERIOD/2;
            s_clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process CLK_PROCESS;

    TEST_PROCESS: process
    begin
        s_rst <= '1';
        s_d_in <= '0';
        wait for CLK_PERIOD*5;

        s_rst <= '0';
        wait for CLK_PERIOD;

        s_d_in <= '1';
        wait for CLK_PERIOD*2;

        s_d_in <= '0';
        wait for CLK_PERIOD*2;

        s_d_in <= '1';
        wait for CLK_PERIOD*2;

        s_d_in <= '0';
        wait for CLK_PERIOD*2;

        is_finished <= true;
        assert false report "Finished Test";
        wait;
    end process TEST_PROCESS;

end testbench;