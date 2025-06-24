library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nbit_subtractor_tb is
end nbit_subtractor_tb;

architecture testbench of nbit_subtractor_tb is
    constant n : integer := 4;
    constant PERIOD : time := 10 ns;

    component nbit_subtractor 
    generic(n: integer := 4);
        port(
            a, b: in std_logic_vector(n-1 downto 0);
            diff: out std_logic_vector(n-1 downto 0);
            borrow_out: out std_logic
        );
    end component;
    
    signal s_a, s_b: std_logic_vector(n-1 downto 0);
    signal s_diff: std_logic_vector(n-1 downto 0);
    signal s_borrow_out: std_logic;

begin
    DUT: nbit_subtractor 
    generic map(n => n)
    port map(
        a => s_a,
        b => s_b,
        diff => s_diff,
        borrow_out => s_borrow_out
    );

    process
    begin
        for i in 0 to 1 loop
            for j in 0 to 1 loop

                s_a <= std_logic_vector(to_unsigned(i, n));
                s_b <= std_logic_vector(to_unsigned(j, n));
                
                wait for PERIOD;

                report "a=" & integer'image(i) & 
                       " b=" & integer'image(j) & 
                       " diff=" & integer'image(to_integer(unsigned(s_diff))) & 
                       " borrow=" & std_logic'image(s_borrow_out);
            end loop;
        end loop;
        assert false report "Reached end of test";
        wait;
    end process;
end testbench ; -- testbench