library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.txt_util.all;
use work.util_pkg.all;
use work.variable_io_package.all;

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is
    constant period : time := 20 ns;
    signal clk_i_s : std_logic;
    file input_test_vector : text open read_mode is "C:\Users\Pera\Desktop\Fir_Project\files\input.txt";
    file output_check_vector : text open read_mode is "C:\Users\Pera\Desktop\Fir_Project\files\expected.txt";
    file input_coef : text open read_mode is "C:\Users\Pera\Desktop\Fir_Project\files\coef.txt";
    signal data_i_s : std_logic_vector(input_width-1 downto 0);
    signal data_o_s : std_logic_vector(output_width-1 downto 0);
    signal coef_addr_i_s : std_logic_vector(log2c(FIR_ORDER)-1 downto 0);
    signal coef_i_s : std_logic_vector(input_width-1 downto 0);
    signal we_i_s : std_logic;
    
    signal start_check : std_logic := '0';
    
begin

uut_top_module:
    entity work.top(behavioral)
    port map(clk_i=>clk_i_s,
             we_i=>we_i_s,
             coef_i=>coef_i_s,
             coef_addr_i=>coef_addr_i_s,
             data_i=>data_i_s,
             data_o=>data_o_s);
             
clk_process:
    process
    begin
        clk_i_s <= '0';
        wait for period/2;
        clk_i_s <= '1';
        wait for period/2;
    end process;

    stim_process:
    process
        variable tv : line;
    begin
        --upis koeficijenata
        data_i_s <= (others=>'0');
        wait until falling_edge(clk_i_s);
        for i in 0 to FIR_ORDER loop
            we_i_s <= '1';
            coef_addr_i_s <= std_logic_vector(to_unsigned(i,log2c(FIR_ORDER)));
            readline(input_coef,tv);
            coef_i_s <= to_std_logic_vector(string(tv));
            wait until falling_edge(clk_i_s);
        end loop;
        --ulaz za filtriranje
        while not endfile(input_test_vector) loop
            readline(input_test_vector,tv);
            data_i_s <= to_std_logic_vector(string(tv));
            wait until falling_edge(clk_i_s);
            start_check <= '1';
        end loop;
        start_check <= '0';
        report "verification done!" severity failure;
    end process;
    
end Behavioral;
