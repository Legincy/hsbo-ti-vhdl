library ieee;
use ieee.std_logic_1164.all;

entity nbit_subtractor is
    generic(n: integer := 4);
    port(
        a, b: in std_logic_vector(n-1 downto 0);
        diff: out std_logic_vector(n-1 downto 0);
        borrow_out: out std_logic
    );
end nbit_subtractor;

architecture behave of nbit_subtractor is
    component full_subtractor 
        port(
            a, b, borrow_in: in std_logic;
            diff, borrow_out: out std_logic
        );
    end component;

    signal s_borrow_in: std_logic_vector(n downto 0);

begin
    s_borrow_in(0) <= '0';

    NBIT_SUB: for i in 0 to n-1 generate
        NBIT_SUB_i: full_subtractor port map (
            a => a(i), 
            b => b(i), 
            borrow_in => s_borrow_in(i), 
            diff => diff(i), 
            borrow_out => s_borrow_in(i+1)
        );
    end generate;

    borrow_out <= s_borrow_in(n);
end behave;