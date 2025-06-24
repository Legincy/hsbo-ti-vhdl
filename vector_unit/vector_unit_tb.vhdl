library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vector_unit_tb is
end entity;

architecture testbench of vector_unit_tb is
    constant PERIOD : time := 10 ns;

    component vector_unit
    port(
        a: in std_logic_vector(3 downto 0);
        x_to: out std_logic_vector(0 to 3);
        y_downto: out std_logic_vector(3 downto 0)
    );
    end component;

    signal s_a, s_y_downto: std_logic_vector(3 downto 0);
    signal s_x_to: std_logic_vector(0 to 3);

begin
    dut: vector_unit port map(a => s_a, y_downto => s_y_downto, x_to => s_x_to);

    process 
    begin
        for i in 0 to 15 loop
            s_a <= std_logic_vector(to_unsigned(i, 4));
            wait for PERIOD;
        end loop;

        assert false report "Reached end of test";
        wait;
    end process;
end testbench;