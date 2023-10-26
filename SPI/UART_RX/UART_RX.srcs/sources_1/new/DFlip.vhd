----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2023 12:48:35 PM
-- Design Name: 
-- Module Name: DFlip - Behavioral
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

entity DFlip is
  Port (D, clk, en : in std_logic;
        Q : out std_logic );
end DFlip;

architecture Behavioral of DFlip is

Signal Q_s : std_logic;

begin
process(clk)
begin
    if rising_edge(clk) then
        if en = '1' then 
            Q_s <= D;
        else 
            Q_s <= Q_s;
        end if;
    end if;      
end process;
Q <= Q_s;

end Behavioral;
