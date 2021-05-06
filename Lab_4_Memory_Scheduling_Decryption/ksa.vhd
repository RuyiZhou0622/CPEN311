library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ksa is
  port(
    CLOCK_50            : in  std_logic;  -- Clock pin
    KEY                 : in  std_logic_vector(3 downto 0);  -- push button switches
    SW                 : in  std_logic_vector(9 downto 0);  -- slider switches
    LEDR : out std_logic_vector(9 downto 0);  -- red lights
    HEX0 : out std_logic_vector(6 downto 0);
    HEX1 : out std_logic_vector(6 downto 0);
    HEX2 : out std_logic_vector(6 downto 0);
    HEX3 : out std_logic_vector(6 downto 0);
    HEX4 : out std_logic_vector(6 downto 0);
    HEX5 : out std_logic_vector(6 downto 0));
end ksa;

architecture rtl of ksa is
   COMPONENT SevenSegmentDisplayDecoder IS
    PORT
    (
        ssOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        nIn : IN STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
    END COMPONENT;
	 
	 -- Define the memory
	 
	COMPONENT s_memory IS 
    PORT
	(
		address: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock:   IN STD_LOGIC;
		data:    IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren:    IN STD_LOGIC;
		q:       OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END COMPONENT;

    -- Define the Task1_forloop 
    COMPONENT T1_forloop IS
    PORT(
        clk: IN STD_LOGIC;
        addr: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        data_mem: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        wren: OUT STD_LOGIC;
        finish_sig: OUT STD_LOGIC
    );
    END COMPONENT;

    
 
    -- Define the Task2_forloop and creat the memory
    
    COMPONENT T2a_forloop IS
    PORT
    (
        clk:        IN STD_LOGIC;
        finish_sig: IN STD_LOGIC;
        q:          IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        addr_t2:    IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        data_t2:    IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        wren_t2:    IN STD_LOGIC;
        addr:       OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        data_mem:   OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        wren:       OUT STD_LOGIC
    );
   END COMPONENT;

    -- clock and reset signals  
	 signal clk, reset_n, 
            wren, wren_t2, finish_sig: std_logic;	

    --define the wires	
    signal address,
           address_t2,
           data,
           data_t2,
           q: std_logic_vector (7 downto 0);
     

begin

    clk <= CLOCK_50;
    reset_n <= KEY(3);
    
    -- Instance of the Task1_forloop
    T1_flp: T1_forloop port map (clk, address_t2, data_t2, wren_t2, finish_sig);

    -- Instance of the Task2a_forloop
    T2_flp: T2a_forloop port map (clk, finish_sig, q, address_t2, data_t2, wren_t2, address, data, wren );

    -- Instance of the memory
    mem: s_memory port map (address, clk, data, wren, q);

end RTL;


