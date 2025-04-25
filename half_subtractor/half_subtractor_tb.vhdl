library ieee;
use ieee.std_logic_1164.all;

entity half_subtractor_tb is
end entity;

architecture testbench of half_subtractor_tb is
    component half_subtractor
        port (
            a: in std_logic;
            b: in std_logic;
            diff: out std_logic;
            borrow: out std_logic
        );
    end component;
    
    signal a_signal, b_signal, diff_signal, borrow_signal: std_logic; 

begin
    p_half_subtractor: half_subtractor port map(a => a_signal, b => b_signal, diff => diff_signal, borrow => borrow_signal);


    process begin
        for i in 0 to 1 loop
            if i = 0 then
                a_signal <= '0';
            else
                a_signal <= '1';
            end if;

            for j in 0 to 1 loop
                if j = 0 then
                    b_signal <= '0';
                else
                    b_signal <= '1';
                end if;
                
                wait for 10 ns;
            end loop;
            
        end loop;

        assert false report "Reached end of test";
        wait;
    end process;

end testbench ;  