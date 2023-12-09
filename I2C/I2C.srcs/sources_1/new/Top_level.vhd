----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 02:18:39 PM
-- Design Name: 
-- Module Name: Top_level - Behavioral
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

entity Top_level is
  Port (ld, clk, rst, rd_wr: in std_logic;
        ready, s_clk : out std_logic;
        pdata : out std_logic_vector(15 downto 0);
        sdata_io : inout std_logic);
end Top_level;

architecture Behavioral of Top_level is

signal sclk_s, sclk2, clk_en_s, Q1, Q2, dat_ens : std_logic;

component controller is
    Port (ld, clk, rst, rd_wr, sclk, dat_en : in std_logic;
        clk_en, ready : out std_logic;
        pdata : out std_logic_vector(15 downto 0);
        sdata_io : inout std_logic);
end component;

component Clk_div_pulse is
  Port (clk, rst : in std_logic;
        clk_out, data: out std_logic  );
end component;

begin

CDP : Clk_div_pulse Port map(clk, clk_en_s, sclk_s, dat_ens);

CONT : controller port map(ld, clk, rst, rd_wr, sclk_s, dat_ens, clk_en_s, ready, pdata, sdata_io);

--process(clk)
--begin
--    if falling_edge(clk) then
--        Q1 <= sclk_s;
--    end if;
--end process;
--process(clk, clk_en_s)
--begin
--    if clk_en_s = '0' then
--        Q2 <= Q1;
--    elsif falling_edge(clk) then
--        Q2 <= not Q1;
--    end if;
--end process;
--if sclk_s = '1' then
--    sclk2 <= not sclk2;
--    end if;
--sclk2 <= Q1 and Q2;
s_clk <= sclk_s;
end Behavioral;
