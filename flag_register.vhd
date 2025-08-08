library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity flag_register is
Port (clk: in  std_logic;
      reset: in  std_logic;
      update_flag: in  std_logic;
      result: in std_logic_vector(7 downto 0);
 --     result_high: in std_logic_vector(7 downto 0);
      opcode: in  std_logic_vector(3 downto 0);
      carry: in  std_logic;
      flag_reg: out std_logic_vector(7 downto 0)
);


end flag_register;

architecture Behavioral of flag_register is


signal flags : std_logic_vector(7 downto 0);
   -- Flag positions 
constant carry_pos    : integer := 0;
constant zero_pos     : integer := 1;
constant sign_pos     : integer := 2;
constant parity_pos   : integer := 3;
--constant overflow_pos : integer := 4;
begin

 process(clk, reset)
 variable temp_parity : std_logic;
 begin
       if reset = '1' then
           flags <= (others => '0');
       elsif rising_edge(clk) then
           if update_flag = '1' then
                 -- default
               flags <= (others => '0');
               
                -- Carry Flag
               case opcode is
                 when "0000" | "0001" => flags(carry_pos) <= carry;
                 when others => flags(carry_pos) <= '0';
               end case;
               
                 -- Zero Flag
                if ((opcode = "0100" and result = "00000001") or
   		   (opcode /= "0100" and result = "00000000")) then
   		 flags(zero_pos) <= '1';
		else
	         flags(zero_pos) <= '0';
		end if;
                        
               --  Sign Flag
              -- if opcode = "0101" then -- MUL
                --   flags(sign_pos) <= result_high(7);
               --else
                   flags(sign_pos) <= result(7);
              -- end if;
               
               -- Parity Flag (even parity)
               temp_parity := '1';
               for i in 0 to 7 loop
                   temp_parity := temp_parity xnor result(i);
               end loop;
               flags(parity_pos) <= temp_parity;
               
           end if;
       end if;
   end process;
   flag_reg <= flags;
end Behavioral;
