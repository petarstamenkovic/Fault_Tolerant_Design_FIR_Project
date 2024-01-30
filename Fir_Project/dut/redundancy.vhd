library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.variable_io_package.all;

entity redundancy is
      Port (
           clk_i: in std_logic;
           u_i : in STD_LOGIC_VECTOR (input_width-1 downto 0);
           b_i : in STD_LOGIC_VECTOR (input_width-1 downto 0);
           sec_i : in STD_LOGIC_VECTOR (2*input_width-1 downto 0);
           sec_o : out STD_LOGIC_VECTOR (2*input_width-1 downto 0)
       );
end redundancy;

architecture Behavioral of redundancy is
    signal mac_out : MAC_OUT_ARRAY(MAC_MODULAR-1 downto 0);
    signal switch_in_original : MAC_OUT_ARRAY(NUM_MODULAR-1 downto 0);
    signal switch_in_spares: MAC_OUT_ARRAY(NUM_SPARES-1 downto 0);
    signal comp_out_t : std_logic_vector(NUM_MODULAR-1 downto 0);
    signal switch_out : MAC_OUT_ARRAY(NUM_MODULAR-1 downto 0);
    signal data_out : std_logic_vector(2*input_width-1 downto 0);
    
    ---- Protecting the redundant components ----
    attribute dont_touch : string;
    attribute dont_touch of mac_out : signal is "true";
    attribute dont_touch of switch_in_original : signal is "true";
    attribute dont_touch of switch_in_spares : signal is "true";
    attribute dont_touch of switch_out : signal is "true";
begin

mac_instances : 
for i in 0 to MAC_MODULAR-1 generate 
    generation1:
    entity work.mac
    port map(
        clk_i => clk_i,
        u_i => u_i,
        b_i => b_i,
        sec_i => sec_i,
        sec_o => mac_out(i)
    );
end generate;

redundancy_voters_generation_originals:
for j in 0 to NUM_MODULAR-1 generate
    generation2:
    entity work.voter
    generic map(MAC_MODULAR=>MAC_MODULAR)
    port map(
        in1 => mac_out,
        out1 => switch_in_original(j)
    );
end generate;

redundancy_voters_generation_spares:
for s in 0 to NUM_SPARES-1 generate
    generation3:
    entity work.voter
    generic map(MAC_MODULAR=>MAC_MODULAR)
    port map(
        in1 => mac_out,
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
    generic map(MAC_MODULAR=>NUM_MODULAR)
    port map(
            in1 => switch_out,
            out1 => data_out
    ); 
    
forwarding_to_out: 
process(clk_i)
begin    
    if(rising_edge(clk_i)) then 
        sec_o <= data_out;
    end if;    
end process;
end Behavioral;
