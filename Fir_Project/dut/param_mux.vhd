library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.util_pkg.all;
use work.variable_io_package.all;

entity param_mux is
     Port ( 
            mux_in  : in IO_ARRAY(NUM_SPARES downto 0);
            sel     : in std_logic_vector(log2c(NUM_SPARES+1)-1 downto 0);
            mux_out : out std_logic_vector(output_width-1 downto 0)
     );
end param_mux;

architecture Behavioral of param_mux is
 
begin

param_mux : 
process(sel,mux_in) 
begin 
    mux_out <= (others => '0');
    for i in 0 to NUM_SPARES loop
            if (sel = std_logic_vector(to_unsigned(i,2))) then 
                mux_out <= mux_in(i);   
            end if;    
    end loop;
end process;

end Behavioral;
