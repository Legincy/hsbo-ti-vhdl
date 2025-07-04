library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop_tb is
end d_flip_flop_tb;

architecture testbench of d_flip_flop_tb is
    component d_flip_flop is
        port(
            clk, reset, d: in std_logic;
            q, not_q: out std_logic
        );
    end component;
    
    constant CLK_PERIOD : time := 20 ns;

    signal s_clk, s_reset, s_d, s_q, s_not_q: std_logic := '0';
    signal is_finished : boolean := false;
    signal s_d_inverted : std_logic;


begin
    s_d_inverted <= not s_d;
    DUT: d_flip_flop port map(d => s_d_inverted, clk => s_clk, reset => s_reset, q => s_q, not_q => s_not_q);


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
        s_d <= '0';
        s_reset <= '1';
        wait for CLK_PERIOD;

        s_reset <= '0';
        s_d <= '1';
        wait for CLK_PERIOD;

        s_d <= '0';
        wait for CLK_PERIOD;

        is_finished <= true;
        s_reset <= '1';
        assert false report "Reached end of test";
        wait;
    end process test_process;

    monitor_process: process(s_clk)
    begin
        if not is_finished then
            if rising_edge(s_clk) then
                report "Zeit: " & time'image(now) & 
                    " | D: " & std_logic'image(s_d) &
                    " | Q: " & std_logic'image(s_q) &
                    " | NOT_Q: " & std_logic'image(s_not_q) &
                    " | Reset: " & std_logic'image(s_reset);
            end if;
        end if;
    end process monitor_process;
end testbench ; -- testbench