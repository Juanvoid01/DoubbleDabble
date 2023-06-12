----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.01.2023 17:57:00
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is

    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           INI : in STD_LOGIC;
           iter_8,mayor_4 : in STD_LOGIC;
           mux : out STD_LOGIC_VECTOR (1 downto 0);
           LD_RE,LD_R0,LD_R1,LD_R2,LD_RC,OP,CU,FIN :out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is
type ESTADOS is 
(S0_INICIO, S1_LOAD, S2_DESPLAZAR, S3_OPERAR_R0, S4_SUMAR_R0,
 S5_OPERAR_R1, S6_SUMAR_R1, S7_OPERAR_R2, S8_SUMAR_R2, S9_SUMAR_CU,S10_8ITER);

signal ESTADO, SIG_ESTADO: ESTADOS;

BEGIN

SYNC: process (clk, RST)
begin
if rising_edge(clk) then
    if RST ='1' then
    ESTADO <= S0_INICIO;
    else
    ESTADO <= SIG_ESTADO;
    end if;
end if;
end process SYNC;

COMB: process (ESTADO,INI,ITER_8,MAYOR_4)
begin

    case ESTADO is
    when S0_INICIO =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "00";
        OP <= '0';
        CU <= '0';
        FIN <= '1';
        
        if ini = '1' then SIG_ESTADO <= S1_LOAD;
        else SIG_ESTADO <= S0_INICIO;
        end if;
    
    when S1_LOAD =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '1';
        LD_RC <= '1';
        MUX <= "00";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        SIG_ESTADO <= S2_DESPLAZAR;
        
    when S2_DESPLAZAR =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "00";
        OP <= '1';
        CU <= '0';
        FIN <= '0';
        
        SIG_ESTADO <= S10_8ITER;
        --SIG_ESTADO <= S3_OPERAR_R0;
        
    when S3_OPERAR_R0 =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "00";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        
        if mayor_4 = '1' then SIG_ESTADO <= S4_SUMAR_R0;
        else SIG_ESTADO <= S5_OPERAR_R1;
        end if;
    
    when S4_SUMAR_R0 =>
        LD_R0 <= '1';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "00";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        SIG_ESTADO <= S5_OPERAR_R1;
    
    when S5_OPERAR_R1 =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "01";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        if mayor_4 = '1' then SIG_ESTADO <= S6_SUMAR_R1;
        else SIG_ESTADO <= S7_OPERAR_R2;
        end if;
    
    when S6_SUMAR_R1 =>
        LD_R0 <= '0';
        LD_R1 <= '1';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "01";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        SIG_ESTADO <= S7_OPERAR_R2;
 
    when S7_OPERAR_R2 =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "10";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        if mayor_4 = '1' then SIG_ESTADO <= S8_SUMAR_R2;
        else SIG_ESTADO <= S9_SUMAR_CU;
        end if;
    
    when S8_SUMAR_R2 =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '1';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "10";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        SIG_ESTADO <= S9_SUMAR_CU;
    
    when S9_SUMAR_CU =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "00";
        OP <= '0';
        CU <= '1';
        FIN <= '0';

        SIG_ESTADO <= S2_DESPLAZAR;
 
    when S10_8ITER =>
        LD_R0 <= '0';
        LD_R1 <= '0';
        LD_R2 <= '0';
        LD_RE <= '0';
        LD_RC <= '0';
        MUX <= "00";
        OP <= '0';
        CU <= '0';
        FIN <= '0';
        
        if iter_8 = '1' then SIG_ESTADO <= S0_INICIO;
        else SIG_ESTADO <= S3_OPERAR_R0;
        end if;
    end case;
end process COMB;
end Behavioral;
