----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2023 04:12:41 PM
-- Design Name: 
-- Module Name: Top_file - Behavioral
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

--Library blk_mem_gen_v8_4_4;
--use blk_mem_gen_v8_4_4.blk_mem_gen_v8_4_4;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_file is
    Port ( clk, rst, ld, blk_switch : in std_logic;
           switches : in std_logic_vector(5 downto 0);
           spi_clk, cs0_n, data_1, data_2 : out std_logic);
end Top_file;

architecture Behavioral of Top_file is
component SPI_Master is
    Port (clk, rst, ld: in std_logic;
          data_in : in std_logic_vector(11 downto 0);
          s_data0, spi_clk, cs0_n, ready : out std_logic);
end component;

component blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END component;
constant address_max : integer := 100000;
constant CLK_CNT_MAX : integer := 10000000/address_max;
signal data_in : std_logic_vector(11 downto 0);
signal ready : std_logic;
signal address : integer range 0 to address_max;
signal addr : std_logic_vector(16 downto 0);
signal block_out : std_logic_vector(11 downto 0);
signal clk_cnt : integer range 0 to clk_cnt_max;
signal load_spi : std_logic;
signal data_buf : std_logic;
signal ld_buf: std_logic;
signal indata_buf : std_logic_vector(11 downto 0);
begin
myBlockRAM: blk_mem_gen_0
PORT MAP(
    clka => clk,
    wea => "0",
    ena => '1',
    addra => addr,
    dina => x"000",
    douta => block_out);
addr <= std_logic_vector(to_unsigned(address, 17));

mySpiGuy: SPI_Master Port Map(clk => clk,
                              rst => rst,
                              ld => ld_buf,
                              data_in => data_in,
                              s_data0 => data_buf,
                              spi_clk => spi_clk,
                              ready => ready,
                              cs0_n => cs0_n);
data_1 <= data_buf;
data_2 <= data_buf;

process(clk, rst)
begin
if rst = '1' then
    address <= 0;
elsif rising_edge(clk) then
    if ready = '0' then
        if address < address_max then
            address <= address + 1;
        else 
            address <= 0;
        end if;
    end if;
end if; 
end process;

ld_buf <= ld when blk_switch = '0' else
            ready when blk_switch ='1';
            
data_in <= switches & "000000" when blk_switch = '0' else
            block_out;

end Behavioral;
