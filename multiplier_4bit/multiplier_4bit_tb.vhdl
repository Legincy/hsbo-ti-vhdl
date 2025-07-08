library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_4bit_tb is
end entity;

architecture testbench of multiplier_4bit_tb is
    component multiplier_4bit
        port(
            x, y: in std_logic_vector(3 downto 0);
            prod: out std_logic_vector(7 downto 0)
        );
    end component;
    
    constant CLK_PERIOD: time := 20 ns;
    signal s_x, s_y: std_logic_vector(3 downto 0);
    signal s_prod: std_logic_vector(7 downto 0); 

begin
    dut: multiplier_4bit port map(x => s_x, y => s_y, prod => s_prod);

    TEST_PROCESS: process
    begin
        for i in 0 to 15 loop
            for j in 0 to 15 loop
                s_x <= std_logic_vector(to_unsigned(i, 4));
                s_y <= std_logic_vector(to_unsigned(j, 4));
                wait for CLK_PERIOD;
            end loop;
        end loop;
        
        assert false report "Finished.";
        wait;
    end process TEST_PROCESS;
end testbench;