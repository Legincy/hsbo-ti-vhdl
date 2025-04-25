library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity binary_to_7_segment is
    port (
        clk500Hz: in std_logic; -- 500 Hz, 2 ms
        key: in std_logic_vector(3 downto 0);
        sw: in std_logic_vector(9 downto 0);
        led: out std_logic_vector(9 downto 0);
        hex0: out std_logic_vector(6 downto 0);
        hex1: out std_logic_vector(6 downto 0)
    );
end entity;

architecture behave of binary_to_7_segment is
    signal byte: std_logic_vector(7 downto 0) := "00000000";
    signal clk,reset: std_logic:='0';

    function nibble7seg(nibble: std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        case nibble is 
            when "0000"=> return "1000000"; --0
            when "0001"=> return "1111001"; --1
            when "0010"=> return "0100100"; --2
            when "0011"=> return "0110000"; --3
            when "0100"=> return "0011001"; --4
            when "0101"=> return "0010010"; --5
            when "0110"=> return "0000010"; --6
            when "0111"=> return "1111000"; --7
            when "1000"=> return "0000000"; --8
            when "1001"=> return "0011000"; --9
            when "1010"=> return "0001000"; --A
            when "1011"=> return "0000011"; --B
            when "1100"=> return "1000110"; --C
            when "1101"=> return "0100001"; --D
            when "1110"=> return "0000110"; --E
            when "1111"=> return "0001110"; --F
            when others=> return "1111111"; ---
        end case;
    end function;

begin
    byte <= sw(7 downto 0);
    led(7 downto 0) <= byte;
    reset<=key(0);
    clk<=clk500Hz;

    process(byte, reset)
    begin
        if reset = '0' then
            hex1<=nibble7seg("0000");
            hex0<=nibble7seg("0000");
        else
            hex1<=nibble7seg(byte(7 downto 4));
            hex0<=nibble7seg(byte(3 downto 0));
        end if;

    end process;

end behave;