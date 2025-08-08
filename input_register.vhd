library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_register is
  Port (clk      : in  std_logic;
        reset    : in  std_logic; 
       inpr_in   : in  std_logic_vector(7 downto 0); -- from IO Interface (data_out)
       inpr_out  : out std_logic_vector(7 downto 0); -- to control unit
       inpr_load : in  std_logic ); -- from unit
end input_register;


architecture Behavioral of input_register is
signal inpr: std_logic_vector(7 downto 0);
begin 
   process(clk, reset)
 begin
     if reset = '1' then
         inpr <= (others => '0');
     elsif rising_edge(clk) then
         if inpr_load = '1' then
                    inpr <= inpr_in;
         end if;
     end if;
end process;
inpr_out <= inpr;
end Behavioral;
