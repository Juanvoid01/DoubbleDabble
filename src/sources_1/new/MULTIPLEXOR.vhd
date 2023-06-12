----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 15:50:18
-- Design Name: 
-- Module Name: MULTIPLEXOR - Behavioral
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

entity MULTIPLEXOR is
    generic (N: natural := 8);
    Port ( E0 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           E1 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           E2 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           E3 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           CTRL: in STD_LOGIC_VECTOR(1 DOWNTO 0);
           S : out STD_LOGIC_VECTOR(N-1 DOWNTO 0));
end MULTIPLEXOR;
architecture Behavioral of MULTIPLEXOR is

begin

  S<=E0 WHEN  CTRL = "00" else
  E1 WHEN  CTRL = "01" else
  E2 WHEN  CTRL = "10" else
  E3;


end Behavioral;
