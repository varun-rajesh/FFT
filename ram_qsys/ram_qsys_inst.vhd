	component ram_qsys is
		port (
			clk_clk         : in  std_logic                     := 'X';             -- clk
			ram_address     : in  std_logic_vector(13 downto 0) := (others => 'X'); -- address
			ram_byte_enable : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- byte_enable
			ram_read        : in  std_logic                     := 'X';             -- read
			ram_write       : in  std_logic                     := 'X';             -- write
			ram_write_data  : in  std_logic_vector(63 downto 0) := (others => 'X'); -- write_data
			ram_acknowledge : out std_logic;                                        -- acknowledge
			ram_read_data   : out std_logic_vector(63 downto 0);                    -- read_data
			reset_reset_n   : in  std_logic                     := 'X'              -- reset_n
		);
	end component ram_qsys;

	u0 : component ram_qsys
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --   clk.clk
			ram_address     => CONNECTED_TO_ram_address,     --   ram.address
			ram_byte_enable => CONNECTED_TO_ram_byte_enable, --      .byte_enable
			ram_read        => CONNECTED_TO_ram_read,        --      .read
			ram_write       => CONNECTED_TO_ram_write,       --      .write
			ram_write_data  => CONNECTED_TO_ram_write_data,  --      .write_data
			ram_acknowledge => CONNECTED_TO_ram_acknowledge, --      .acknowledge
			ram_read_data   => CONNECTED_TO_ram_read_data,   --      .read_data
			reset_reset_n   => CONNECTED_TO_reset_reset_n    -- reset.reset_n
		);

