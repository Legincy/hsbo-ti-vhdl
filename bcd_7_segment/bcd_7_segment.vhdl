library ieee;
use ieee.std_logic_1164.all;

entity bcd_7_segment is
    port(
        BCDin: in std_logic_vector(3 downto 0);
        Seven_Segment: out std_logic_vector(6 downto 0)
    );
end bcd_7_segment;

architecture behave of bcd_7_segment is
    function bcd2segment(nibble: std_logic_vector(3 downto 0)) return std_logic_vector is
    begin 
        case nibble is
            when "0000" => -- 0
                return "1111110";  -- abcdef an, g aus
            when "0001" => -- 1
                return "0110000";  -- bc an, afged aus
            when "0010" => -- 2
                return "1101101";  -- abdeg an, cf aus
            when "0011" => -- 3
                return "1111001";  -- abcdg an, ef aus
            when "0100" => -- 4
                return "0110011";  -- bcfg an, ade aus
            when "0101" => -- 5
                return "1011011";  -- acdfg an, be aus
            when "0110" => -- 6
                return "1011111";  -- acdefg an, b aus
            when "0111" => -- 7
                return "1110000";  -- abc an, defg aus
            when "1000" => -- 8
                return "1111111";  -- alle Segmente an
            when "1001" => -- 9
                return "1111011";  -- abcdfg an, e aus
            when "1010" => -- A (10)
                return "1110111";  -- abcefg an, d aus
            when "1011" => -- b (11)
                return "0011111";  -- cdefg an, ab aus
            when "1100" => -- c (12)
                return "0001101";  -- deg an, abcf aus
            when "1101" => -- d (13)
                return "0111101";  -- bcdeg an, af aus
            when "1110" => -- E (14)
                return "1001111";  -- adefg an, bc aus
            when "1111" => -- F (15)
                return "1000111";  -- aefg an, bcd aus
            when others =>
                return "0000000";  -- alle Segmente aus (Fehlerfall) 
        end case;
    end function;
begin
    -- | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
    -- | g | f | e | d | c | b | a |

    process(BCDin)
    begin
        Seven_Segment <= bcd2segment(BCDin);
    end process;
end behave;