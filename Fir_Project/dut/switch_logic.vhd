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
    -- Signal that represents the availlability of original fir modules(00...00 all good, 00..011 two of them failed)
    signal used_modules: std_logic_vector(NUM_MODULAR-1 downto 0) := (others => '0');
	-- Signal used for zero comparison
    signal zero_vector : std_logic_vector(NUM_MODULAR-1 downto 0) := (others => '0');
    signal flag: std_logic:= '0';
begin

process(in1,in2,comp_out) 
begin  
        if(used_modules /= zero_vector) then 
            for j in 0 to NUM_MODULAR-1 loop
                if(used_modules(j) = '1') then 
                    out1(j) <= in2(spare_check(used_spares));
                else 
                    out1(j) <= in1(j);
                end if; 
            end loop;
        else 
            for i in 0 to NUM_MODULAR-1 loop
              out1(i) <= in1(i);
            end loop;     
        end if;  
end process;

component_setting :                            -- This process updates the used_modules signal
process(comp_out) 
        --variable fail : integer := 0;
begin
		-- Find the error('1' : the failed component) and store that index in "fail" variable
        for j in 0 to NUM_MODULAR-1 loop
            if(comp_out(j) = '1') then 
          --      fail := j;
                used_modules(j) <= '1';     -- Mark a module that failed
                flag <= '1';
            else 
                --fail := fail;
                used_modules(j) <= '0';
                flag <= '0';      
            end if;
        end loop;
end process;

spare_setting:
process(flag)
begin 
        -- Are there spares availlable?
        if(spare_check(comp_out) /= NUM_SPARES and flag = '1') then    -- Flag detects a fault in a component, change and activate a spare
            used_spares(spare_check(used_spares)) <= '1';
        else 
            used_spares(spare_check(used_spares)) <= '0';
        end if;
end process;

end Behavioral;
