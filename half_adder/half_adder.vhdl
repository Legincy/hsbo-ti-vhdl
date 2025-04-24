library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (
        a: in std_ulogic;
        b: in std_ulogic;
        sum: out std_ulogic;
        carry: out std_ulogic
    );
end half_adder;

architecture behave of half_adder is
begin
    sum <= a xor b;
    carry <= a and b;
end behave; -- behave