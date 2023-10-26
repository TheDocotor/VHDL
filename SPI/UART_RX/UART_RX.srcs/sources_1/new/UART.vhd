----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2023 03:12:37 PM
-- Design Name: 
-- Module Name: UART - Behavioral
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

entity UART is
    Port (Cin, rst, clk : in std_logic;
         tdata, busy : out std_logic;
         pdata : out std_logic_vector(7 downto 0));
end UART;

architecture Behavioral of UART is
component UART_RX is
    Port (clk, reset, sdata : in std_logic;
          pdata : out std_logic_vector(7 downto 0);
          ready : out std_logic);
end component;

component UART_TX is
    Port (clk, rst, ld : in std_logic;
          pdata : in std_logic_vector(7 downto 0);
          busy, sdata: out std_logic );
end component;

signal pdata_i : std_logic_vector(7 downto 0);
signal ready : std_logic;
begin
RX : UART_RX port map (clk => clk,
                       reset => rst,
                       sdata => Cin,
                       pdata => pdata_i,
                       ready => ready);
                       
TX : UART_TX port map (clk => clk,
                       rst => rst,
                       ld => ready,
                       pdata => pdata_i,
                       busy => busy,
                       sdata => tdata);
pdata <= pdata_i;
end Behavioral;
