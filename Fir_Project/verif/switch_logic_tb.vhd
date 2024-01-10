library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.variable_io_package.all;


entity switch_logic_tb is
generic(NUM_SPARES: integer := 3;
        NUM_MODULAR: integer := 4;
        output_data_width: integer := 24);
--  Port ( );
end switch_logic_tb;

architecture Behavioral of switch_logic_tb is
    signal comp_out_s : std_logic_vector(NUM_MODULAR-1 downto 0);
    signal in1_s : IO_ARRAY(NUM_MODULAR-1 downto 0);
    signal in2_s : IO_ARRAY(NUM_SPARES-1 downto 0);
    signal out1_s: IO_ARRAY(NUM_MODULAR-1 downto 0);
begin
switch_logic_instance:
entity work.switch_logic(behavioral)
generic map(
        NUM_SPARES => NUM_SPARES,
        NUM_MODULAR => NUM_MODULAR,
        output_data_width => output_data_width
)
port map(
        in1 => in1_s,
        in2 => in2_s,
        comp_out => comp_out_s,
        out1 => out1_s
);

stim_gen:
process begin
    in1_s(0) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(5,24)) after 100ns, std_logic_vector(to_unsigned(5,24)) after 200ns, std_logic_vector(to_unsigned(8,24)) after 300ns;
    in1_s(1) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(4,24)) after 100ns, std_logic_vector(to_unsigned(4,24)) after 200ns, std_logic_vector(to_unsigned(8,24)) after 300ns;
    in1_s(2) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(5,24)) after 100ns, std_logic_vector(to_unsigned(5,24)) after 200ns, std_logic_vector(to_unsigned(6,24)) after 300ns;
    in1_s(3) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(5,24)) after 100ns, std_logic_vector(to_unsigned(5,24)) after 200ns, std_logic_vector(to_unsigned(8,24)) after 300ns;
    in2_s(0) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(5,24)) after 100ns, std_logic_vector(to_unsigned(5,24)) after 200ns, std_logic_vector(to_unsigned(1,24)) after 300ns;
    in2_s(1) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(1,24)) after 100ns, std_logic_vector(to_unsigned(1,24)) after 200ns, std_logic_vector(to_unsigned(8,24)) after 300ns;
    in2_s(2) <= std_logic_vector(to_unsigned(5,24)),std_logic_vector(to_unsigned(1,24)) after 100ns, std_logic_vector(to_unsigned(1,24)) after 200ns, std_logic_vector(to_unsigned(1,24)) after 300ns;
    comp_out_s <= "0000", "0010" after 100ns, "0000" after 200ns, "0100" after 300ns;
    wait;
end process;

end Behavioral;
