library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.variable_io_package.all;

entity comparator_tb is
--generic(NUM_MODULAR : integer := 3;
--        output_data_width : integer := 24);
--  Port ( );
end comparator_tb;

architecture Behavioral of comparator_tb is
    signal in1_s : MAC_OUT_ARRAY(NUM_MODULAR-1 downto 0);
    signal vot_out_s : std_logic_vector(2*input_width-1 downto 0);
    signal comp_out_s : std_logic_vector(NUM_MODULAR-1 downto 0);
begin

comparator_instance : 
entity work.comparator(behavioral)
port map(
        in1 => in1_s,
        vot_out => vot_out_s,
        comp_out => comp_out_s);
        
stim_gen: 
process begin 
    in1_s(0)   <= std_logic_vector(to_unsigned(5,48)), std_logic_vector(to_unsigned(6,48)) after 100ns, std_logic_vector(to_unsigned(5,48)) after 200ns,std_logic_vector(to_unsigned(7,48)) after 300ns;
    in1_s(1)   <= std_logic_vector(to_unsigned(5,48)), std_logic_vector(to_unsigned(3,48)) after 100ns, std_logic_vector(to_unsigned(5,48)) after 200ns,std_logic_vector(to_unsigned(6,48)) after 300ns;
    in1_s(2)   <= std_logic_vector(to_unsigned(5,48)), std_logic_vector(to_unsigned(3,48)) after 100ns, std_logic_vector(to_unsigned(2,48)) after 200ns,std_logic_vector(to_unsigned(7,48)) after 300ns;
    vot_out_s  <= std_logic_vector(to_unsigned(5,48)), std_logic_vector(to_unsigned(3,48)) after 100ns, std_logic_vector(to_unsigned(5,48)) after 200ns,std_logic_vector(to_unsigned(7,48)) after 300ns;
    wait;
end process;

end Behavioral;
