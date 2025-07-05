library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_sm is
    generic(
        RED_TIME : integer := 140;
        RED_YELLOW_TIME : integer := 20;
        GREEN_TIME : integer := 140;
        YELLOW_TIME : integer := 20
    );
    port(
        clk, reset, enable: in std_logic;
        o: out std_logic_vector(2 downto 0)
    );
end traffic_light_sm;

architecture behave of traffic_light_sm is
    type light_state is(state_init, state_red, state_yellow, state_green, state_red_yellow);
    signal state, next_state: light_state;

    signal timer_count: integer := 0;
    signal max_count: integer := 0;
    signal is_timer_expired: boolean := false;

begin
    STATE_MEMORY: process(clk, reset)
    begin
        if reset = '1' then
            state <= state_init;
            timer_count <= 0;
        elsif rising_edge(clk) then
            if enable = '1' then
                if state /= next_state then
                    state <= next_state;
                    timer_count <= 0;
                elsif timer_count < max_count then
                    timer_count <= timer_count + 1;
                end if;
            end if;
        end if;
    end process STATE_MEMORY;

    TIMER_LOGIC: process(state, timer_count)
    begin
        is_timer_expired <= false;
        case state is
            when state_red =>
                max_count <= RED_TIME;
                if timer_count >= RED_TIME then
                    is_timer_expired <= true;
                end if;
            when state_red_yellow =>
                max_count <= RED_YELLOW_TIME;
                if timer_count >= RED_YELLOW_TIME then
                    is_timer_expired <= true;
                end if;
            when state_green =>
                max_count <= GREEN_TIME;
                if timer_count >= GREEN_TIME then
                    is_timer_expired <= true;
                end if;
            when state_yellow =>
                max_count <= YELLOW_TIME;
                if timer_count >= YELLOW_TIME then
                    is_timer_expired <= true;
                end if;
            when others =>
                max_count <= 0;
        end case;
    end process TIMER_LOGIC;

    TRANSITION_LOGIC: process(state, is_timer_expired)
    begin
        next_state <= state;

        case state is
            when state_init =>
                next_state <= state_red;
                
            when state_red =>
                if is_timer_expired = true then
                    next_state <= state_red_yellow;
                end if;
                
            when state_red_yellow =>
                if is_timer_expired = true then
                    next_state <= state_green;
                end if;
                
            when state_green =>
                if is_timer_expired = true then
                    next_state <= state_yellow;
                end if;
                
            when state_yellow =>
                if is_timer_expired = true then
                    next_state <= state_red;
                end if;
                
            when others =>
                next_state <= state_init;
        end case;
    end process TRANSITION_LOGIC;

    OUTPUT_DECODE: process(state)
    begin
        case state is
            when state_init =>
                o <= "000";
            when state_red => 
                o <= "001";
            when state_yellow =>
                o <= "010";
            when state_green => 
                o <= "011";
            when state_red_yellow =>
                o <= "100";
            when others => 
                o <= "000";
        end case;
    end process OUTPUT_DECODE;

end behave;