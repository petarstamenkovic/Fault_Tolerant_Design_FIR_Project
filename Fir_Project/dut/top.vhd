library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.util_pkg.all;
use work.variable_io_package.all;

entity top is
      Port (
            clk_i : in std_logic;
            we_i :  in std_logic;
            coef_addr_i : in std_logic_vector(log2c(FIR_ORDER+1)-1 downto 0);
            coef_i : in STD_LOGIC_VECTOR (input_width-1 downto 0);
            data_i : in STD_LOGIC_VECTOR(input_width-1 downto 0);
            --data_i : in DATA_IN (FIR_MODULAR-1 downto 0);
            data_o : out std_logic_vector(output_width-1 downto 0)
            );
end top;

architecture Behavioral of top is
    signal fir_out : IO_ARRAY(FIR_MODULAR-1 downto 0);
    signal switch_in_original : IO_ARRAY(NUM_MODULAR-1 downto 0);
    signal switch_in_spares : IO_ARRAY(NUM_SPARES-1 downto 0);
    signal switch_out : IO_ARRAY(NUM_MODULAR-1 downto 0);
    signal comp_out_t : std_logic_vector(NUM_MODULAR-1 downto 0); 
    signal data_out : std_logic_vector(output_width-1 downto 0);
begin

fir_generation : 
for i in 0 to FIR_MODULAR-1 generate
    generation1:
    entity work.fir_param
    port map(
            clk_i => clk_i,
            we_i => we_i,
            coef_addr_i => coef_addr_i,
            coef_i => coef_i,
            data_i => data_i,
            --data_i => data_i(i),
            data_o => fir_out(i)
    );
end generate;

redundancy_voters_generation_originals:
for j in 0 to NUM_MODULAR-1 generate
    generation2:
    entity work.voter
    generic map(FIR_MODULAR=>FIR_MODULAR)
    port map(
        in1 => fir_out,
        out1 => switch_in_original(j)
    );
end generate;

redundancy_voters_generation_spares:
for s in 0 to NUM_SPARES-1 generate
    generation3:
    entity work.voter
    generic map(FIR_MODULAR=>FIR_MODULAR)
    port map(
        in1 => fir_out,
        out1 => switch_in_spares(s)
    );
end generate;

swtich_logic: 
entity work.switch_logic
    port map(
           in1 => switch_in_original,
           in2 => switch_in_spares,
           comp_out => comp_out_t,
           out1 => switch_out 
    );
    
comparator:
entity work.comparator
    port map(
            in1 => switch_out,
            vot_out => data_out,
            comp_out => comp_out_t
    );   
    
main_voter: 
entity work.voter
    generic map(FIR_MODULAR=>NUM_MODULAR)
    port map(
            in1 => switch_out,
            out1 => data_out
    );     
    
    data_o <= data_out;
    
end Behavioral;
