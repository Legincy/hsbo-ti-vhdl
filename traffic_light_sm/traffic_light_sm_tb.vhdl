library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light_sm_tb is
end traffic_light_sm_tb;

architecture testbench of traffic_light_sm_tb is
    component traffic_light_sm
        generic(
            RED_TIME : integer := 14;
            RED_YELLOW_TIME : integer := 2;
            GREEN_TIME : integer := 14;
            YELLOW_TIME : integer := 2
        );
        port(
            clk, reset, enable: in std_logic;
            o: out std_logic_vector(2 downto 0)
        );
    end component;

    constant CLK_PERIOD: time := 100 ms;

    signal s_clk, s_reset, s_enable: std_logic := '0';
    signal s_o: std_logic_vector(2 downto 0);
    signal is_finished: boolean := false;

    function traffic_light_to_string(signal_value : std_logic_vector(2 downto 0)) return string is
    begin
        case signal_value is
            when "000" => return "AUS         ";
            when "001" => return "ROT         ";
            when "010" => return "GELB        ";
            when "011" => return "GRUEN       ";
            when "100" => return "ROT_GELB    ";
            when others => return "UNBEKANNT  ";
        end case;
    end function;

begin
    DUT: traffic_light_sm 
    generic map(
        RED_TIME => 140,
        RED_YELLOW_TIME => 20,
        GREEN_TIME => 140,
        YELLOW_TIME => 20
    )
    port map(clk => s_clk, reset => s_reset, enable => s_enable, o => s_o);


    CLOCK_PROCESS: process
    begin
        while not is_finished loop
            s_clk <= '0';
            wait for CLK_PERIOD/2;
            exit when is_finished;
            s_clk <= '1';
            wait for CLK_PERIOD/2;
            exit when is_finished;
        end loop;
        wait;
    end process CLOCK_PROCESS;

    TEST_PROCESS: process
    begin
        s_reset <= '1';
        s_enable <= '0';
        wait for CLK_PERIOD/2;

        s_reset <= '0';
        wait for CLK_PERIOD/2;
        
        s_enable <= '1';
        wait for CLK_PERIOD*600;

        is_finished <= true;
        assert false report "Reached end of test";
        wait;    
    end process TEST_PROCESS;

    MONITOR_PROCESS: process(s_clk)
    begin
        if not is_finished then
            if rising_edge(s_clk) then
                report "Zeit: " & time'image(now) & 
                    " | Ampel: " & traffic_light_to_string(s_o) &
                    " | O_OUT: " & integer'image(to_integer(unsigned(s_o))) &
                    " | Reset: " & std_logic'image(s_reset) &
                    " | Enable: " & std_logic'image(s_enable);
            end if;
        end if;
    end process MONITOR_PROCESS;
end testbench;