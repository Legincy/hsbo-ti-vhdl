library ieee;
use ieee.std_logic_1164.all;

entity priority_decoder_tb is
end priority_decoder_tb;

architecture testbench of priority_decoder_tb is
    component priority_decoder
        port (
            a: in std_logic_vector(6 downto 0);
            x: out std_logic_vector(2 downto 0)
        );
    end component;

    signal a_signal: std_logic_vector(6 downto 0);
    signal x_signal:  std_logic_vector(2 downto 0);
    

begin
    p_priority_decoder: priority_decoder port map(a => a_signal, x => x_signal);

    process begin
        a_signal <= "0000000";
        wait for 1 ns;

        a_signal <= "0000001";
        wait for 1 ns;

        a_signal <= "0000011";
        wait for 1 ns;

        a_signal <= "0000111";
        wait for 1 ns;

        a_signal <= "0001111";
        wait for 1 ns;

        a_signal <= "0011111";
        wait for 1 ns;

        a_signal <= "0111111";
        wait for 1 ns;

        a_signal <= "1111111";
        wait for 1 ns;

        assert false report "Reached end of test";
        wait;
    end process;

end testbench;