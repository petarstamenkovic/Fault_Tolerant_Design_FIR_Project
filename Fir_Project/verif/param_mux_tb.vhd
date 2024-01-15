library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.variable_io_package.all;
use IEEE.NUMERIC_STD.ALL;
use work.util_pkg.all;

entity param_mux_tb is
--  Port ( );
end param_mux_tb;

architecture Behavioral of param_mux_tb is
    signal mux_in_s : IO_ARRAY(NUM_SPARES downto 0);
    signal sel_s : std_logic_vector(log2c(NUM_SPARES+1)-1 downto 0);
    signal mux_out_s : std_logic_vector(output_width-1 downto 0);
begin

param_mux_instance : 
entity work.param_mux(behavioral) 
port map(
    mux_in => mux_in_s,
    sel => sel_s,
    mux_out => mux_out_s
);

stim : 
process begin
    mux_in_s(0) <= std_logic_vector(to_unsigned(1,24));
    mux_in_s(1) <= std_logic_vector(to_unsigned(2,24));
    mux_in_s(2) <= std_logic_vector(to_unsigned(3,24));
    mux_in_s(3) <= std_logic_vector(to_unsigned(4,24));
    sel_s <= "01", "11" after 100ns, "00" after 200ns, "10" after 300ns;
    
    wait; 
end process;

end Behavioral;
