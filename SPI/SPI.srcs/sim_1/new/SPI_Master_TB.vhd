----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/05/2023 04:01:31 PM
-- Design Name: 
-- Module Name: SPI_Master_TB - Behavioral
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

entity SPI_Master_TB is
--  Port ( );
end SPI_Master_TB;

architecture Behavioral of SPI_Master_TB is

component SPI_Master is
    Port (clk, rst, ld: in std_logic;
          data_in : in std_logic_vector(11 downto 0);
          s_data0, spi_clk, cs0_n : out std_logic);
end component;

signal clk_tb, rst_tb, ld_tb, s_data0_tb, spi_clk_tb, cs0_n_tb : std_logic := '0';
signal data_in_tb : std_logic_vector(11 downto 0);
signal rx_rec : std_logic_vector(15 downto 0);
signal ind : integer := 0;
type test_array_type is array (0 to 3) of std_logic_vector(15 downto 0);
signal test_record : test_array_type;

procedure SPI_RX(
    signal serial_in, spi_clk_in : in std_logic;
    signal p_out : out std_logic_vector(15 downto 0)) is
begin
    for ii in 15 downto 0 loop
        wait until falling_edge(spi_clk_in);
        p_out(ii) <= serial_in;
        wait for 1 ns;
    end loop;
end SPI_RX;

begin
clk_tb <= not clk_tb after 2ns;
UUT : SPI_Master port map(clk_tb, rst_tb, ld_tb, data_in_tb, s_data0_tb, spi_clk_tb, cs0_n_tb);

process
begin
    rst_tb <= '1';
    wait for 5 ns;
    rst_tb <= '0';
    data_in_tb <= "111111000000";
    ld_tb <= '1';
    wait for 3 ns;
    ld_tb <= '0';
    SPI_RX(s_data0_tb, spi_clk_tb, rx_rec);
    test_record(ind) <= rx_rec;
    wait for 100 ns;
    ind <= ind + 1;
    wait for 200 ns;
    data_in_tb <= "101010111111";
    ld_tb <= '1';
    wait for 3 ns;
    ld_tb <= '0';
    SPI_RX(s_data0_tb, spi_clk_tb, rx_rec);
    test_record(ind) <= rx_rec;
    wait for 100 ns;
    ind <= ind + 1;
    wait for 200 ns;
    data_in_tb <= "000000000000";
    ld_tb <= '1';
    wait for 3 ns;
    ld_tb <= '0';
    SPI_RX(s_data0_tb, spi_clk_tb, rx_rec);
    test_record(ind) <= rx_rec;
    wait for 100 ns;
    ind <= ind + 1;
    wait for 5 ns;
end process;

end Behavioral;
