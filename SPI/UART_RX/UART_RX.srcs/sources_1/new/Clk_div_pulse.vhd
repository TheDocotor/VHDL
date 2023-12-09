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
        clk_out, data : out std_logic  );
end Clk_div_pulse;

architecture Behavioral of Clk_div_pulse is
signal clk_out_s : std_logic;
signal cnt : unsigned( 11 downto 0);
constant full_cnt : unsigned( 11 downto 0) := TO_UNSIGNED(1000, 12);
constant zero : unsigned(11 downto 0) := "000000000000";

begin
process(clk,rst)
begin
    if rst = '0' then
       cnt <= full_cnt;
       clk_out_s <= '1';
    elsif rising_edge(clk) then
        if cnt > 500 then
            clk_out_s <= '0';
            cnt <= cnt -1;
        elsif cnt <= 500 and cnt > 0 then 
            clk_out_s <= '1';
            cnt <= cnt -1;
        else
            cnt <= Full_cnt;
            clk_out_s <= '0';
        end if;     
     end if;
end process;

data <= '1' when cnt = 750 else
        --'1' when cnt = 750 else
        '0';

clk_out <= clk_out_s;

end Behavioral;
