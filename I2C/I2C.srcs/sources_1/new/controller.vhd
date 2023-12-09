----------------------------------------------------------------------------------
-- Company: Weber State
-- Engineer: Ryan Enslow, Garrett Nadauld
-- 
-- Create Date: 11/16/2023 01:40:24 PM
-- Design Name: I2C
-- Module Name: controller - Behavioral
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

entity controller is
    Port (ld, clk, rst, rd_wr, sclk, dat_en : in std_logic;
        clk_en, ready : out std_logic;
        pdata : out std_logic_vector(15 downto 0);
        sdata_io : inout std_logic);
end controller;

architecture Behavioral of controller is
type STATE_TYPE is (IDLE, START, ADDRESS, A_AK, R_DATA, SEND_DATA);
signal CS: STATE_TYPE;
signal cnt, data_cnt : integer;
signal rx_buff, pdata_s: std_logic_vector(15 downto 0);
constant tx_buff: std_logic_vector(26 downto 0):="010100011111111110111111110";
signal flag, s_din, sd_s : std_logic;

begin
process(clk, rst)
begin
if rst = '1' then
    CS <= idle;
    clk_en <= '0';
    ready <= '1';
    sd_s <= '1';
    cnt <= 26;
elsif rising_edge(clk) then
    pdata_s <= pdata_s;
   -- if dat_en = '1' and sclk = '0' then
    case CS is 
        when IDLE =>
            pdata_s <= pdata_s;
            ready <='1';
            clk_en <= '0';
            flag <= '0';
            cnt <= 26;
            data_cnt <= 15;
            sd_s <= '1';
            if ld = '1' then
                CS <= START;
            else
                CS <= CS;
            end if;
        when START =>
            clk_en <= '1';
            ready <= '0';
            sd_s <='0';
            CS <= ADDRESS;
        when ADDRESS =>
            if dat_en = '1' and sclk = '0' then
            --if sclk = '1' then
                if cnt > 18 then
                    sd_s <= tx_buff(cnt);
                    cnt <= cnt - 1;
                    CS <= CS;
                else
                    sd_s <= tx_buff(cnt);
                    cnt <= cnt-1;
                    sd_s <= tx_buff(cnt);
                    CS <= A_AK;
                end if;
            else 
                CS <= CS;
            end if;
        when A_AK =>
           sd_s <= tx_buff(cnt);
            if sclk = '1' then
                if sdata_io = '0' then
                    CS <= R_DATA;
                    cnt <= cnt -1;
                else
                    CS <= IDLE;
                end if;
            else
                CS <= CS;
            end if;
        when R_DATA =>
            if dat_en = '1' and sclk = '0' then
            --if sclk = '1' then
                CS <= CS;
                if cnt > 9 then
                    rx_buff(data_cnt) <= sdata_io;
                    cnt <= cnt -1;
                    data_cnt <= data_cnt -1;
                elsif cnt = 9 then
                    sd_s <= tx_buff(cnt);
                    cnt <= cnt -1;
                    data_cnt <= data_cnt;
                elsif cnt >= 0 then
                    rx_buff(data_cnt) <= sdata_io;
                    cnt <= cnt -1;
                    data_cnt <= data_cnt -1;
                else
                    pdata_s <= rx_buff;
                    --if ld = '0' then
                        sd_s <= '1';
                        CS <= Idle;
                    --else
                       -- sd_s <= '0';
                        --cnt <= 16;
                        --data_cnt <= 15;
                        --CS <= CS;           
                    --end if;
                end if;
            else 
                CS <= CS;
            end if;
        when OTHERS =>
            CS <= IDLE;  
    end case; 
    --cnt <= cnt-1;
    --else 
    --cnt <= cnt;
    --end if;

end if;   
            
end process;

process(clk, rst)
begin
if rst = '1' then
    pdata <= "0000000000000000";
elsif falling_edge(clk) then
    pdata <= pdata_s; 
end if;
end process;

sdata_io <= '0' when sd_s = '0' else
            'Z';

end Behavioral;
