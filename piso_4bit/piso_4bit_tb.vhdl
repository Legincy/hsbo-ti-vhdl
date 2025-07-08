library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity piso_4bit_tb is
end entity;

architecture testbench of piso_4bit_tb is
    component piso_4bit
        port(
            clk, ctl: in std_logic;
            d: in std_logic_vector(3 downto 0);
            o: out std_logic
        );
    end component;

    constant CLK_PERIOD: time := 20 ns;
    signal s_clk, s_ctl, s_o: std_logic;
    signal s_d: std_logic_vector(3 downto 0);
    signal is_finished: boolean := false;

begin

    DUT: piso_4bit port map(clk => s_clk, ctl => s_ctl, d => s_d, o => s_o);

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
        for i in 0 to 1 loop
            for j in 0 to 15 loop
                s_ctl <= std_logic(to_unsigned(i, 1)(0));
                s_d <= std_logic_vector(to_unsigned(j, 4));
                wait for CLK_PERIOD;
            end loop;
        end loop;
        is_finished <= true;
        assert false report "Reached end of test";
        wait;
    end process TEST_PROCESS;

end testbench; -- testbench