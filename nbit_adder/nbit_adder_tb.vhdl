library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_adder_tb is
end entity;

architecture testbench of nbit_adder_tb is
    component nbit_adder
    generic(n: integer := 8);
        port(
            a, b: in std_logic_vector(n-1 downto 0);
            sum: out std_logic_vector(n-1 downto 0);
            carry_out: out std_logic
        );
    end component;

    constant n : integer := 4;
    signal s_a, s_b, s_sum: std_logic_vector(3 downto 0);
    signal s_carry_out: std_logic;

    begin
        dut: nbit_adder 
            generic map(n => n)
            port map(a => s_a, b => s_b, sum => s_sum, carry_out => s_carry_out);
        
        process
        begin
            report "=== Starte Test für alle Kombinationen ===";
            
            -- Alle Kombinationen durchgehen (0 bis 2^n-1)
            for i in 0 to (2**n - 1) loop
                for j in 0 to (2**n - 1) loop
                    -- Eingangswerte setzen
                    s_a <= std_logic_vector(to_unsigned(i, n));
                    s_b <= std_logic_vector(to_unsigned(j, n));
                    
                    -- Warten auf Stabilisierung
                    wait for 10 ns;
                    
                    -- Ergebnis ausgeben
                    report "a=" & integer'image(i) & 
                           " b=" & integer'image(j) & 
                           " sum=" & integer'image(to_integer(unsigned(s_sum))) & 
                           " carry=" & std_logic'image(s_carry_out) &
                           " (erwartet: " & integer'image((i + j) mod (2**n)) & 
                           ", carry=" & integer'image((i + j) / (2**n)) & ")";
                end loop;
            end loop;
            
            report "=== Test beendet ===";
            wait;
        end process;
        
    end testbench;