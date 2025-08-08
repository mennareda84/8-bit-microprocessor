library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
    Port (
          clk     : in  std_logic;
          ram_read_en : in  std_logic;
          we      : in  std_logic;
          addr    : in  std_logic_vector(7 downto 0);  
          data_in : in  std_logic_vector(7 downto 0);
          data_out: out std_logic_vector(7 downto 0)
        );
end RAM;

architecture Behavioral of RAM is
    -- Type declaration for 256-byte RAM
    type ram_type is array (0 to 255) of std_logic_vector(7 downto 0);
    
    -- RAM signal with initial values for demonstration
    signal ram_array : ram_type := (
        -- Initialize with sample data (addresses 4-6 match your example)
        6  => x"15",  -- Initial value for A
        7  => x"33",  -- Initial value for B
        8  => x"00",  -- Result location
        
        16 => x"AA",
        17 => x"BB",
        18 => x"CC",
        
        others => (others => '0')
    );
    -- Internal signal for output register
    signal data_out_reg : std_logic_vector(7 downto 0) := (others => '0');
    
begin
    -- RAM operation process
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                ram_array(to_integer(unsigned(addr))) <= data_in;
            elsif ram_read_en = '1' then
                data_out_reg <= ram_array(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
    data_out <= data_out_reg;
    end Behavioral;