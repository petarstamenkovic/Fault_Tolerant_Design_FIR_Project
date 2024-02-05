library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.variable_io_package.all;
use work.util_pkg.all;


entity switch_logic_tb is
--generic(NUM_SPARES: integer := 3;
--        NUM_MODULAR: integer := 4;
--        output_data_width: integer := 24);
--  Port ( );
end switch_logic_tb;

architecture Behavioral of switch_logic_tb is
    constant period : time := 20 ns;
    signal comp_out_s : std_logic_vector(NUM_MODULAR-1 downto 0);
    signal in1_s : MAC_OUT_ARRAY(NUM_MODULAR-1 downto 0);
    signal in2_s : MAC_OUT_ARRAY(NUM_SPARES-1 downto 0);
    signal out1_s: MAC_OUT_ARRAY(NUM_MODULAR-1 downto 0);
    signal clk_s : std_logic;
begin
switch_logic_instance:
entity work.switch_logic(behavioral)
--generic map(
--        NUM_SPARES => NUM_SPARES,
--        NUM_MODULAR => NUM_MODULAR,
--        output_data_width => output_data_width
--)
port map(
        clk => clk_s,
        in1 => in1_s,
        in2 => in2_s,
        comp_out => comp_out_s,
        out1 => out1_s
);

clk_process:
process
begin
    clk_s <= '0';
    wait for period/2;
    clk_s <= '1';
    wait for period/2;
end process;

stim_gen:
process begin
    in1_s(0) <= std_logic_vector(to_unsigned(1,48)),std_logic_vector(to_unsigned(1,48)) after 100ns, std_logic_vector(to_unsigned(1,48)) after 200ns, std_logic_vector(to_unsigned(1,48)) after 300ns, std_logic_vector(to_unsigned(1,48)) after 400ns, std_logic_vector(to_unsigned(1,48)) after 500ns;
    in1_s(1) <= std_logic_vector(to_unsigned(2,48)),std_logic_vector(to_unsigned(2,48)) after 100ns, std_logic_vector(to_unsigned(2,48)) after 200ns, std_logic_vector(to_unsigned(2,48)) after 300ns, std_logic_vector(to_unsigned(2,48)) after 400ns, std_logic_vector(to_unsigned(2,48)) after 500ns;
    in1_s(2) <= std_logic_vector(to_unsigned(3,48)),std_logic_vector(to_unsigned(3,48)) after 100ns, std_logic_vector(to_unsigned(3,48)) after 200ns, std_logic_vector(to_unsigned(3,48)) after 300ns, std_logic_vector(to_unsigned(3,48)) after 400ns, std_logic_vector(to_unsigned(3,48)) after 500ns;
    in1_s(3) <= std_logic_vector(to_unsigned(4,48)),std_logic_vector(to_unsigned(4,48)) after 100ns, std_logic_vector(to_unsigned(4,48)) after 200ns, std_logic_vector(to_unsigned(4,48)) after 300ns, std_logic_vector(to_unsigned(4,48)) after 400ns, std_logic_vector(to_unsigned(4,48)) after 500ns;
    in2_s(0) <= std_logic_vector(to_unsigned(5,48)),std_logic_vector(to_unsigned(5,48)) after 100ns, std_logic_vector(to_unsigned(5,48)) after 200ns, std_logic_vector(to_unsigned(5,48)) after 300ns, std_logic_vector(to_unsigned(5,48)) after 400ns, std_logic_vector(to_unsigned(5,48)) after 500ns;
    in2_s(1) <= std_logic_vector(to_unsigned(6,48)),std_logic_vector(to_unsigned(6,48)) after 100ns, std_logic_vector(to_unsigned(6,48)) after 200ns, std_logic_vector(to_unsigned(6,48)) after 300ns, std_logic_vector(to_unsigned(6,48)) after 400ns, std_logic_vector(to_unsigned(6,48)) after 500ns;
    in2_s(2) <= std_logic_vector(to_unsigned(7,48)),std_logic_vector(to_unsigned(7,48)) after 100ns, std_logic_vector(to_unsigned(7,48)) after 200ns, std_logic_vector(to_unsigned(7,48)) after 300ns, std_logic_vector(to_unsigned(7,48)) after 400ns, std_logic_vector(to_unsigned(7,48)) after 500ns;
    comp_out_s <= "0000", "0010" after 100ns, "0000" after 110ns, "0100" after 300ns, "0000" after 310ns , "0010" after 500ns,"0000" after 510ns, "1000" after 600ns , "0000" after 610ns;
    wait;
end process;

end Behavioral;
