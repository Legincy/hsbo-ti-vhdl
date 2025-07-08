library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_adder_complement_tb is
end entity;

architecture testbench of nbit_adder_complement_tb is
    component nbit_adder
        generic(n: integer := 8);
        port(
            a, b: in std_logic_vector(n-1 downto 0);
            sum: out std_logic_vector(n-1 downto 0);
            carry_out: out std_logic
        );
    end component;

    constant n : integer := 8;
    constant PERIOD : time := 10 ns;
    
    signal s_a, s_b, s_sum: std_logic_vector(7 downto 0);
    signal s_carry_out: std_logic;

    -- Funktion zur Umwandlung in 2er-Komplement (8-Bit)
    function to_twos_complement_8bit(value: integer) return std_logic_vector is
        variable result: std_logic_vector(7 downto 0);
    begin
        if value >= 0 then
            -- Positive Zahlen: normale Binärdarstellung
            result := std_logic_vector(to_signed(value, 8));
        else
            -- Negative Zahlen: 2er-Komplement
            result := std_logic_vector(to_signed(value, 8));
        end if;
        return result;
    end function;

    -- Funktion zur Interpretation des Ergebnisses als 2er-Komplement
    function from_twos_complement_8bit(vec: std_logic_vector(7 downto 0)) return integer is
    begin
        return to_integer(signed(vec));
    end function;

begin
    dut: nbit_adder 
        generic map(n => n)
        port map(a => s_a, b => s_b, sum => s_sum, carry_out => s_carry_out);

    process
        variable value_120: integer := 120;
        variable value_neg78: integer := -78;
        variable expected_result: integer;
        variable actual_result: integer;
    begin
        report "=== 8-Bit Addierer Test mit 2er-Komplement ===";
        
        -- Berechne erwartetes Ergebnis
        expected_result := value_120 + value_neg78;  -- 120 + (-78) = 42
        
        -- Konvertiere Zahlen ins 2er-Komplement
        s_a <= to_twos_complement_8bit(value_120);   -- 120 in 8-Bit 2er-Komplement
        s_b <= to_twos_complement_8bit(value_neg78); -- -78 in 8-Bit 2er-Komplement
        
        wait for PERIOD;
        
        -- Interpretiere Ergebnis als 2er-Komplement
        actual_result := from_twos_complement_8bit(s_sum);
        
        -- Ausgabe der Binärdarstellungen
        report "=== Eingabewerte ===";
        report "120 dezimal = " & integer'image(to_integer(signed(s_a))) & " binär (2er-Komplement)";
        report "-78 dezimal = " & integer'image(to_integer(signed(s_b))) & " binär (2er-Komplement)";
        
        report "=== Detailanalyse ===";
        report "120 in binär: 01111000";
        report "Tatsächlich:  " & integer'image(to_integer(signed(s_a)));
        report "-78 in 2er-Komplement:";
        report "  78 in binär:     01001110";
        report "  Invertiert:      10110001";
        report "  +1 addiert:      10110010";
        report "  Tatsächlich:     " & integer'image(to_integer(signed(s_b)));
        
        report "=== Ergebnis ===";
        report "Summe binär: " & integer'image(to_integer(signed(s_sum)));
        report "Carry Out: " & std_logic'image(s_carry_out);
        report "Erwarteter Wert: " & integer'image(expected_result);
        report "Tatsächlicher Wert: " & integer'image(actual_result);
        
        -- Überprüfung der Korrektheit
        if actual_result = expected_result then
            report "ERFOLGREICH: Das Ergebnis ist korrekt!";
        else
            report "FEHLER: Das Ergebnis ist falsch!";
        end if;
        
        -- Zusätzliche Tests für Verständnis
        report "=== Zusätzliche Beispiele ===";
        
        -- Test 1: Positive + Positive
        s_a <= to_twos_complement_8bit(50);
        s_b <= to_twos_complement_8bit(30);
        wait for PERIOD;
        report "50 + 30 = " & integer'image(from_twos_complement_8bit(s_sum)) & 
               " (erwartet: 80, carry: " & std_logic'image(s_carry_out) & ")";
        
        -- Test 2: Negative + Negative
        s_a <= to_twos_complement_8bit(-20);
        s_b <= to_twos_complement_8bit(-15);
        wait for PERIOD;
        report "-20 + (-15) = " & integer'image(from_twos_complement_8bit(s_sum)) & 
               " (erwartet: -35, carry: " & std_logic'image(s_carry_out) & ")";
        
        -- Test 3: Grenzfall - Überlauf
        s_a <= to_twos_complement_8bit(127);  -- Maximaler positiver Wert
        s_b <= to_twos_complement_8bit(1);
        wait for PERIOD;
        report "127 + 1 = " & integer'image(from_twos_complement_8bit(s_sum)) & 
               " (Ueberlauf-Test, carry: " & std_logic'image(s_carry_out) & ")";
        
        report "=== Test beendet ===";
        wait;
    end process;
    
end testbench;