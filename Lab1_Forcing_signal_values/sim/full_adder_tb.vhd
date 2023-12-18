library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity full_adder_tb is
--  Port ( );
end full_adder_tb;

architecture Behavioral of full_adder_tb is
    signal x_i_s, y_i_s, c_i_s,s_o_s,c_o_s : std_logic;
begin
    
fa: entity work.full_adder
    port map(
        x_i => x_i_s,
        y_i => y_i_s,
        c_i => c_i_s,
        s_o => s_o_s,
        c_o => c_o_s
    );

--x_i_s <= '0','1' after 100ns, '0' after 200ns, '1' after 300ns, '0' after 400ns,'1'after 500ns;
--y_i_s <= '0','1' after 150ns, '1' after 300ns, '0' after 350ns, '1' after 500ns;
--c_i_s <= '0','1' after 250ns , '0' after 500ns;
process
begin 
x_i_s <= '0','1' after 400ns;
y_i_s <= '0','1' after 200ns, '0' after 400ns,'1' after 600ns,'0' after 800ns;
c_i_s <= '0','1' after 100ns , '0' after 200ns,'1' after 300ns , '0' after 400ns,'1' after 500ns , '0' after 600ns,'1' after 700ns ;
wait;
end process;
end Behavioral;
