library ieee;
use ieee.std_logic_1164.all;

entity multiplier_4bit is
    port(
        x, y: in std_logic_vector(3 downto 0);
        prod: out std_logic_vector(7 downto 0)
    );
end entity;

architecture behave of multiplier_4bit is
    component nbit_adder
        generic(n: integer := 4);
        port(        
            a, b: in std_logic_vector(n-1 downto 0);
            sum: out std_logic_vector(n-1 downto 0);
            carry_out: out std_logic
        );
    end component;
    
    signal G0, G1, G2: std_logic_vector(3 downto 0); 
    signal B0, B1, B2: std_logic_vector(3 downto 0); 

begin

    G0 <= (x(3) and y(1), x(2) and y(1), x(1) and y(1), x(0) and y(1));
    G1 <= (x(3) and y(2), x(2) and y(2), x(1) and y(2), x(0) and y(2));
    G2 <= (x(3) and y(3), x(2) and y(3), x(1) and y(3), x(0) and y(3));

    B0 <= ('0', x(3) and y(0), x(2) and y(0), x(1) and y(0));

    NBIT_ADDER_1: nbit_adder port map(
        a => G0,
        b => B0,
        carry_out => B1(3),
        sum(3) => B1(2),
        sum(2) => B1(1),
        sum(1) => B1(0),
        sum(0) => prod(1)
    );
    
    NBIT_ADDER_2: nbit_adder port map(
        a => G1,
        b => B1,
        carry_out => B2(3),
        sum(3) => B2(2),
        sum(2) => B2(1),
        sum(1) => B2(0),
        sum(0) => prod(2)
    );

    NBIT_ADDER_3: nbit_adder port map(
        a => G2,
        b => B2,
        carry_out => prod(7),
        sum => prod(6 downto 3)
    );

    prod(0) <= x(0) and y(0);
end behave ; -- behave