library ieee;
use ieee.std_logic_1164.all;

entity priority_decoder is
    port (
        a: in std_logic_vector(6 downto 0);
        x: out std_logic_vector(2 downto 0)
    );
end priority_decoder;

architecture behave of priority_decoder is
begin
    process(a) -- Procedure if value "a" changes
    begin
        case a is
            when "0000001" => 
                x <= "001";
            when "0000011" => 
                x <= "010";
            when "0000111" => 
                x <= "011";
            when "0001111" => 
                x <= "100";
            when "0011111" => 
                x <= "101";
            when "0111111" => 
                x <= "110";
            when "1111111" => 
                x <= "111";
            when others => 
                x <= "000";
        end case;
    end process;
end behave;