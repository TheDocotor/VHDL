----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2023 02:19:48 PM
-- Design Name: 
-- Module Name: UART_TX - Behavioral
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

entity UART_TX is
    Port (clk, rst, ld : in std_logic;
          pdata : in std_logic_vector(7 downto 0);
          busy, sdata: out std_logic );
end UART_TX;

architecture Behavioral of UART_TX is
component Clk_div_pulse is
  Port (clk, rst : in std_logic;
        clk_out : out std_logic  );
end component;

type STATE_TYPE is (idle, data, sbit);

signal CS : STATE_TYPE;
signal clk_d_s, en_s, n_clk : std_logic;
signal f_data : std_logic_vector(9 downto 0);
signal cnt : integer;

begin
n_clk <= not clk;
Clk2 : Clk_div_pulse port map(clk => n_clk,
                               rst => en_s,
                               clk_out => clk_d_s );
                               
process(clk, rst)
begin
    if rst = '1' then
        en_s <= '1';
        busy <= '0';
        CS <= Idle;
        cnt <= 0;
    elsif rising_edge(clk)then
        case CS is 
            when IDLE =>
                cnt <= 0;
                busy <= '0';
                en_s <= '1';
                if ld = '1' then
                    CS <= data;
                    f_data <= '1' & pdata & '0';
                    en_s <= '0';
                    busy <= '1';
                else
                    CS <= CS;    
                end if;
            when DATA =>
                busy <= '1';
                if clk_d_s = '1' then
                    if cnt <= 9 then     
                        sdata <= f_data(cnt);
                        cnt <= cnt + 1;
                        CS <= CS;
                    else 
                        CS <= sbit;             
                    end if;                         
                end if;
            when SBIT =>
                en_s <= '1';
                CS <= IDLE;
            when OTHERS =>
                CS <= IDLE;
        end case;           
    end if;                       
end process;

end Behavioral;
