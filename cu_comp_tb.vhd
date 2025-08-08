library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cu_comp_tb is
end cu_comp_tb;

architecture Behavioral of cu_comp_tb is

    -- Component Declaration
    component cu_comp is
        Port (
            clk       : in  std_logic;
            reset     : in  std_logic;
            opcode    : in  std_logic_vector(3 downto 0);
            cu_state  : out std_logic_vector(2 downto 0);

            pc_inc    : out std_logic;
            pc_load   : out std_logic;
            ar_load   : out std_logic;
            ir_load   : out std_logic;
            reg_en    : out std_logic;
            reg_sel   : out std_logic_vector(2 downto 0);
            alu_op    : out std_logic_vector(3 downto 0);
            mem_read  : out std_logic;
            mem_write : out std_logic;
            io_read   : out std_logic;
            io_write  : out std_logic
        );
    end component;

    -- Signals to connect to the Unit Under Test (UUT)
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal opcode    : std_logic_vector(3 downto 0) := (others => '0');
    signal cu_state  : std_logic_vector(2 downto 0);

    signal pc_inc    : std_logic;
    signal pc_load   : std_logic;
    signal ar_load   : std_logic;
    signal ir_load   : std_logic;
    signal reg_en    : std_logic;
    signal reg_sel   : std_logic_vector(2 downto 0);
    signal alu_op    : std_logic_vector(3 downto 0);
    signal mem_read  : std_logic;
    signal mem_write : std_logic;
    signal io_read   : std_logic;
    signal io_write  : std_logic;

    -- Clock generation: 10 ns period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: cu_comp
        port map (
            clk       => clk,
            reset     => reset,
            opcode    => opcode,
            cu_state  => cu_state,
            pc_inc    => pc_inc,
            pc_load   => pc_load,
            ar_load   => ar_load,
            ir_load   => ir_load,
            reg_en    => reg_en,
            reg_sel   => reg_sel,
            alu_op    => alu_op,
            mem_read  => mem_read,
            mem_write => mem_write,
            io_read   => io_read,
            io_write  => io_write
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply Reset
        reset <= '1';
        wait for 2 * clk_period;
        reset <= '0';

        -- ALU Operation: opcode "0001"
        opcode <= "0001";  -- ADD or SUB, etc.
        wait for 5 * clk_period;

        -- LOAD: opcode "0110"
        opcode <= "0110";
        wait for 5 * clk_period;

        -- STORE: opcode "0111"
        opcode <= "0111";
        wait for 5 * clk_period;

        -- IN: opcode "1000"
        opcode <= "1000";
        wait for 5 * clk_period;

        -- OUT: opcode "1001"
        opcode <= "1001";
        wait for 5 * clk_period;

        -- Invalid / Unknown opcode: "1111"
        opcode <= "1111";
        wait for 5 * clk_period;

        -- End simulation
assert reg_en = '1'
    report "Error: reg_en should be 1 during ALU execute"
    severity error;
        wait;
    end process;

end Behavioral;

