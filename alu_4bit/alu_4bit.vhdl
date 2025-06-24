library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_4bit is
    port(
        a, b, sel: in std_logic_vector(3 downto 0);
        alu: out std_logic_vector(4 downto 0)
    );
end entity;

architecture behave of alu_4bit is
begin
    process(a, b, sel)
    begin
        case sel is
            when "0000" => 
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(a)) + to_integer(unsigned(b)), 5));
            when "0001" =>
                alu <= std_logic_vector(to_signed(to_integer(unsigned(a)) - to_integer(unsigned(b)), 5));
            when "0010" => 
                alu <= std_logic_vector(to_signed(to_integer(unsigned(a)) - 1, 5));
            when "0011" => 
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(a)) + 1, 5));
            when "0100" => 
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(a AND b)), 5));
            when "0101" => 
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(a OR b)), 5));
            when "0110" =>
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(NOT a)), 5));
            when "0111" => 
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(NOT b)), 5));
            when "1000" =>
                alu <= std_logic_vector(to_unsigned(to_integer(unsigned(a XOR b)), 5));
            when others => 
                alu <= "00000";
        end case;
    end process; 

end behave;