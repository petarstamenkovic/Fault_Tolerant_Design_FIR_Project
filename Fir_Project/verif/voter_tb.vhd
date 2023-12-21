library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.variable_io_package.all;

entity voter_tb is
generic(NUM_INPUT : integer := 3;
        output_data_width : integer := 24);
--  Port ( );
end voter_tb;

architecture Behavioral of voter_tb is
    signal out1_s : std_logic_vector(output_data_width-1 downto 0);
    signal in1_s : IO_ARRAY(NUM_INPUT-1 downto 0);
begin

voter_instance : 
entity work.voter(behavioral)
generic map(NUM_INPUT => NUM_INPUT,
            output_data_width => output_data_width)
port map(in1 => in1_s,
         out1 => out1_s);           

stim:
process begin
      in1_s(0) <= std_logic_vector(to_unsigned(5,24)), std_logic_vector(to_unsigned(6,24)) after 200ns, std_logic_vector(to_unsigned(7,24)) after 300ns;
      in1_s(1) <= std_logic_vector(to_unsigned(5,24)), std_logic_vector(to_unsigned(5,24)) after 200ns, std_logic_vector(to_unsigned(5,24)) after 300ns;
      in1_s(2) <= std_logic_vector(to_unsigned(5,24)), std_logic_vector(to_unsigned(5,24)) after 200ns, std_logic_vector(to_unsigned(7,24)) after 300ns;
      wait;
end process;

end Behavioral;
