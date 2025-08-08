library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity io_interface is
    Port (
        clk       : in  std_logic; -- from system clock (crystal of FPGA)
	reset     : in  std_logic; -- from system reset button
	io_addr   : in  std_logic_vector(7 downto 0);  -- address of I/O device selected by Control Unit (CU)
	io_in     : in  std_logic_vector(7 downto 0);  -- data coming from input device to I/O interface
	io_out    : out std_logic_vector(7 downto 0);  -- data from I/O interface to output device
	data_in   : in  std_logic_vector(7 downto 0);  -- data sent from output register to I/O interface for writing to output device
	data_out  : out std_logic_vector(7 downto 0);  -- data sent from input device I/O interface to data bus for reading
	write_en  : in  std_logic; -- control signal from CU to enable writing to output register
	read_en   : in  std_logic -- control signal from CU to enable reading from input device

    );
end io_interface;


architecture Behavioral of io_interface is
    signal output_reg : std_logic_vector(7 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            output_reg <= (others => '0');
        elsif rising_edge(clk) then
            if write_en = '1' then
                output_reg <= data_in;
            end if;
        end if;
    end process;


    io_out <= output_reg;

    data_out <= io_in when read_en = '1' else (others => '0');
end Behavioral;

