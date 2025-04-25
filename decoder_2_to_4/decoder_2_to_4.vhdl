library ieee;
use ieee.std_logic_1164.all;

entity decoder_2_to_4 is
    port(
        a: in std_logic;
        b: in std_logic;
        c: in std_logic;
        x1: out std_logic;
        x2: out std_logic;
        x3: out std_logic
    );
end decoder_2_to_4;

architecture behave of decoder_2_to_4 is
begin 
    process(a, b, c)
    begin
        if a = '0' and b = '0' and c = '0' then
            x1 <= '0';
            x2 <= '0';
            x3 <= '0';
        elsif a = '0' and b = '0' and c = '1' then
            x1 <= '1';
            x2 <= '0';
            x3 <= '0';
        elsif a = '0' and b = '1' and c = '0' then
            x1 <= '0';
            x2 <= '1';
            x3 <= '0';
        elsif a = '0' and b = '1' and c = '1' then
            x1 <= '1';
            x2 <= '1';
            x3 <= '0';
        elsif a = '1' and b = '0' and c = '0' then
            x1 <= '0';
            x2 <= '0';
            x3 <= '1';
        elsif a = '1' and b = '0' and c = '1' then
            x1 <= '1';
            x2 <= '0';
            x3 <= '1';
        elsif a = '1' and b = '1' and c = '0' then
            x1 <= '0';
            x2 <= '1';
            x3 <= '1';
        else 
            x1 <= '1';
            x2 <= '1';
            x3 <= '1';
        end if; 
    end process;
end behave;