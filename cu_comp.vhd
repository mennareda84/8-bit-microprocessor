library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cu_comp is
    Port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        opcode    : in  std_logic_vector(3 downto 0); -- from instr(15 downto 12)
        cu_state  : out std_logic_vector(2 downto 0); -- optional for debugging

        pc_inc    : out std_logic;
        pc_load   : out std_logic;
        ar_load   : out std_logic;
        ir_load   : out std_logic;
        reg_en    : out std_logic;
        alu_op    : out std_logic_vector(3 downto 0);
        mem_read  : out std_logic;
        mem_write : out std_logic;
        io_read   : out std_logic;
        io_write  : out std_logic
    );
end cu_comp;

architecture Behavioral of cu_comp is
    type state_type is (FETCH, DECODE, EXECUTE, M_IO);
    signal state : state_type := FETCH;
begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all outputs and state
            pc_inc    <= '0';
            pc_load   <= '0';
            ir_load   <= '0';
            ar_load   <= '0';
            reg_en    <= '0';
            alu_op    <= (others => '0');
            mem_read  <= '0';
            mem_write <= '0';
            io_read   <= '0';
            io_write  <= '0';
            state     <= FETCH;

        elsif rising_edge(clk) then
            -- Default values every clock to avoid latching
            pc_inc    <= '0';
            pc_load   <= '0';
            ir_load   <= '0';
            ar_load   <= '0';
            reg_en    <= '0';
            mem_read  <= '0';
            mem_write <= '0';
            io_read   <= '0';
            io_write  <= '0';
            alu_op    <= (others => '0');

            case state is
                when FETCH =>
                    ir_load <= '1';
                    pc_inc  <= '1';
                    state   <= DECODE;

                when DECODE =>
                    case opcode is
                        when "0000" | "0001" | "0010" | "0011" =>  -- ALU Ops
                            state <= EXECUTE;
                        when "0110" | "0111" | "1000" | "1001" =>  -- Memory or I/O
                            state <= M_IO;
                        when others =>
                            state <= FETCH;
                    end case;

                when EXECUTE =>
                    alu_op <= opcode;
                    reg_en <= '1';
                    state  <= FETCH;

                when M_IO =>
                    case opcode is
                        when "0110" =>  -- LOAD
                            mem_read <= '1';
                            reg_en   <= '1';
                        when "0111" =>  -- STORE
                            mem_write <= '1';
                        when "1000" =>  -- IN
                            io_read <= '1';
                            reg_en  <= '1';
                        when "1001" =>  -- OUT
                            io_write <= '1';
                        when others =>
                            null;
                    end case;
                    state <= FETCH;

            end case;
        end if;
    end process;

    -- Optional debug output
    with state select
        cu_state <= "000" when FETCH,
                    "001" when DECODE,
                    "010" when EXECUTE,
                    "011" when M_IO,
                    "111" when others;

end Behavioral;

