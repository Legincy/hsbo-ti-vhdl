library ieee;
use ieee.std_logic_1164.all;

entity decoder_2_to_4_tb is
end entity;

architecture testbench of decoder_2_to_4_tb is
    component decoder_2_to_4
        port (
            a: in std_logic;
            b: in std_logic;
            c: in std_logic;
            x1: out std_logic;
            x2: out std_logic;
            x3: out std_logic
        );
    end component;

    signal a_signal, b_signal, c_signal, x1_signal, x2_signal, x3_signal: std_logic;

begin
    p_decoder_2_to_4: decoder_2_to_4 port map(a => a_signal, b => b_signal, c => c_signal, x1 => x1_signal, x2 => x2_signal, x3 => x3_signal);

    process begin
        a_loop: for i in 0 to 1 loop
            b_loop: for j in 0 to 1 loop
                c_loop: for k in 0 to 1 loop
                    if i = 0 then
                        a_signal <= '0';
                    else 
                        a_signal <= '1';
                    end if;

                    if j = 0 then
                        b_signal <= '0';
                    else 
                        b_signal <= '1';
                    end if;

                    if k = 0 then
                        c_signal <= '0';
                    else 
                        c_signal <= '1';
                    end if;

                    wait for 1 ns;
                end loop c_loop;
            end loop b_loop;        
        end loop a_loop;
        
        assert false report "Reached end of test";
        wait;
    end process;

end testbench;