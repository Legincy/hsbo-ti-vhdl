library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity a3_fsm_mealy_tb is
end a3_fsm_mealy_tb;

architecture testbench of a3_fsm_mealy_tb is
    component a3_fsm_mealy 
        port(
            clk, reset, d, n: in std_logic;
            z: out std_logic;
            z_state: out std_logic_vector(0 to 1)
        );
    end component;
    
    constant CLK_PERIOD: time := 20 ns;
    signal s_clk, s_reset, s_d, s_n, s_z: std_logic; 
    signal s_z_state: std_logic_vector(0 to 1);
    signal is_finished: boolean := false;

begin
    dut: a3_fsm_mealy port map(clk => s_clk, reset => s_reset, d => s_d, n => s_n, z => s_z, z_state => s_z_state);

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
        s_d <= 'X';
        s_n <= 'X';
        wait for CLK_PERIOD/2;
        
        s_reset <= '0';
        wait for CLK_PERIOD/2;
        
        for i in 0 to 1 loop
            for j in 0 to 1 loop
                s_d <= std_logic(to_unsigned(i, 1)(0));
                s_n <= std_logic(to_unsigned(j, 1)(0));
                wait for CLK_PERIOD*6;
            end loop;
        end loop;
        is_finished <= true;
        assert false report "Reached end of test";
        wait;
    end process TEST_PROCESS;

end testbench ; -- testbench