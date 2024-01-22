library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
use work.util_pkg;

package variable_io_package is 
    constant output_width : natural := 24;  -- Output signal width
    constant input_width : natural := 24;   -- Input signal width
    constant NUM_SPARES : natural := 3;     -- Number of spare voters
    constant NUM_MODULAR : natural := 4;    -- Number of original voters
    constant FIR_MODULAR : natural := 3;    -- Number of fir modules(fir redundancy)
    constant FIR_ORDER : natural := 5;      -- Order of a single fir module
    type IO_ARRAY is array (integer range <>) of std_logic_vector(output_width-1 downto 0);
    --type COMP_OUT_TYPE is array (integer range <>) of std_logic;
    type DATA_IN is array(integer range <>) of std_logic_vector(input_width-1 downto 0);
end variable_io_package;

