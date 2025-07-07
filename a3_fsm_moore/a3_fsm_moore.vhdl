library ieee;
use ieee.std_logic_1164.all;

entity a3_fsm_moore is
    port(
        rst, clk, d_in: in std_logic;
        d_out: out std_logic 
    );
end a3_fsm_moore;

architecture behave of a3_fsm_moore is
    type state_type is (state_0, state_1, state_2);
    signal current_state, next_state: state_type;
begin
    STATE_MEMORY: process(clk, rst)
    begin
        if rst = '1' then
            current_state <= state_0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process STATE_MEMORY;

    TRANSITION_LOGIC: process(current_state, d_in)
    begin
        case current_state is
            when state_0 => 
                if d_in = '1' then
                    next_state <= state_1;
                else
                    next_state <= state_0;
                end if;
            when state_1 => 
                if d_in = '0' then
                    next_state <= state_2;
                end if;
            when state_2 => 
                if d_in = '0' then
                    next_state <= state_0;
                end if;
            when others =>
                next_state <= state_0;
        end case;
    end process TRANSITION_LOGIC;

    OUTPUT_LOGIC: process(current_state)
    begin
        case current_state is
            when state_0 => 
                d_out <= '0';
            when state_1 =>
                d_out <= '0';
            when state_2 =>
                d_out <= '1';
            when others => 
                d_out <= '0';
        end case;
    end process OUTPUT_LOGIC;
end behave;