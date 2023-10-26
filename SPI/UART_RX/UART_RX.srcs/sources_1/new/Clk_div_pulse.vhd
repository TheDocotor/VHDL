----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2023 11:19:54 AM
-- Design Name: 
-- Module Name: Clk_div_pulse - Behavioral
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

entity Clk_div_pulse is
  Port (clk, rst : in std_logic;
        clk_out : out std_logic  );
end Clk_div_pulse;

architecture Behavioral of Clk_div_pulse is
signal cnt : unsigned( 11 downto 0);
constant full_cnt : unsigned( 11 downto 0) := TO_UNSIGNED(868, 12);
constant zero : unsigned(11 downto 0) := "000000000000";

begin
process(clk,rst)
begin
    clk_out <= '0';
    if rst = '1' then
       cnt <= full_cnt/2-1;
       clk_out <= '0';
    elsif rising_edge(clk) then
        clk_out <= '0';
        if cnt = zero then 
            clk_out <= '1';
            cnt <= full_cnt-1;
        else
            cnt <= cnt - 1;
        end if;     
     end if;
end process;
end Behavioral;
