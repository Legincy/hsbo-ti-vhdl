library ieee;
use ieee.std_logic_1164.all;

entity piso_4bit is
    port(
        clk, ctl: in std_logic;
        d: in std_logic_vector(3 downto 0);
        o: out std_logic
    );
end entity;

architecture behave of piso_4bit is
    signal q: std_logic_vector(3 downto 0);
begin 

    PISO_0: process(clk)
    begin
        if rising_edge(clk) then
            case ctl is
                when '1' => 
                    q(0) <= d(0);
                when '0' => 
                    q(0) <= d(1);
                when others => 
                    q(0) <= d(0);
            end case;
        end if;
    end process PISO_0;

    PISO_1: process(clk)
    begin
        if rising_edge(clk) then
            case ctl is
                when '1' => 
                    q(1) <= d(1);
                when '0' => 
                    q(1) <= d(2);
                when others => 
                    q(1) <= d(1);
            end case;
        end if;
    end process PISO_1;

    PISO_2: process(clk)
    begin
        if rising_edge(clk) then
            case ctl is
                when '1' => 
                    q(2) <= d(2);
                when '0' => 
                    q(2) <= d(3);
                when others => 
                    q(2) <= d(2);
            end case;
        end if;
    end process PISO_2;

    PISO_3: process(clk)
    begin
        if rising_edge(clk) then
            case ctl is
                when '1' => 
                    q(3) <= d(3);
                when '0' => 
                    q(3) <= '0';
                when others => 
                    q(3) <= d(3);
            end case;
        end if;
    end process PISO_3;

    o <= q(0);

end behave;