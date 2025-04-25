library ieee;
use ieee.numeric_std.all;

entity faculty_tb is
end faculty_tb;

architecture testbench of faculty_tb is
    component faculty
        port (
            a: in positive;
            x: out positive
        ); 
    end component;

    signal a_signal: positive;
    signal x_signal: positive;

begin 
    p_faculty: faculty port map(a => a_signal, x => x_signal);

    process begin
        num_loop: for i in 1 to 5 loop
            a_signal <= i;
            
            wait for 10 ns;
            report "Die Fakultaet (i!) von i: " & positive'image(i) & " betraegt: " & positive'image(x_signal);
        end loop num_loop;
        
        assert false report "Reached end of test";
        wait;
    end process;
    
end testbench;