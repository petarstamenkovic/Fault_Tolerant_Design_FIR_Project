library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.util_pkg.all;
use work.variable_io_package.all;
use IEEE.NUMERIC_STD.all;

entity top is
      Port (
            
--            -- AXI Stream Slave signals 
--            s_axis_tdata : in std_logic_vector(input_width-1 downto 0);
--            s_axis_tvalid : in std_logic;
--            s_axis_last : in std_logic;
--            s_axis_tready : out std_logic;
      
--            -- AXI Stream Master signals
--            m_axis_tdata : out std_logic_vector(output_width-1 downto 0);
--            m_axis_tvalid : out std_logic;
--            m_axi_tready : in std_logic;
--            m_axi_tlast : out std_logic;
            
            -- System interface signals 
            clk_i : in std_logic;
            we_i :  in std_logic;
            coef_addr_i : in std_logic_vector(log2c(FIR_ORDER+1)-1 downto 0);
            coef_i : in STD_LOGIC_VECTOR (input_width-1 downto 0);
            data_i : in STD_LOGIC_VECTOR(input_width-1 downto 0);
            data_o : out std_logic_vector(output_width-1 downto 0)
            );
end top;

architecture Behavioral of top is
    --type std_2d is array (FIR_ORDER-1 downto 0) of std_logic_vector(2*input_width-1 downto 0);
    signal mac_inter : MAC_OUT_ARRAY(FIR_ORDER downto 0) := (others => (others => '0'));
    --type coef_t is array (FIR_ORDER downto 0) of std_logic_vector(input_width-1 downto 0);
    signal b_s : coef_t(FIR_ORDER downto 0) := (others => (others => '0')); 
begin


process(clk_i)
begin
     if(rising_edge(clk_i))then
          if we_i = '1' then
             b_s(to_integer(unsigned(coef_addr_i))) <= coef_i;
          end if;
     end if;
end process;
    
first_section: 
    entity work.redundancy(behavioral)
    port map(
             clk_i=>clk_i,
             u_i=>data_i,
             b_i=>b_s(FIR_ORDER),
             sec_i=>(others=>'0'),
             sec_o=>mac_inter(0)
    );
             
redundancy_generation:
for i in 1 to FIR_ORDER generate
    fir_creation: 
    entity work.redundancy
    port map(
        clk_i => clk_i,
        u_i => data_i, 
        b_i => b_s(FIR_ORDER-i),
        sec_i => mac_inter(i-1),
        sec_o => mac_inter(i)
    );
end generate;

process(clk_i,mac_inter)
begin 
    if(rising_edge(clk_i)) then 
        data_o <= mac_inter(FIR_ORDER)(2*input_width-2 downto 2*input_width-output_width-1);
    end if;
end process;
    
end Behavioral;
