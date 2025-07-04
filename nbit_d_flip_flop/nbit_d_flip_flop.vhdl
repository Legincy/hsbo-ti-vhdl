library ieee;
use ieee.std_logic_1164.all;

entity nbit_d_flip_flop is
    generic(n: integer := 4);
    port(
        d_in: in std_logic;
        clk: in std_logic;
        reset: in std_logic;
        q_out: out std_logic
    );
end nbit_d_flip_flop;

architecture behave of nbit_d_flip_flop is
    component d_flip_flop 
        port(
            clk, reset, d: in std_logic;
            q, not_q: out std_logic
        );
    end component;

    signal chain: std_logic_vector(n downto 0);

begin
    chain(0) <= d_in;

    NBIT_D_FLIP_FLOP_GEN: for i in 0 to n-1 generate
        NBIT_D_FLIP_FLOP_i: d_flip_flop port map (
            clk => clk,
            reset => reset,
            d => chain(i),
            q => chain(i+1),
            not_q => open
        );
    end generate;

    q_out <= chain(n);

end behave;