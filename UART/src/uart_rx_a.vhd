-- -------------------------------------------------------
-- The files contains UART Receiver architecture.
-- Author :- Rishi Vaghasiya (35869)
-- Wintersemester 2023/24
-- -------------------------------------------------------

architecture rv_UART_RX_a of rv_UART_RX_e is 

	type state_t is (idle_st, start_st, wait_st,
					 stop_st, rst_st, parity_st, 
					 br_st, bit0_st, bit1_st, 
					 bit2_st, bit3_st, bit4_st,
					 bit5_st, bit6_st, bit7_st);
			  
	signal c_state_s, nxt_state_s := state_t;
	
	signal rx_rise_s		: std_logic;
	signal rx_fall_s		: std_logic;
	signal rx_delay_s		: std_logic_vector(1 downto 0);
	signal rx_riseedge_s	: std_logic;
	signal rx_falledge_s	: std_logic;
	signal rx_rdy_s			: std_logic;
	signal rx_ascii_s		: std_logic_vector(7 downto 0);
	signal rx_ascii2_s		: std_logic_vector(7 downto 0);

	begin
		rx_falledge: process(clk_i, rst_i) 
		begin
			if (rst_i = '0') then
				rx_delay_s	<= (others => '0')
			elsif(clk_i'event and clk_i = '1') then
				rx_delay_s(1)	<= rx_delay_s(0);
				rx_delay_s(0)	<= rx_i;
			end if;
		end process;
		rx_falledge_s	<= (not rx_delay_s(0) and rx_delay_s(1));
	
		rx_process: process(c_state_s, rx_falledge_s, br_i, br2_i, rx_i)
		begin
			nxt_state_s <= c_state_s;
			case c_state_s is
				when rst_st		=> nxt_state_s <= idle_st;
				when idle_st	=> if (rx_fall_s = '1') then
									nxt_state_s <= br_st;
									end if;
				when br_st		=> nxt_state_s <= wait_st;
				when wait_st	=> if (br_i = '1') then
									nxt_state_s <= br_st;
									end if;
				when start_st	=> if (br_i = '1') then
									nxt_state_s <= bit0_st;
									end if;
				when bit0_st    => if (br_i = '1') then 
									nxt_state_s <= bit1_st;
									end if;
											
				when bit1_st    => if (br_i = '1') then 
									nxt_state_s <= bit2_st;
									end if;
												
				when bit2_st    => if (br_i = '1') then 
									nxt_state_s <= bit3_st;
									end if;
													
				when bit3_st    => if (br_i = '1') then 
									nxt_state_s <= bit4_st;
									end if;
													
				when bit4_st    => if (br_i = '1') then 
									nxt_state_s <= bit5_st;
									end if;
													
				when bit5_st    => if (br_i = '1') then 
									nxt_state_s <= bit6_st;
									end if;
													
				when bit6_st    => if (br_i = '1') then 
									nxt_state_s <= bit7_st;
									end if;
													
				when bit7_st    => if (br_i = '1') then 
									nxt_state_s <= stop_st;
									end if;
													
				when stop_st 	=> if (br2_i = '1') then 
									nxt_state_s <= idle_st;
									end if;
				when others		=> nxt_state_s <= rst_st;
			end case;
		end process;

		rx_rdy_s	<= '1' when (c_state_s = stop_st) else '0';

		rx_riseedge : process(clk_i, rst_i)
		begin
			if(rst_i = '0') then
				rx_delay_s <= (others => '0');
			else if(clk_i'event and clk_i = '1') then
				rx_delay_s(1) <= rx_delay_s(0);
				rx_delay_s(0) <= rx_rdy_s;
			end if;
		end process;

		rx_riseedge_s <= (not rx_delay_s(1) and rx_delay_s(0));
		rx_falledge_s <= (not rx_delay_s(0) and rx_delay_s(1));

		rx_rdy_s	<=	rx_falledge_s;
		cry_o		<=	'1' when (c_state_s = br_st) else '0';

		process(clk_i, rst_i)
		begin
			if(rst_i = '0') then
				rx_ascii2_s	<=	(others	=>	'0');
			
			elsif(clk_i'event and clk_i = '1') then
				if(c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(0)	<=	rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(1) <= rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(2) <= rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(3) <= rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(4) <= rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(5) <= rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(6) <= rx_i;
				end if;
				if (c_state_s = bit0_st and br2_i = '1') then
					rx_ascii2_s(7) <= rx_i;
				end if;
			 end if;
		   end process;

	rx_synchronization	:	process (clk_i, rst_i)
	begin
		if(rst_i = '0') then
			rx_ascii_s	<=	(others =>	'0');
		elsif(clk_i'event and clk_i = '1') then
		if(rx_riseedge_s = '1') then
			rx_ascii_s	<=	rx_ascii2_c;
		end if;
		end if;
	end process;

	ascii_o	<= rx_ascii_s;

end rv_UART_RX_a;
