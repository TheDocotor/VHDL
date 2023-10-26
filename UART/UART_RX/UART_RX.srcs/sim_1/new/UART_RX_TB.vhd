----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2023 02:09:29 PM
-- Design Name: 
-- Module Name: UART_RX_TB - Behavioral
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

entity UART_RX_TB is
--  Port ( );
end UART_RX_TB;

architecture Behavioral of UART_RX_TB is
constant BIT_PERIOD : time := 8680ns;
procedure TX_BITS(
    data : in std_logic_vector(7 downto 0);
    signal tx_serial : out std_logic) is
    begin
        tx_serial <= '0';
        wait for BIT_PERIOD;--is a constant need to calc.
        
        for ii in 0 to 7 loop
            tx_serial <= data(ii);
            wait for BIT_PERIOD;
        end loop;
        
        tx_serial <= '1';
        wait for BIT_PERIOD;
        
    end TX_BITS;
component UART_RX is
    Port (clk, reset, sdata : in std_logic;
          pdata : out std_logic_vector(7 downto 0);
          ready : out std_logic);
end component;

signal clk_TB, reset_TB, sdata_TB, ready_TB : std_logic := '0';
signal pdata_tb : std_logic_vector(7 downto 0);


begin
Clk_tb <= not Clk_TB after 5 ns;
UUT : UART_RX port map(clk_TB, reset_TB, sdata_TB, pdata_TB, ready_TB);
process
begin

reset_TB  <= '1';
wait for 10 ns;
reset_TB <= '0';
wait for 10 ns;
wait until rising_edge(clk_tb);
TX_BITS(X"21", sdata_tb);
wait for 10 ns;
wait until rising_edge(clk_tb);
TX_BITS(X"56", sdata_tb);
wait;

end process;
end Behavioral;
