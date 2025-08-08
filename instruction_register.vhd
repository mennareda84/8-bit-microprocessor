library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_register is
  Port ( clk      : in  std_logic;
      reset    : in  std_logic;
      ir_in    : in  std_logic_vector(15 downto 0);
      ir_out   : out std_logic_vector(15 downto 0);
      ir_load  : in  std_logic );
end instruction_register;

architecture Behavioral of instruction_register is
signal IR: std_logic_vector(15 downto 0);
begin
process(clk, reset)
    begin
        if reset = '1' then
           IR <= (others => '0');
        elsif rising_edge(clk) then
              if ir_load = '1' then
                 IR <= ir_in;
              end if;
        end if;
end process;
ir_out <= IR;
end Behavioral;

