library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy_template_tb is
end entity;

architecture testbench of mealy_template_tb is
    component mealy_template
        port(
            clk: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            d: in std_logic;
            q: out std_logic
        );
    end component;
    
    constant CLK_PERIOD: time := 20 ns;
    signal s_clk, s_reset, s_enable, s_d, s_q: std_logic;
    signal is_finished: boolean := false;
    
begin
    DUT: mealy_template port map(s_clk, s_reset, s_enable, s_d, s_q);
    
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
        s_reset <= '1';
        wait for CLK_PERIOD/2;
        s_reset <= '0';
        s_d <= '0';
        wait for CLK_PERIOD/2;
       
        s_enable <= '1';
        
        s_d <= '0';
        wait for CLK_PERIOD;
        
        s_d <= '1';
        wait for CLK_PERIOD;
        
        s_d <= '0';
        wait for CLK_PERIOD;
        
        is_finished <= true;
        assert false report "Reached end of test";
        wait;
    end process;
end testbench;