----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2023 12:41:02 PM
-- Design Name: 
-- Module Name: Final_top - Behavioral
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

entity Final_top is
  Port (sdata : in std_logic;
        clk, rst : in std_logic;
        switches : in std_logic_vector(5 downto 0);
        sdata_io : inout std_logic;
        led_out : out std_logic_vector(5 downto 0);
        sdata_o, spi_clk, cs0_n, data_1, data_2, I_clk : out std_logic);
end Final_top;

architecture Behavioral of Final_top is

--Components
--UART
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
--SPI
component Top_file is
    Port ( clk, rst, ld, blk_switch : in std_logic;
           switches : in std_logic_vector(5 downto 0);
           spi_clk, cs0_n, data_1, data_2 : out std_logic);
end component;
--I2C
component Top_level is
  Port (ld, clk, rst, rd_wr: in std_logic;
        ready, s_clk : out std_logic;
        pdata : out std_logic_vector(15 downto 0);
        sdata_io : inout std_logic);
end component;
--Controller
component Controller is
    Port (pdata_in : in std_logic_vector(7 downto 0);
        busy :in std_logic;
        cont, read, mem, load : out std_logic;
        led : out std_logic_vector(0 downto 2) );
end component;
        
--Signals
signal pdata_os : std_logic_vector(15 downto 0);
signal pdata_is, pdata_buff : std_logic_vector(7 downto 0);
signal rdy_s, bsy_s, load, mem, read, dummy, rdy_I : std_logic;
signal led : std_logic_vector(2 downto 0);
--Non existant
signal cont : std_logic;


begin

UART_RX0 : UART_RX port map(clk, rst, sdata, pdata_is, rdy_s);
UART_TX0 : UART_TX port map(clk, rst, rdy_s, pdata_buff, bsy_s, sdata_o);
SPI : Top_file port map(clk, rst, load, mem, switches, spi_clk, cs0_n, data_1, data_2);
I2C : Top_level port map(load, clk, rst, read, rdy_I, I_clk, pdata_os, sdata_io);
Controller0 : Controller port map(pdata_is, bsy_s, cont, read, mem, load, led);

pdata_buff <= "01" & pdata_os(13 downto 8);

led_out <= "111000" when led = "000" else 
           "000111" when led = "010" else
           "101010" when led = "001" else
           pdata_buff;
end Behavioral;
