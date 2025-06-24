library ieee;
use ieee.std_logic_1164.all;

entity vector_unit is
    port(
        a: in std_logic_vector(3 downto 0);
        x_to: out std_logic_vector(0 to 3);
        y_downto: out std_logic_vector(3 downto 0)
    );
end entity;

architecture behave of vector_unit is
begin
    process(a)
    begin
        x_to <= a;
        y_downto <= a;
    end process;

end behave ; -- behave