----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 15:50:18
-- Design Name: 
-- Module Name: COUNTER - Behavioral
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

entity COUNTER is
    generic( N : natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           E : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           LD : in STD_LOGIC;
           CU : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 DOWNTO 0));
end COUNTER;

architecture Behavioral of COUNTER is

    signal intermediate : std_logic_vector (n-1 downto 0);
begin


process(CLK, RST)
begin
     if rst='1' then intermediate<=(others =>'0');
     elsif (clk'event and clk='1') then
        if LD='1' then intermediate <= E;
        else
            if cu = '1' then intermediate <= intermediate + 1;
            else intermediate<=intermediate;
            end if;
        end if;
     end if;
end process;

S<=intermediate;



end Behavioral;
