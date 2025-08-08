library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is

     component ALU is
     Port (
        A, B     : in  unsigned(7 downto 0);
        opcode   : in  std_logic_vector(3 downto 0);
        result   : out unsigned(7 downto 0);
        result_high : out unsigned(7 downto 0);
        Z        : out std_logic;
        C        : out std_logic;
        N        : out std_logic
    );
end component;

    signal A, B         : unsigned(7 downto 0);
    signal opcode       : std_logic_vector(3 downto 0);
    signal result       : unsigned(7 downto 0);
    signal result_high  : unsigned(7 downto 0);
    signal Z, C, N      : std_logic;

begin

    DUT: ALU
        port map (
            A           => A,
            B           => B,
            opcode      => opcode,
            result      => result,
            result_high => result_high,
            Z           => Z,
            C           => C,
            N           => N
        );

 
    stim_proc: process
    begin
     
        A <= to_unsigned(200, 8);
        B <= to_unsigned(100, 8);
        opcode <= "0000"; -- ADD
        wait for 10 ns;

        opcode <= "0001"; -- SUB
        wait for 10 ns;

        opcode <= "0010"; -- AND
        wait for 10 ns;

 
        opcode <= "0011"; -- OR
        wait for 10 ns;

        opcode <= "0100"; -- ECMP
        wait for 10 ns;

        opcode <= "0101"; -- MUL
        wait for 10 ns;

 
        wait;
    end process;

end Behavioral;

