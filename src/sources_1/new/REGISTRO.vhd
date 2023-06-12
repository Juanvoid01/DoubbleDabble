----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 15:54:19
-- Design Name: 
-- Module Name: REGISTRO - Behavioral
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

entity REGISTRO is
    generic( N : natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           E : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           E_RIGHT : in STD_LOGIC;
           LD : in STD_LOGIC;
           OP : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 DOWNTO 0));
end REGISTRO;

architecture Behavioral of REGISTRO is

    signal intermediate : std_logic_vector (n-1 downto 0);
begin


process(CLK, RST)
begin
     if rst='1' then intermediate<=(others =>'0');
     elsif (clk'event and clk='1') then
        if LD='1' then intermediate <= E;
        else
            if op = '1' then intermediate <= intermediate(n - 2 downto 0) & E_RIGHT;
            else intermediate<=intermediate;
            end if;
        end if;
     end if;
end process;

S<=intermediate;


end Behavioral;
