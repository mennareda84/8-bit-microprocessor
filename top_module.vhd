library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    Port (
        clk           : in  std_logic;
        reset         : in  std_logic;
	result		: out std_logic_vector( 7 downto 0)
 );
end top_module;

architecture Behavioral of top_module is
   
    -- components 
    -- Control Unit
component cu_comp is
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
end component;

    -- program counter component
    component program_counter is
    Port ( clk      : in  std_logic;
          reset    : in  std_logic;
          -- Program Counter
          pc_in    : in  std_logic_vector(7 downto 0);
          pc_inc   : in  std_logic;
          pc_out   : out std_logic_vector(7 downto 0);
          pc_load  : in  std_logic
          );
    end component;

    -- address register component
    component address_register is
    Port (clk      : in  std_logic;
          reset    : in  std_logic; 
          ar_in    : in  std_logic_vector(7 downto 0);
          ar_out   : out std_logic_vector(7 downto 0);
          ar_load  : in  std_logic);
    end component;

    -- ROM component
        component ROM is
            Port (
                addr  : in  std_logic_vector(7 downto 0);  -- 8-bit address FROM address register
                instr : out std_logic_vector(15 downto 0)   -- 16-bit instruction
            );
        end component;

-- RAM coponent 
component RAM is
    Port (
          clk     : in  std_logic;
          ram_read_en : in  std_logic;
          we      : in  std_logic;
          addr    : in  std_logic_vector(7 downto 0);  
          data_in : in  std_logic_vector(7 downto 0);
          data_out: out std_logic_vector(7 downto 0)
        );
end component;
       -- instruction register
       component instruction_register is
         Port ( clk      : in  std_logic;
             reset    : in  std_logic;
             ir_in    : in  std_logic_vector(15 downto 0);
             ir_out   : out std_logic_vector(15 downto 0);
             ir_load  : in  std_logic );
       end component;
 
    -- flag register component
    component flag_register is
    Port (clk: in  std_logic;
          reset: in  std_logic;
          update_flag: in  std_logic;
          result: in std_logic_vector(7 downto 0);
          opcode: in  std_logic_vector(3 downto 0);
          carry: in  std_logic;
          flag_reg: out std_logic_vector(7 downto 0)
    );
    end component;

   -- ALU component
    component ALU is
       Port (
           A, B         : in  std_logic_vector(7 downto 0);
           opcode       : in  std_logic_vector(3 downto 0);
           result       : out std_logic_vector(7 downto 0);
           C            : out std_logic
       );
   end component;

    -- register file component
    component register_file is
      Port (clk: in  std_logic;
            reset: in  std_logic;
          read_reg1   : in  std_logic_vector(3 downto 0); -- src1
          read_reg2   : in  std_logic_vector(3 downto 0); -- src2
          write_reg   : in  std_logic_vector(3 downto 0); -- DIST
          write_data  : in  std_logic_vector(7 downto 0); -- result
          reg_write   : in  std_logic; 
          read_data1  : out std_logic_vector(7 downto 0); -- to alu (A)
          read_data2  : out std_logic_vector(7 downto 0)); -- to alu (B)
    end component;
    
       -- signals

       signal opcode    : std_logic_vector(3 downto 0); -- from instr(15 downto 12)
       signal cu_state  : std_logic_vector(2 downto 0); -- optional for debugging
       -- program counter
       signal pc_inc    : std_logic;
       signal pc_in     : std_logic_vector(7 downto 0):= "00000000";
       signal pc_load   : std_logic;
       signal program_counter_out: std_logic_vector(7 downto 0);
       -- address register
       signal ar_load   : std_logic;
       signal address_reg_out: std_logic_vector(7 downto 0);
        -- instruction register
       signal instruction: std_logic_vector(15 downto 0);
       signal instruction_reg_out: std_logic_vector(15 downto 0);
       signal ir_load   : std_logic;
       
       -- register file
       signal reg_en    : std_logic;
        
        -- memory
       signal mem_read  : std_logic;
       signal mem_write : std_logic;
       signal ram_data_out : std_logic_vector(7 downto 0);
       
            -- I/O
       signal io_read   : std_logic:='0';
       signal io_write  : std_logic:='0';
       
        -- flag register
       signal update_flag: std_logic:='0';
       signal flag: std_logic_vector(7 downto 0);

        -- ALU
       signal alu_op    : std_logic_vector(3 downto 0);
       signal ALU_result: std_logic_vector(7 downto 0):= (others =>'0');
       signal A, B: std_logic_vector(7 downto 0); 
       signal carry_out: std_logic;

begin

control_unit: cu_comp port map (clk => clk,
        reset  => reset, 
        opcode =>  instruction_reg_out (15 downto 12),
        cu_state => cu_state,
        pc_inc =>  pc_inc,
        pc_load =>  pc_load,
        ar_load => ar_load,
        ir_load => ir_load,
        reg_en  => reg_en,
        alu_op  => instruction_reg_out (15 downto 12),
        mem_read  => mem_read,
        mem_write => mem_write,
        io_read => io_read, 
        io_write => io_write);
        
PC: program_counter port map(  clk => clk,
                               reset => reset,
			                   pc_in => pc_in,
                               pc_inc  => pc_inc,
                               pc_out => program_counter_out,
                               pc_load => pc_load
);
AR: address_register port map(  clk => clk,
                                reset  => reset,
                                ar_in  => program_counter_out,
                                ar_out => address_reg_out,
                                ar_load => ar_load);
                                
instructions: ROM port map( addr => address_reg_out,
                            instr => instruction);
memoer_ram: RAM port map(
                          clk => clk ,
                          ram_read_en => mem_read,
                          we  => mem_write,
                          addr => instruction_reg_out(7 downto 0),    
                          data_in => ALU_result,
                          data_out => ram_data_out
                                    );                            
                            
instruction_reg: instruction_register port map(clk => clk,
                                         reset    => reset,
                                         ir_in    => instruction,
                                         ir_out   => instruction_reg_out,
                                         ir_load  => ir_load);  
                                         
reg_file: register_file port map (clk => clk,
                                   reset => reset,
                                   read_reg1   => instruction_reg_out(11 downto 8), -- Source 1
                                   read_reg2   => instruction_reg_out(7 downto 4),  -- Source 2                     
                                   write_reg   => instruction_reg_out(11 downto 8),  -- Destination
                                   write_data  => ALU_result,
                                   reg_write   => reg_en,
                                   read_data1  => A,
                                   read_data2  => B);                             
ALU_operation: ALU port map(
                            A => A,
                            B => B,   
                            opcode => instruction_reg_out (15 downto 12),
                            result => ALU_result,
                            C => carry_out
                            );
FR: flag_register port map(clk => clk,
                           reset => reset,
                           update_flag => update_flag,
                           result => ALU_result,
                           opcode => instruction_reg_out (15 downto 12),
                           carry => carry_out,
                           flag_reg => flag);     
 
result <= ram_data_out;         
end Behavioral;