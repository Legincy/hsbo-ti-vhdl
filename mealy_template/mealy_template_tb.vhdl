library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy_template is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        d: in std_logic;
        q: out std_logic
    );
end entity;

architecture behave of mealy_template is
    type fsm_state is (S0, S1);
    signal current_state, next_state: fsm_state;
begin
    STATE_MEMORY: process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0;
        elsif rising_edge(clk) and enable = '1' then
            current_state <= next_state;
        end if;
    end process STATE_MEMORY;

    TRANSITION_LOGIC: process(current_state, d)
    begin
        case current_state is
            when S0 =>
                if d = '0' then
                   next_state <= S1;
                else
                   next_state <= S0;
                end if;
            when S1 =>
                if d = '1' then
                    next_state <= S0;
                else
                    next_state <= S1;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process TRANSITION_LOGIC;

    OUTPUT_LOGIC: process(current_state, d)
    begin
        case current_state is
            when S0 =>
                if d = '0' then
                    q <= '1';
                else
                    q <= '0';
                end if;
            when S1 =>
                if d = '1' then
                    q <= '1';
                else
                    q <= '0';
                end if;
            when others =>
                q <= '0';
        end case;
    end process OUTPUT_LOGIC;
end behave;