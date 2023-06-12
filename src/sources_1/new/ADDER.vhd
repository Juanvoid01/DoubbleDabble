----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 15:50:18
-- Design Name: 
-- Module Name: ADDER - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDER is
    generic( N : natural := 8);
    Port ( A : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           B : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           O : out STD_LOGIC_VECTOR (N-1 DOWNTO 0));
end ADDER;

architecture Behavioral of ADDER is

begin

O <= A + B;

end Behavioral;
