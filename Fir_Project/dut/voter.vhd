library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.variable_io_package.all;


entity voter is
      generic(FIR_MODULAR : natural := 3);
      Port (
            in1  : in IO_ARRAY(FIR_MODULAR-1 downto 0);
            out1 : out std_logic_vector(output_width-1 downto 0) 
       );
end voter;

architecture Behavioral of voter is
    type cnt_array is array (0 to FIR_MODULAR) of integer;
    signal cnt : cnt_array := (others => 0);
begin

-- Every input compares with each other creating an array
-- Highest value in array represents which an input that has most matches
process(in1)
    variable cnt_v : cnt_array := (others => 0);
begin
for i in 0 to FIR_MODULAR-1 loop
    for j in 0 to FIR_MODULAR-1 loop
        if(i /= j) then 
            if(in1(i) = in1(j)) then
                cnt_v(i) := cnt_v(i) + 1;   -- cnt_v should also be in else branch
            else 
                cnt_v(i) := cnt_v(i);    
            end if; 
        else 
            cnt_v(i) := cnt_v(i);       
        end if;
    end loop;
end loop;    
cnt <= cnt_v;
end process;

-- Finding an index of an array that has the highest value, that input should go to the 
-- output.
process(cnt) 
    variable max : integer := cnt(0);
    variable index : integer := 0;
begin
   for k in 1 to FIR_MODULAR loop
        if(cnt(k) > max) then 
            max := cnt(k);
            index := k;
        else 
            max := max;
            index := index;     
        end if;                
    end loop;
    out1 <= in1(index);
end process;

end Behavioral;
