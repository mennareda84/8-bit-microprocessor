library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output_register is
 Port (clk      : in  std_logic;
       reset    : in  std_logic; 
      outr_in  : in  std_logic_vector(7 downto 0);
      outr_out : out std_logic_vector(7 downto 0);
      outr_load: in  std_logic );
end output_register;


architecture Behavioral of output_register is
signal outr : std_logic_vector(7 downto 0);
begin
  process(clk, reset)
  begin
   if reset = '1' then
       outr <= (others => '0');
   elsif rising_edge(clk) then
       if outr_load = '1' then
          outr <= outr_in;
       end if;
   end if;
end process;
outr_out <= outr;
end Behavioral;
