library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.variable_io_package.all;

entity switch_logic is
generic(NUM_SPARES : integer := 3;
        NUM_MODULAR : integer := 4;   
        output_data_width : integer := 24); 
       Port (
            in1  : in IO_ARRAY(NUM_MODULAR-1 downto 0);
            in2  : in IO_ARRAY(NUM_SPARES-1 downto 0);
            comp_out : in std_logic_vector(NUM_MODULAR-1 downto 0);
            out1 : out IO_ARRAY(NUM_MODULAR-1 downto 0) 
        );
end switch_logic;

architecture Behavioral of switch_logic is
	-- Signal that represents the availlability of spares (00...00 all availlable, 00..011 two are not)
    signal used_spares : std_logic_vector(NUM_SPARES-1 downto 0) := (others => '0');
	-- Signal used for zero comparison
    signal zero_vector : std_logic_vector(NUM_MODULAR-1 downto 0) := (others => '0');
begin

process(in1,in2,comp_out) 
    variable one : integer := 0;
    variable temp : integer := 0;
begin 
	-- If comparator says all zeros(no error) just connect the in1 and out1
    if(comp_out = zero_vector) then 
        for i in 0 to NUM_MODULAR-1 loop
            out1(i) <= in1(i);
        end loop; 
    else 
		-- Find the error('1') and store that index in "one" variable
        for j in 0 to NUM_MODULAR-1 loop
            if(comp_out(j) = '1') then 
                one := j;
            else 
                one := one;
            end if;
        end loop;
        
        -- Are there spares availlable?
        if(spare_check(comp_out) /= NUM_SPARES) then 
            temp := spare_check(used_spares);
			out1(one) <= in2(temp);
            used_spares(temp) <= '1';
        else 
            temp := temp;
            out1(one) <= in2(temp);
            used_spares(temp) <= '0';
        end if;
    end if;  

end process;

end Behavioral;
