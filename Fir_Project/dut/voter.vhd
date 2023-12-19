library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.variable_io_package.all;

entity voter is
      generic(NUM_INPUT : integer := 3;           -- This is a parameter N (N modular redundance)
              output_data_width : integer := 24); -- This is a paramter for a width of FIR output
      Port (
            in1  : in IO_ARRAY(NUM_INPUT-1 downto 0);
            out1 : out std_logic_vector(output_data_width-1 downto 0) 
       );
end voter;

architecture Behavioral of voter is
    --signal temp : std_logic_vector(output_data_width-1 downto 0);
    type cnt_array is array (0 to NUM_INPUT) of integer;
    signal cnt : cnt_array;
    signal flag: std_logic;
begin

-- Every input compares with each other creating an array
-- Highest value in array represents which an input that has most matches
process(in1,cnt)
    variable cnt_v : cnt_array := (others => 0);
begin
for i in 0 to NUM_INPUT-1 loop
    for j in 0 to NUM_INPUT-1 loop
        if(i /= j) then 
            if(in1(i) = in1(j)) then
                cnt_v(i) := cnt_v(i) + 1;
            end if;    
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
    variable k : integer := 0;
begin
   for k in 1 to NUM_INPUT loop
        if(cnt(k) > max) then 
            max := cnt(k);
            index := k;
         end if;                
    end loop;
    out1 <= in1(k);
end process;


--process(in1) begin
--for i in 0 to output_data_width-1 loop
--    for j in 0 to NUM_INPUT-1 loop 
--        for s in j+1 to NUM_INPUT loop  
--            temp <= in1(j)(i) and in1(s)(i);
--            out1(i) <=  or temp;
--        end loop;  
--    end loop;
--end loop;    
--end process;

end Behavioral;
