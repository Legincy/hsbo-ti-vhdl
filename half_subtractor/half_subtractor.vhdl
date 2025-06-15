library ieee;
use ieee.std_logic_1164.all;

entity half_subtractor is
    port (
        a: in std_logic;
        b: in std_logic;
        diff: out std_logic;
        borrow: out std_logic
    );
end entity;

architecture behave of half_subtractor is
begin
    diff <= a xor b;
    borrow <= (a xor b) and b;

end behave;