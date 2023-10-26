----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2023 12:56:18 PM
-- Design Name: 
-- Module Name: Shift_8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift_8 is
  Port (shift, d_in, clk : in std_logic;
        d_out : out std_logic_vector(7 downto 0));
end Shift_8;

architecture Behavioral of Shift_8 is
component DFlip is
  Port (D, clk, en : in std_logic;
        Q : out std_logic );
end component;

Signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : std_logic;

begin
D0 : DFlip Port map(D => d_in,
                    clk => clk,
                    en => shift, 
                    Q => Q0);
D1 : DFlip Port map(D => Q0,
                    clk => clk,
                    en => shift, 
                    Q => Q1);
D2 : DFlip Port map(D => Q1,
                    clk => clk,
                    en => shift, 
                    Q => Q2);
D3 : DFlip Port map(D => Q2,
                    clk => clk,
                    en => shift, 
                    Q => Q3);
D4 : DFlip Port map(D => Q3,
                    clk => clk,
                    en => shift, 
                    Q => Q4);
D5 : DFlip Port map(D => Q4,
                    clk => clk,
                    en => shift, 
                    Q => Q5);
D6 : DFlip Port map(D => Q5,
                     clk => clk,
                    en => shift, 
                    Q => Q6);
D7 : DFlip Port map(D => Q6,
                    clk => clk,
                    en => shift, 
                    Q => Q7);                                                                                                                        
d_out(0) <= Q7;
d_out(1) <= Q6;
d_out(2) <= Q5;
d_out(3) <= Q4;
d_out(4) <= Q3;
d_out(5) <= Q2;
d_out(6) <= Q1;
d_out(7) <= Q0;


end Behavioral;
