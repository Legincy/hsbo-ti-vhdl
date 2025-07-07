library ieee;
use ieee.std_logic_1164.all;

entity bit_shifter is
    port(
        rst: in std_logic;
        d_in: in std_logic_vector(1 downto 0);
        d_out: out std_logic_vector(3 downto 0)
    );
end bit_shifter;

architecture behave of bit_shifter is
    signal data: std_logic_vector(0 to 3);
begin
    MAIN_PROCESS: process(rst, d_in)
    begin
        if rst = '1' then
            data <= "1001";
            d_out <= data;
        else 
            case d_in is
                when "00" =>
                    d_out <= data;
                when "01" =>
                    d_out <= data(1 to 3) & '0';
                when "10" =>
                    d_out <= '0' & data(0 to 2);
                when "11" =>
                    d_out <= data;
                when others =>
                    d_out <= data;
            end case;
        end if;
    end process MAIN_PROCESS;
        
end architecture behave;
