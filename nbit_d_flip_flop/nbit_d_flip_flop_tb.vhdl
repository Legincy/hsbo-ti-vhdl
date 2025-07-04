library ieee; 
use ieee.std_logic_1164.all;

entity nbit_d_flip_flop_tb is
end nbit_d_flip_flop_tb;

architecture testbench of nbit_d_flip_flop_tb is
    component nbit_d_flip_flop
        generic(n: integer := 4);
        port(
            d_in: in std_logic;
            clk: in std_logic;
            reset: in std_logic;
            q_out: out std_logic
        );
    end component;
    
    constant n : integer := 4;
    constant CLK_PERIOD : time := 20 ns;

    signal s_d_in, s_clk, s_reset, s_q_out: std_logic;
    signal is_finished : boolean := false;

begin
    DUT: nbit_d_flip_flop 
    generic map(n => n)
    port map(
        d_in => s_d_in,
        clk => s_clk,
        reset => s_reset,
        q_out => s_q_out
    );

    clk_process: process
    begin
        while not is_finished loop
            s_clk <= '0';
            wait for CLK_PERIOD/2;
            exit when is_finished;
            s_clk <= '1';
            wait for CLK_PERIOD/2;
            exit when is_finished;
        end loop;
        wait;
    end process clk_process;

    test_process: process
    begin
        s_d_in <= '0';
        s_reset <= '1';
        wait for CLK_PERIOD;

        s_reset <= '0';
        wait for CLK_PERIOD;

 report "=== Teste Sequenz: 1-0-0-0 ===";
        s_d_in <= '1';
        wait for CLK_PERIOD;
        s_d_in <= '0';
        wait for CLK_PERIOD;
        s_d_in <= '0';
        wait for CLK_PERIOD;
        s_d_in <= '0';
        wait for CLK_PERIOD;
        s_d_in <= '0';
        wait for CLK_PERIOD;
        
        report "=== Test Sequenz: 1-1-0-1 ===";
        s_d_in <= '1';
        wait for CLK_PERIOD;
        s_d_in <= '1';
        wait for CLK_PERIOD;
        s_d_in <= '0';
        wait for CLK_PERIOD;
        s_d_in <= '1';
        wait for CLK_PERIOD;
        
        s_d_in <= '0';
        wait for CLK_PERIOD * 4;
        
        report "=== Test Reset ===";
        s_d_in <= '1';
        wait for CLK_PERIOD;
        s_reset <= '1';  -- Reset während '1' im System
        wait for CLK_PERIOD;
        s_reset <= '0';
        wait for CLK_PERIOD;

        is_finished <= true;
        assert false report "Reached end of test";
        wait;
    end process test_process;

    monitor_process: process(s_clk)
    begin
        if not is_finished then
            if rising_edge(s_clk) then
                report "Zeit: " & time'image(now) & 
                    " | D_IN: " & std_logic'image(s_d_in) &
                    " | Q_OUT: " & std_logic'image(s_q_out) &
                    " | Reset: " & std_logic'image(s_reset);
            end if;
        end if;
    end process monitor_process;

end testbench;