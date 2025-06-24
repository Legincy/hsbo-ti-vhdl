library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_4bit_tb is
end entity;

architecture testbench of alu_4bit_tb is
    constant PERIOD : time := 10 ns;

    component alu_4bit 
    port(
        a, b, sel: in std_logic_vector(3 downto 0);
        alu: out std_logic_vector(4 downto 0)
    );
    end component;
    
    signal s_a, s_b, s_sel: std_logic_vector(3 downto 0);
    signal s_alu: std_logic_vector(4 downto 0);

begin
    dut: alu_4bit port map(a => s_a, b => s_b, sel => s_sel, alu => s_alu);

    process 
        variable expected : integer;

    begin
        s_sel <= std_logic_vector(to_unsigned(0, 4));
        s_a <= std_logic_vector(to_unsigned(0, 4));
        s_b <= std_logic_vector(to_unsigned(0, 4));
        wait for PERIOD;

        for i in 0 to 15 loop
            s_sel <= std_logic_vector(to_unsigned(i, 4));
            wait for PERIOD;

            for j in 0 to 15 loop
                for k in 1 to 15 loop
                    s_a <= std_logic_vector(to_unsigned(j, 4));
                    s_b <= std_logic_vector(to_unsigned(k, 4));
                    wait for PERIOD;

                    case s_sel is
                        when "0000" => 
                            expected := to_integer(unsigned(resize(unsigned(s_a), 5)) + unsigned(resize(unsigned(s_b), 5)));
                            assert to_integer(unsigned(s_alu)) = expected
                                report "[ADD]: " & integer'image(to_integer(unsigned(s_a))) & "+" & integer'image(to_integer(unsigned(s_b))) & "=" & 
                                    integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                        when "0001" =>
                            expected := to_integer(signed(resize(unsigned(s_a), 5)) - signed(resize(unsigned(s_b), 5)));

                            assert to_integer(signed(s_alu)) = expected
                                report "[SUB]: " & integer'image(to_integer(unsigned(s_a))) & " - " & 
                                                integer'image(to_integer(unsigned(s_b))) & " = " &
                                                integer'image(to_integer(signed(s_alu))) & ", expected " & 
                                                integer'image(expected)
                                severity error;
                        when "0010" => 
                            expected := to_integer(signed(to_signed(to_integer(unsigned(s_a)), 5) - to_signed(1, 5)));
                            assert to_integer(signed(s_alu)) = expected
                                report "[-1]: " & integer'image(to_integer(unsigned(s_a))) & "-1=" & 
                                    integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                        when "0011" => 
                            expected := to_integer(signed(to_signed(to_integer(unsigned(s_a)), 5) + to_signed(1, 5)));
                            assert to_integer(signed(s_alu)) = expected
                                report "[+1]: " & integer'image(to_integer(unsigned(s_a))) & "+1=" & 
                                    integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                        when "0100" => 
                            expected := to_integer(unsigned(s_a AND s_b)) mod 32;
                            assert to_integer(unsigned(s_alu)) = expected
                                report "[AND]: " & integer'image(to_integer(unsigned(s_a))) & " AND " & integer'image(to_integer(unsigned(s_b))) &" = " & 
                                    integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                        when "0101" => 
                            expected := to_integer(unsigned(s_a OR s_b)) mod 32;
                            assert to_integer(unsigned(s_alu)) = expected
                                report "[OR]: " & integer'image(to_integer(unsigned(s_a))) & " OR " & integer'image(to_integer(unsigned(s_b))) &" = " & 
                                    integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                        when "0110" =>
                            expected := to_integer(unsigned(NOT s_a)) mod 32;
                            assert to_integer(unsigned(s_alu)) = expected
                                report "[NOT A]: " & integer'image(to_integer(unsigned(s_a))) & " expected " & integer'image(expected)
                                severity error;
                        when "0111" => 
                            expected := to_integer(unsigned(NOT s_b)) mod 32;
                            assert to_integer(unsigned(s_alu)) = expected
                                report "[NOT B]: " & integer'image(to_integer(unsigned(s_b))) & " expected " & integer'image(expected)
                                severity error;
                        when "1000" =>
                            expected := to_integer(unsigned(s_a XOR s_b)) mod 32;
                            assert to_integer(unsigned(s_alu)) = expected
                                report "[XOR]: " & integer'image(to_integer(unsigned(s_a))) & " XOR " & integer'image(to_integer(unsigned(s_b))) &" = " & 
                                    integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                        when others =>
                            expected := 0 mod 32;
                            assert to_integer(unsigned(s_alu)) = expected
                                report "UNKNOWN SELECT: " & integer'image(to_integer(unsigned(s_alu))) & " expected " & integer'image(expected)
                                severity error;
                    end case;
                    wait for PERIOD;
                end loop;
            end loop;
        end loop;

        assert false report "Reached end of test";
        wait;
    end process;

end testbench;