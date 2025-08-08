----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_register is
Port ( clk      : in  std_logic;
      reset    : in  std_logic;
       -- Data Register
      dr_in    : in  std_logic_vector(15 downto 0);
      dr_out   : out std_logic_vector(15 downto 0);
      dr_load  : in  std_logic);
end data_register;
architecture Behavioral of data_register is
signal DR: std_logic_vector(15 downto 0);
begin
process(clk, reset)
    begin
        if reset = '1' then
            DR <= (others => '0');
        elsif rising_edge(clk) then
           -- Data Register
            if dr_load = '1' then
               DR <= dr_in;
            end if;
        end if;
end process;
dr_out <= DR;      
end Behavioral;
