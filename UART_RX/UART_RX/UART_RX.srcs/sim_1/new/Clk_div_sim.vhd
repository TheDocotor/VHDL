----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2023 01:39:09 PM
-- Design Name: 
-- Module Name: Clk_div_sim - Behavioral
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

entity Clk_div_sim is
--  Port ( );
end Clk_div_sim;

architecture Behavioral of Clk_div_sim is
component Clk_div_pulse is
  Port (clk, rst : in std_logic;
        clk_out : out std_logic  );
end component;

signal clk_TB, rst_TB, clk_o_TB : std_logic := '0';

begin
clk_TB <= not clk_TB after 1ns; 
UUT: Clk_div_pulse Port map(clk => clk_TB,
                             rst => rst_TB,
                             clk_out => clk_o_TB);
process
begin 
    rst_TB <= '1';
    wait for 5 ns;
    rst_TB <= '0';
    wait for 6000 ns;
    
end process;
end Behavioral;
