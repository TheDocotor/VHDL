----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2023 10:51:06 AM
-- Design Name: 
-- Module Name: Controller - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
    Port (pdata_in : in std_logic_vector(7 downto 0);
        busy :in std_logic;
        cont, read, mem, load : out std_logic;
        led : out std_logic_vector(0 downto 2) );
end Controller;

architecture Behavioral of Controller is


type STATE_TYPE is (idle, exe);

signal CS : STATE_TYPE;
signal Q1, Q2 : std_logic;

begin

--Debouncer
--process(clk)
--begin
--if rising_edge(clk)
--    Q1 <= btn;
--end if;
--end process;
--process(clk)
--begin
--if rising_edge(clk)
--    Q2 <= Q1;
--end if;
--end process;

--Controller
process(busy)
begin
if falling_edge(busy) then
    cont <= pdata_in(3);
    read <= pdata_in(5);
    mem <= pdata_in(4);
    load <= '1';
    led <= pdata_in(2 downto 0);
else
    load <= '0';
    cont <= pdata_in(3);
    read <= pdata_in(5);
    mem <= pdata_in(4);
    led <= pdata_in(2 downto 0);
end if;
end process;


end Behavioral;
