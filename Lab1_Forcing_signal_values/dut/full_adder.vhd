library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
     Port (
            x_i : in std_logic;
            y_i : in std_logic;
            c_i : in std_logic;
            c_o : out std_logic;
            s_o : out std_logic        
      );
end full_adder;

architecture Behavioral of full_adder is
    signal w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16 : std_logic;
begin

--adder : process(x_i,y_i,c_i)
--begin
    w1 <= x_i;
    w2 <= y_i;
    w3 <= c_i;
    w4 <= w1;
    w5 <= w2;
    w6 <= w4 xor w5;
    w7 <= w1;
    w8 <= w2;
    w9 <= w6;
    w10 <= w3;
    w11 <= w7 and w8;
    w12 <= w9 and w10;
    w13 <= w6;
    w14 <= w3;
    w15 <= w11 or w12;
    w16 <= w13 xor w14; 
    
    c_o <= w15;
    s_o <= w16;
--end process;

end Behavioral;
