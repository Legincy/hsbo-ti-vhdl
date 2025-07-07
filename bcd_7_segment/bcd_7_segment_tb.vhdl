library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity bcd_7_segment_tb is
end bcd_7_segment_tb;

architecture testbench of bcd_7_segment_tb is
    component bcd_7_segment 
    port(
        BCDin: in std_logic_vector(3 downto 0);
        Seven_Segment: out std_logic_vector(6 downto 0)
    );
    end component;

    signal s_BCDin: std_logic_vector(3 downto 0);
    signal s_Seven_Segment: std_logic_vector(6 downto 0);
begin
    dut: bcd_7_segment port map(BCDin => s_BCDin, Seven_Segment => s_Seven_Segment);
    
    process
    begin
        for i in 0 to 15 loop
            s_BCDin <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        assert false report "Reached end of test";
        wait;

    end process;
end testbench;