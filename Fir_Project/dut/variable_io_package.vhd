library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

package variable_io_package is 
    constant output_width : integer := 24;
    constant NUM_SPARES : integer := 3;
    type IO_ARRAY is array (integer range <>) of std_logic_vector(output_width-1 downto 0);
    function spare_check(input_array : std_logic_vector) return integer;
end variable_io_package;

package body variable_io_package is 
    function spare_check(input_array : std_logic_vector) return integer is 
        variable index : integer;
    begin
        if(input_array = std_logic_vector(to_unsigned(1,NUM_SPARES))) then
            index := NUM_SPARES;
        else
             for i in 0 to NUM_SPARES-1 loop
                if(input_array(i) = '0') then 
                    index := i;                 -- Index of a 0 found in an array(0 will represent if a spare is availlable)
                    exit;
                end if;
            end loop;
        end if;
        return index;    
     end;
end package body;

