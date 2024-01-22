library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.util_pkg.all;
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
    signal zero_vector : std_logic_vector(NUM_MODULAR-1 downto 0) := (others => '0');
    signal sel_zero : std_logic_vector(log2c(NUM_SPARES+1)-1 downto 0):= (others => '0');
    type SEL_TYPE is array(NUM_MODULAR-1 downto 0) of std_logic_vector(log2c(NUM_SPARES+1)-1 downto 0);
    signal sel : SEL_TYPE := (others => (others => '0'));
    signal fail : std_logic_vector(log2c(NUM_SPARES+1)-1 downto 0):= (others => '0');
begin

mux_generation:
process(comp_out,in1,in2,sel_zero,sel)
begin       
    out1 <= (others => (others => '0')); 
    for i in 0 to NUM_MODULAR-1 loop
           if(sel(i) = sel_zero) then 
                out1(i) <= in1(i);
           else     
                for j in 1 to NUM_SPARES loop
                if(sel(i) = std_logic_vector(to_unsigned(j,2))) then
                    out1(i) <= in2(j-1);
                    --exit;
                end if;
                end loop;
           end if;     
    end loop;    
end process;

failing_mechanism:
process(comp_out)
    variable fail : integer := 0; 
begin 
   -- sel <= (others => (others => '0'));
    for k in 0 to NUM_MODULAR-1 loop
    --sel(k) <= sel(k); 
        if(comp_out(k) = '1') then
            fail := fail + 1;
            --fail <= std_logic_vector(unsigned(fail) + TO_UNSIGNED(1,log2c(NUM_SPARES+1)));
            --sel(k) <= fail;
            sel(k) <= std_logic_vector(to_unsigned(fail,log2c(NUM_SPARES+1)));
            --exit;   
        else 
            sel(k) <= sel(k);    
        end if;    
    end loop;

end process;

end Behavioral;
