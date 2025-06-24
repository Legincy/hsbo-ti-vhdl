library ieee;
use ieee.std_logic_1164.all;

entity nbit_adder is
    generic(n: integer := 8);
    port(
        a, b: in std_logic_vector(n-1 downto 0);
        sum: out std_logic_vector(n-1 downto 0);
        carry_out: out std_logic
    );
end nbit_adder;

architecture behave of nbit_adder is
    component full_adder
    port(
        a, b, carry_in: in std_logic;
        sum, carry_out: out std_logic    
    );
    end component;

    signal s_t: std_logic_vector(n downto 0); 

begin
    s_t(0) <= '0';
    carry_out <= s_t(n);

    FA: for i in 0 to n-1 generate
        FA_i: full_adder port map(a(i), b(i), s_t(i), sum(i), s_t(i+1));
   end generate;

end behave ; -- behave