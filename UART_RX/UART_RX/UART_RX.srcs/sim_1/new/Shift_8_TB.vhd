----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2023 02:50:24 PM
-- Design Name: 
-- Module Name: Shift_8_TB - Behavioral
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

entity Shift_8_TB is
--  Port ( );
end Shift_8_TB;

architecture Behavioral of Shift_8_TB is

component Shift_8 is
  Port (shift, d_in, clk : in std_logic;
        d_out : out std_logic_vector(7 downto 0));
end component;

signal shift_TB, d_in_TB, clk_TB : std_logic := '0';
signal d_out_TB : std_logic_vector(7 downto 0) := "00000000";

begin
clk_TB <= not clk_TB after 5ns;
UUT : Shift_8 port map(shift => shift_TB,
                        d_in => d_in_TB,
                        clk => clk_TB,
                        d_out => d_out_TB);

process
begin
    shift_TB <= '1';
    d_in_TB <= '1';
    wait for 5ns;
    d_in_TB <= '0';
    wait for 5ns;
    d_in_TB <= '0';
    wait for 5ns;
    d_in_TB <= '1';
    wait for 5ns;
    d_in_TB <= '0';
    wait for 5ns;
    d_in_TB <= '1';
    wait for 5ns;
    d_in_TB <= '1';
    wait for 5ns;
    d_in_TB <= '0';
    wait;
end process;
end Behavioral;
