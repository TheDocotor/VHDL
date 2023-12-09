----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 03:46:02 PM
-- Design Name: 
-- Module Name: Top_TB - Behavioral
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

entity Top_TB is
--  Port ( );
end Top_TB;

architecture Behavioral of Top_TB is

component Top_level is
  Port (ld, clk, rst, rd_wr: in std_logic;
        ready, s_clk : out std_logic;
        pdata : out std_logic_vector(15 downto 0);
        sdata_io : inout std_logic);
end component;

signal ld_tb, rst_tb, rd_wr_tb, ready_tb, s_clk_tb : std_logic := '0';
signal sdata_io_tb : std_logic := 'Z';
signal clk_tb : std_logic := '0';
signal pdata_tb : std_logic_vector(15 downto 0);

begin

UUT : Top_level port map(ld_tb, clk_tb, rst_tb, rd_wr_tb, ready_tb, s_clk_tb, pdata_tb, sdata_io_tb);

clk_tb <= not clk_tb after 2ns;

process
begin
    rst_tb <= '1';
    rd_wr_tb <= '1';
    wait for 5 ns;
    rst_tb <= '0';
    wait for 5ns;
    ld_tb <= '1';
    sdata_io_tb <= 'Z';
    wait;
    
end process;

end Behavioral;
