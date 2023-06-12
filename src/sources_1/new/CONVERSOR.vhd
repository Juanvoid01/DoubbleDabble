----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 17:44:12
-- Design Name: 
-- Module Name: CONVERSOR - Behavioral
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

entity CONVERSOR is
    generic (N : natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ENTRADA : in STD_LOGIC_VECTOR (7 downto 0);
           INICIO : in STD_LOGIC;
           FIN : OUT STD_LOGIC;
           SALIDA : OUT STD_LOGIC_VECTOR (11 downto 0);
           DISPLAY : out  STD_LOGIC_VECTOR (6 downto 0);
           DISPLAY_ENABLE : out  STD_LOGIC_VECTOR (3 downto 0)
           );
end CONVERSOR;

architecture Behavioral of CONVERSOR is

COMPONENT DATAPATH IS
    generic (N : natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ENTRADA : in STD_LOGIC_VECTOR (7 downto 0);
           mux : in STD_LOGIC_VECTOR (1 downto 0);
           ld_re,ld_r0,ld_r1,ld_r2,ld_rc,op,cu :in STD_LOGIC;
           iter_8,mayor_4 : out STD_LOGIC;
           SALIDA : OUT STD_LOGIC_VECTOR (11 downto 0));
 END COMPONENT;
 
 COMPONENT FSM IS
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           INI : in STD_LOGIC;
           iter_8,mayor_4 : in STD_LOGIC;
           mux : out STD_LOGIC_VECTOR (1 downto 0);
           LD_RE,LD_R0,LD_R1,LD_R2,LD_RC,OP,CU,FIN :out STD_LOGIC);
 end component;   
 
 component displays is
    Port ( 
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;       
        digito_0 : in  STD_LOGIC_VECTOR (3 downto 0);
        digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
        digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
        digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
        display : out  STD_LOGIC_VECTOR (6 downto 0);
        display_enable : out  STD_LOGIC_VECTOR (3 downto 0)
     );
end component;        

 signal ld_re,ld_r0,ld_r1,ld_r2,ld_rc,op,cu,iter_8,mayor_4 : STD_LOGIC;
 signal mux : STD_LOGIC_VECTOR(1 DOWNTO 0);
 signal s_salida : STD_LOGIC_VECTOR (11 downto 0);
begin
    
    SALIDA <= s_salida;
    
    RUTA_DATOS : DATAPATH GENERIC MAP (8)
    PORT MAP ( CLK =>clk,
           RST =>rst,
           ENTRADA =>ENTRADA,
           mux => mux,
           ld_re=> ld_re,
           ld_r0=>ld_r0,
           ld_r1=>ld_r1,
           ld_r2=>ld_r2,
           ld_rc=>ld_rc,
           op=>op,
           cu=>cu,
           iter_8=>iter_8,
           mayor_4 =>mayor_4,
           SALIDA =>s_salida);
           
    CONTROLADOR: FSM 
    PORT MAP ( CLK =>CLK,
           RST =>RST,
           INI =>INICIO,
           iter_8=>iter_8,
           mayor_4=>mayor_4,
           mux=>mux,
           ld_re=>ld_re,
           ld_r0=>ld_r0,
           ld_r1=>ld_r1,
           ld_r2=>ld_r2,
           ld_rc=>ld_rc,
           op=>op,
           cu=>cu,
           fin=> FIN);

displays_instance : displays 
    PORT MAP( 
        rst => rst,
        clk => clk,     
        digito_0 => s_salida(3 downto 0),
        digito_1 => s_salida(7 downto 4),
        digito_2 => s_salida(11 downto 8),
        digito_3 => "0000",
        display => DISPLAY,
        display_enable => DISPLAY_ENABLE
     );
end Behavioral;
