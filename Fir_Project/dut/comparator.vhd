library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.variable_io_package.all;

entity comparator is
      generic(NUM_MODULAR : integer := 3;   
              output_data_width : integer := 24); 
      Port ( 
                in1  : in IO_ARRAY(NUM_MODULAR-1 downto 0); 
                vot_out : in std_logic_vector(output_data_width-1 downto 0);
                comp_out : out COMP_OUT_TYPE(NUM_MODULAR-1 downto 0) 
            );
end comparator;

architecture Behavioral of comparator is

begin

process(vot_out, in1) 
begin 
    for i in 0 to NUM_MODULAR-1 loop
      if(vot_out /= in1(i)) then
        comp_out(i) <= '1';
      else 
        comp_out(i) <= '0';
      end if;    
    end loop;       
end process;

end Behavioral;
