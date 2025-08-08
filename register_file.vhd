library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
  Port (clk: in  std_logic;
        reset: in  std_logic;
      read_reg1   : in  std_logic_vector(3 downto 0); -- src1
      read_reg2   : in  std_logic_vector(3 downto 0); -- src2
      write_reg   : in  std_logic_vector(3 downto 0); -- DIST
      write_data  : in  std_logic_vector(7 downto 0);-- 
      reg_write   : in  std_logic; 
      read_data1  : out std_logic_vector(7 downto 0); -- to alu (A)
      read_data2  : out std_logic_vector(7 downto 0)); -- to alu (B)
end register_file;

architecture Behavioral of register_file is
type reg_array is array (0 to 7) of std_logic_vector(7 downto 0);
    signal GPRs : reg_array := (others => (others => '0'));
begin
  process(clk, reset)
  begin
      if reset = '1' then
          GPRs <= (others => (others => '0'));
      elsif rising_edge(clk) then
          if reg_write = '1' then
              GPRs(to_integer(unsigned(write_reg))) <= write_data;
          end if;
      end if;
  end process;

  -- read outputs
read_data1 <= GPRs(to_integer(unsigned(read_reg1)));
read_data2 <= GPRs(to_integer(unsigned(read_reg2)));

end Behavioral;
