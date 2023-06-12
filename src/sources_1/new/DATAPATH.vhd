----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 15:50:18
-- Design Name: 
-- Module Name: DATAPATH - Behavioral
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

entity DATAPATH is
    generic (N : natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           ENTRADA : in STD_LOGIC_VECTOR (7 downto 0);
           mux : in STD_LOGIC_VECTOR (1 downto 0);
           ld_re,ld_r0,ld_r1,ld_r2,ld_rc,op,cu :in STD_LOGIC;
           iter_8,mayor_4 : out STD_LOGIC;
           SALIDA : OUT STD_LOGIC_VECTOR (11 downto 0));
end DATAPATH;

architecture Behavioral of DATAPATH is

    component ADDER is
    generic (N: natural := 8);
    port( A : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           B : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           O : out STD_LOGIC_VECTOR (N-1 DOWNTO 0));
    end component;
    
    component COMPARATOR is
    generic (N: natural := 8);
    Port ( A : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           EQUAL : out STD_LOGIC;
           BIGGER : out STD_LOGIC;
           SMALLER : out STD_LOGIC);
    end component;
    
    component MULTIPLEXOR is
    generic (N: natural := 8);
     Port ( E0 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           E1 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           E2 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           E3 : in STD_LOGIC_VECTOR(N-1 DOWNTO 0);
           CTRL: in STD_LOGIC_VECTOR(1 DOWNTO 0);
           S : out STD_LOGIC_VECTOR(N-1 DOWNTO 0));
    end component;
    
    component REGISTRO is
    generic (N: natural := 8);
     Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           E : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           E_RIGHT : in STD_LOGIC;
           LD : in STD_LOGIC;
           OP : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 DOWNTO 0));
    end component;
    
    
    component COUNTER is
    generic (N: natural := 8);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           E : in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
           LD : in STD_LOGIC;
           CU : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (N-1 DOWNTO 0));
    end component;
    
    signal S_CU,S_R0,S_R1,S_R2,S_MUX,S_SUM : STD_LOGIC_VECTOR (3 DOWNTO 0);
    signal S_RE : STD_LOGIC_VECTOR (7 DOWNTO 0);
    signal rst_reg : STD_LOGIC;
    
begin

    SUMADOR: ADDER GENERIC MAP(4)
    PORT MAP(  A =>S_MUX,
           B =>"0011",
           O =>S_SUM);
           
    COMPARADOR_4: COMPARATOR GENERIC MAP (4)
    PORT MAP ( A =>S_MUX,
           B =>"0100",
           EQUAL =>open,
           BIGGER =>MAYOR_4,
           SMALLER =>open);
           
    COMPARADOR_ITER: COMPARATOR GENERIC MAP (4)
    PORT MAP ( A =>S_CU,
           B =>"0111",
           EQUAL =>ITER_8,
           BIGGER =>open,
           SMALLER =>open);
           
     MUL: MULTIPLEXOR GENERIC MAP (4)
     PORT MAP ( E0 =>S_R0,
           E1 =>S_R1,
           E2 =>S_R2,
           E3 =>"0000",
           CTRL =>MUX,
           S =>S_MUX);
           
     RE: REGISTRO GENERIC MAP (8)
     PORT MAP ( CLK =>CLK,
           RST =>RST,
           E =>ENTRADA,
           E_RIGHT =>'0',
           LD =>LD_RE,
           OP =>OP,
           S =>S_RE);  
           
    rst_reg <= rst OR ld_rc;
           
    R0: REGISTRO GENERIC MAP (4)
     PORT MAP ( CLK =>CLK,
           RST =>rst_reg,
           E =>S_SUM,
           E_RIGHT =>S_RE(7),
           LD =>LD_R0,
           OP =>OP,
           S =>S_R0);
           
     R1: REGISTRO GENERIC MAP (4)
     PORT MAP ( CLK =>CLK,
           RST =>rst_reg,
           E =>S_SUM,
           E_RIGHT =>S_R0(3),
           LD =>LD_R1,
           OP =>OP,
           S =>S_R1);
           
     R2: REGISTRO GENERIC MAP (4)
     PORT MAP ( CLK =>CLK,
           RST =>rst_reg,
           E =>S_SUM,
           E_RIGHT =>S_R1(3),
           LD =>LD_R2,
           OP =>OP,
           S =>S_R2);
        
    contador: COUNTER GENERIC MAP (4)
    PORT MAP( CLK =>CLK,
           RST =>RST,
           E =>"0000",
           LD =>ld_rc,
           CU =>cu,
           S =>S_CU);
    
    SALIDA <= S_R2 & S_R1 & S_R0;
end Behavioral;
