----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2023 02:49:29 PM
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
  Port (c_in, clk, rst, clk_div: in std_logic;
        cnt_en, rdy : out std_logic);
end Controller;

architecture Behavioral of Controller is
type STATE_TYPE is (idle, data_time, ST_BIT);
signal CS : STATE_TYPE;
signal cnt : unsigned(3 downto 0);

begin
process(clk, rst)
begin
    if rst = '1' then
        CS <= idle;
        rdy <= '0';
        cnt_en <= '1';
    elsif rising_edge(clk) then 
        case CS is 
            when idle =>
                rdy <= '0';
                cnt <= "0000";
                if c_in = '1' then
                    cnt_en <= '1';
                    CS <= CS;
                else    
                    CS <= data_time; 
                    --cnt_en <='0';
                end if;
            when data_time =>
                rdy <= '0';
                cnt_en <= '0';
                if clk_div = '1' then
                    if cnt < "1000" then
                        cnt <= cnt + 1;
                    else
                        CS <= ST_BIT;
                        cnt_en <= '1';
                        --cnt <= "0000";
                    end if;
                else
                    CS <= CS;  
                end if;
            When ST_BIT =>
                cnt_en <= '1';
                if C_in = '1' then
                    CS <= Idle;
                    rdy <= '1';
                    --cnt_en <= '1';
                else 
                    CS <= CS;
                    --cnt_en <= '1';
                end if;
                         
            when others =>
                CS <= idle;
        end case;
    end if;
end process;
end Behavioral;
