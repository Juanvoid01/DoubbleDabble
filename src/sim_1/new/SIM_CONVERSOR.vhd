--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;


ENTITY tb_conversor IS
END tb_conversor;

ARCHITECTURE behavior OF tb_conversor IS 
 
-- Declaracion del componente que vamos a simular
 
    COMPONENT CONVERSOR
     generic (N : natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ENTRADA : in STD_LOGIC_VECTOR (7 downto 0);
           INICIO : in STD_LOGIC;
           FIN : OUT STD_LOGIC;
           SALIDA : OUT STD_LOGIC_VECTOR (11 downto 0));
    END COMPONENT;

--Entradas
    signal rst : std_logic;
    signal clk : std_logic;
    signal E : std_logic_vector(7 downto 0);
    signal INICIO,FIN: std_logic;
		
--Salidas
    signal Salida : std_logic_vector(11 downto 0);
   
--Se define el periodo de reloj 
    constant clk_period : time := 50 ns;
 
BEGIN
 
-- Instanciacion de la unidad a simular 

     conv: CONVERSOR GENERIC MAP (8)
    PORT MAP ( CLK =>CLK,
           RST =>RST,
           ENTRADA =>E,
           INICIO =>INICIO,
           FIN => FIN,
           SALIDA =>Salida);

-- Definicion del process de reloj
reloj_process :process
   begin
	clk <= '0';
	wait for clk_period/2;
	clk <= '1';
	wait for clk_period/2;
end process;
 

--Proceso de estimulos
stim_proc: process
   begin		
-- Se mantiene el rst activado durante 50 ns.
      rst<='1';
      E<="00000000";
      INICIO <='0';
      wait for 50 ns;
-- Dejamos de resetear	
      rst<='0';
      E<="00000000";
      INICIO <='0';
      wait for 50 ns;
-- Introducimos un 251	
      rst<='0';
      E<="11111011";
      INICIO <='1';
      wait for 50 ns;
-- Introducimos un 251	
      rst<='0';
      E<="11111011";
      INICIO <='0';
      wait for 50 ns;	
-- ESPERAMOS resultado 
      rst<='0';
      E<="00000000";
      INICIO <='0';
      wait for 4500 ns;
-- Introducimos un 123
      rst<='0';
      E<="01111011";
      INICIO <='1';
      wait for 50 ns;
-- Introducimos un 123	
      rst<='0';
      E<="01111011";
      INICIO <='0';
      wait for 50 ns;
-- ESPERAMOS resultado 
      rst<='0';
      E<="00000000";
      INICIO <='0';
      wait for 4500 ns;
-- Introducimos un 255
      rst<='0';
      E<="11111111";
      INICIO <='1';
      wait for 50 ns;
-- Introducimos un 255	
      rst<='0';
      E<="11111111";
      INICIO <='0';
      wait for 50 ns;		
-- ESPERAMOS resultado 
      rst<='0';
      E<="00000000";
      INICIO <='0';
      wait;

end process;

END;