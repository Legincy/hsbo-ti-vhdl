library ieee;
use ieee.numeric_std.all;

entity faculty is
    port (
        a: in positive;
        x: out positive
    );
end faculty;

architecture behave of faculty is
begin
    process(a)
        variable v_result: positive;

    begin
        v_result := 1;
        
        for i in 1 to a loop
            v_result := v_result * i;
        end loop;

        x <= v_result;
    end process;
end behave ; -- behave
