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
    signal used_spares : std_logic_vector(NUM_SPARES-1 downto 0) := (others => '0');
    signal zero_vector : std_logic_vector(NUM_SPARES-1 downto 0) := (others => '0');
begin

process(in1,in2,comp_out) 
    variable one : integer := 0;
    variable temp : integer := 0;
begin 
    if(comp_out = zero_vector) then 
        for i in 0 to NUM_MODULAR-1 loop
            out1(i) <= in1(i);
        end loop; 
    else 
        for j in 0 to NUM_MODULAR-1 loop
            if(comp_out(j) = '1') then 
                one := j;
            end if;
        end loop;
        
        -- Are there spares availlable?
        if(spare_check(comp_out) /= NUM_SPARES) then 
            out1(one) <= in2(one);
            temp := spare_check(used_spares);
            used_spares(temp) <= '1';
        end if;
    end if;  

end process;

end Behavioral;
