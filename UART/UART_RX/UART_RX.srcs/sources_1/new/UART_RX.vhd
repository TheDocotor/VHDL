----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/14/2023 01:39:14 PM
-- Design Name: 
-- Module Name: UART_RX - Behavioral
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

entity UART_RX is
    Port (clk, reset, sdata : in std_logic;
          pdata : out std_logic_vector(7 downto 0);
          ready : out std_logic);
end UART_RX;

architecture Behavioral of UART_RX is

component Shift_8 is
  Port (shift, d_in, clk : in std_logic;
        d_out : out std_logic_vector(7 downto 0));
end component;

component Controller is
  Port (c_in, clk, rst, clk_div : in std_logic;
        cnt_en, rdy : out std_logic);
end component;

component Clk_div_pulse is
  Port (clk, rst : in std_logic;
        clk_out : out std_logic  );
end component;
signal n_clk : std_logic;
signal cnt_en : std_logic;
signal D_out : std_logic;
signal clk_div : std_logic;

begin
n_clk <= not clk;

clk_d : Clk_div_pulse port map(clk => n_clk,
                                 rst => cnt_en,
                                 clk_out => clk_div);
                                                                 
cntr : Controller port map(c_in => sdata,
                            clk => clk,
                            rst => reset,
                            clk_div => clk_div,
                            cnt_en => cnt_en,
                            rdy => ready);

sh_8 : Shift_8 port map(shift => clk_div,
                        d_in => sdata,
                        clk => clk,
                        d_out => pdata);

end Behavioral;
