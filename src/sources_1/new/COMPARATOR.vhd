----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 15:44:12
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
    generic (N: natural := 8);
    Port ( A : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           EQUAL : out STD_LOGIC;
           BIGGER : out STD_LOGIC;
           SMALLER : out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

begin

process(A,B)
begin

    if A = B  then 
        EQUAL <= '1';
        BIGGER <='0';
        SMALLER <='0';
    elsif A > B then
        EQUAL <= '0';
        BIGGER <='1';
        SMALLER <='0';
    else 
        EQUAL <= '0';
        BIGGER <='0';
        SMALLER <='1';
    end if;
end process;

end Behavioral;
