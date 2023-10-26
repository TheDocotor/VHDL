----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date: 10/05/2023 02:57:45 PM
-- Design Name: 
-- Module Name: SPI_Master - Behavioral
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

entity SPI_Master is
    Port (clk, rst, ld: in std_logic;
          data_in : in std_logic_vector(11 downto 0);
          s_data0, spi_clk, cs0_n, ready : out std_logic);
end SPI_Master;

architecture Behavioral of SPI_Master is
type STATE_TYPE is (IDLE, TX1, TX2);
signal CS : STATE_TYPE;
signal cnt, b_cnt : integer;
signal o_data : std_logic_vector(15 downto 0);

begin
process(clk, rst)
begin
if rst = '1' then
    CS <= idle;
    cs0_n <= '1';
    spi_clk <= '1';
    b_cnt <= 15;
    cnt <= 59;
    ready <= '1';
elsif rising_edge(clk) then
    case CS is
        when IDLE =>
            ready <= '1';
            cnt <= 59;
            b_cnt <= 15;
            spi_clk <= '1';
            cs0_n <= '1';
            if ld = '1' then
                CS <= TX1;
                cs0_n <= '0';
                o_data <= "0000" & data_in(11 downto 6)& "000000";
            else
                cs <= cs;
            end if;
        when TX1 =>
        ready <= '0';
        s_data0 <= o_data(b_cnt);
        spi_clk <= '1';
        cs0_n <= '0';
            if cnt > 0 then
                CS <= CS;
                cnt <= cnt-1;
            else
                CS <= TX2;
                cnt <= 59;
                b_cnt <= b_cnt - 1;
            end if;
        when TX2 =>
        ready <= '0';
        spi_clk <= '0';
        cs0_n <= '0';
            if cnt > 0 then
                CS <= CS;
                cnt <= cnt -1;
            else
                if b_cnt >= 0 then
                    CS <= TX1;
                    cnt <= 59;
                else 
                    CS <= idle;
                end if;
            end if;
        when others =>
            CS <= CS;    
    end case;
end if;
end process;

end Behavioral;
