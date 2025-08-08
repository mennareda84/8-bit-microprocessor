--  PROJECT NAME : 8-Bit Microprocessor
--  FILE NAME    : ALU
--  Describtion  : ALU takes 2 8-bit-inputs & 4-bit opcode to implement ( ADD - SUB - AND - OR - ECMP - MUL )
--                 
--  ***********************************************************************************************************  --


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A, B         : in  std_logic_vector(7 downto 0);
        opcode       : in  std_logic_vector(3 downto 0);
        result       : out std_logic_vector(7 downto 0);
     --   result_high  : out std_logic_vector(7 downto 0);
--        Z            : out std_logic;
        C            : out std_logic
 --       N            : out std_logic
    );

end ALU;

architecture Behavioral of ALU is


begin
    process (A, B, opcode)
        variable A_u, B_u     : unsigned(7 downto 0);
        variable temp_9       : unsigned(8 downto 0);
 --       variable temp_16      : unsigned(15 downto 0);
        variable temp_result  : unsigned(7 downto 0);
 --       variable temp_high    : unsigned(7 downto 0);
     --   variable z_flag       : std_logic := '0';
        variable c_flag       : std_logic := '0';
     --   variable n_flag       : std_logic := '0';
    begin
        -- convert inputs
        A_u := unsigned(A);
        B_u := unsigned(B);

        temp_result := (others => '0');
  --      temp_high   := (others => '0');
   --     z_flag := '0';
        c_flag := '0';
   --     n_flag := '0';

        case opcode is
            when "0000" => -- ADD
                temp_9 := ('0' & A_u) + ('0' & B_u);
                temp_result := temp_9(7 downto 0);
                c_flag := temp_9(8);
              

            when "0001" => -- SUB
                temp_9 := ('0' & A_u) - ('0' & B_u);
                temp_result := temp_9(7 downto 0);
                c_flag := temp_9(8);
                

            when "0010" => -- AND
                temp_result := A_u and B_u;
           

            when "0011" => -- OR
                temp_result := A_u or B_u;
              

            when "0100" => -- ECMP
                if A_u = B_u then
		temp_result := "00000001";
		else
		temp_result := (others => '0');                 
                end if;

    --        when "0101" => -- MUL
     --           temp_16 := A_u * B_u;
      --          temp_result := temp_16(7 downto 0);
      --          temp_high   := temp_16(15 downto 8);

            when others =>
                temp_result := (others => '0');
        end case;

        -- convert outputs
        result       <= std_logic_vector(temp_result);
     --   result_high  <= std_logic_vector(temp_high);
--        Z <= z_flag;
        C <= c_flag;
--        N <= n_flag;
    end process;
end Behavioral;

