library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port (
        addr  : in  std_logic_vector(7 downto 0);  -- 16-bit address FROM address register
        instr : out std_logic_vector(15 downto 0)   -- 16-bit instruction
    );
end ROM;

architecture Behavioral of ROM is
    type rom_type is array (0 to 255) of std_logic_vector(15 downto 0); 
    signal rom : rom_type := (
         -- Program to demonstrate load/store/add
       0 => "0110000100000100", -- LOAD R1, [6]   (Load A)
       1 => "0110001000000101", -- LOAD R2, [7]   (Load B)
       2 => "0000000100100000", -- ADD R1, R2     (R1 = R1 + R2)
       3 => "0111000100000110", -- STORE R1, [8]  (Store result)
       4 => "0110000100000110",  -- LOAD R1, [8]   (Load A)
        others => (others => '0')
    );
begin
    instr <= rom(to_integer(unsigned(addr)));
end Behavioral;

