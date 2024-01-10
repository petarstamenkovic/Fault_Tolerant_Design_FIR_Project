library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
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
    
    -- Helping out signal
    signal out_help : IO_ARRAY(NUM_MODULAR-1 downto 0);
    signal cnt: std_logic_vector(2 downto 0) := "000" ; -- Adapt this later on
begin

process(comp_out,in1,in2)
begin
    if(comp_out /= zero_vector) then
        for i in 0 to NUM_MODULAR-1 loop
            if(comp_out(i) = '1') then 
                used_modules(i) <= '1';
                cnt <= std_logic_vector(unsigned(cnt) + to_unsigned(1,3));
                out_help(i) <= in2(to_integer(unsigned(cnt)));
                out1(i) <= out_help(i);
            else 
                if(used_modules(i) = '0') then 
                    out_help(i) <= in1(i);
                    out1(i) <= out_help(i);
                else 
                    out_help(i) <= in2(to_integer(unsigned(cnt)));
                    out1(i) <= out_help(i);
                end if;
            end if;          
        end loop;
    else
        if(used_modules /= zero_vector) then
            for i in 0 to NUM_MODULAR-1 loop
               out1(i) <= out_help(i);
            end loop;
        else 
             for i in 0 to NUM_MODULAR-1 loop
                out1(i) <= in1(i);
             end loop;
        end if;    
    end if;    
end process;


--process(in1,in2,comp_out) 
--begin  
--        if(used_modules /= zero_vector) then 
--            for j in 0 to NUM_MODULAR-1 loop
--                if(used_modules(j) = '1') then 
--                    out_help(j) <= in2(spare_check(used_spares));
--                else 
--                    out_help(j) <= in1(j);
--                end if; 
--            end loop;
--        else  -- Scenario in which all modules are availlable                   
--            for i in 0 to NUM_MODULAR-1 loop
--              out_help(i) <= in1(i);
--            end loop;     
--        end if;  
        
--        for i in 0 to NUM_MODULAR-1 loop
--            out1(i) <= out_help(i);
--        end loop;
        
--end process;

--update_component_availlability :           
--process(comp_out)      
--begin
--        if(comp_out /= zero_vector) then
--            for j in 0 to NUM_MODULAR-1 loop
--                if(comp_out(j) = '1') then 
--                    if(used_modules(j) = '1') then 
--                        used_modules(j) <= '1';
--                    else 
--                        used_modules(j) <= '1';
--                    end if; 
--                else 
--                    if(used_modules(j) = '1') then
--                        used_modules(j) <= '1';
--                    else     
--                        used_modules(j) <= '0';    
--                    end if;     
--                end if;
--            end loop;
--            used_spares(spare_check(used_spares)) <= '1';                          

--         else  -- Comp out is 0 which means no errors, dont change used_modules
--            used_modules <= used_modules;
--            used_spares <= used_spares;
--         end if;   
--end process;

--supply_to_out : 
--process(out_help)
--begin 
--   for i in 0 to NUM_MODULAR-1 loop
--        out1(i) <= out_help(i);
--    end loop;
--end process;
end Behavioral;
