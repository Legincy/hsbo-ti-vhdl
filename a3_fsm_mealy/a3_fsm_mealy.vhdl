library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity a3_fsm_mealy is
    port(
        clk, reset, d, n: in std_logic;
        z: out std_logic;
        z_state: out std_logic_vector(0 to 1)
    );
end entity;

architecture behave of a3_fsm_mealy is
    type state is (S1, S2, S3);
    signal current_state, next_state: state;

begin
    STATE_MEMORY: process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S1;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process STATE_MEMORY;

    TRANSITION_LOGIC: process(current_state, d, n)
    begin
        next_state <= current_state;

        case current_state is
            when S1 =>
                z_state <= std_logic_vector(to_unsigned(1, 2));
                if d = '1' then
                    next_state <= S3; 
                elsif n = '1' then
                    next_state <= S2;
                end if;
            when S2 => 
                z_state <= std_logic_vector(to_unsigned(2, 2));
                if d = '1' then
                    next_state <= S1; 
                elsif n = '1' then
                    next_state <= S3; 
                end if;
            when S3 =>
                z_state <= std_logic_vector(to_unsigned(3, 2));
                if d = '1' then
                    next_state <= S2; 
                elsif n = '1' then
                    next_state <= S1; 
                end if;
            when others => 
                next_state <= S1;
        end case;
    end process;

    OUTPUT_LOGIC: process(current_state, d, n)
    begin
        z <= '0';

        case current_state is
            when S2 => 
                if d = '1' then
                    z <= '1';
                end if;
            when S3 => 
                if d = '1' then
                    z <= '1';
                elsif n = '1' then
                    z <= '1';
                end if;
            when others => 
                z <= '0';
        end case;
    end process OUTPUT_LOGIC;
end behave ; -- behave