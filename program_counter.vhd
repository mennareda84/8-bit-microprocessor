library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity program_counter is
Port ( clk      : in  std_logic;
      reset    : in  std_logic;
      -- Program Counter
      pc_in    : in  std_logic_vector(7 downto 0);
      pc_inc   : in  std_logic;
      pc_out   : out std_logic_vector(7 downto 0);
      pc_load  : in  std_logic
     );
end program_counter;
architecture Behavioral of program_counter is
signal PC: std_logic_vector(7 downto 0);

begin
process(clk, reset)
    begin
        if reset = '1' then
            PC <= (others => '0');
        elsif rising_edge(clk) then
              -- Program Counter
              if pc_load = '1' then
                 PC <= pc_in;
              end if;
              if pc_inc = '1' then
                 PC <= std_logic_vector(unsigned(pc) + 1);
              end if;
        end if;
end process;
pc_out <= PC;
end Behavioral;
