-- -------------------------------------------------------
-- The files contains UART Transmitter architecture.
-- Author :- Rishi Vaghasiya (35869)
-- Wintersemester 2023/24
-- -------------------------------------------------------

architecture of rv_UART_TX_a of rv_UART_TX_e is 

type state_t is (start_st, rst_st, wait_st
                 stop_st, bit0_st, bit1_st
                 bit2_st, bit3_st, bit4_st
                 bit5_st, bit6_st, bit7_st);

signal c_state_s, nxt_state_s : state_t;

signal tx_finish_s         : std_logic;
signal tx_finish_delay_s   : std_logic_vector(1 downto 0);
signal tx_falledge_s       : std_logic;
signal tx_in_s             : std_logic_vector(7 downto 0);
signal tx_data_s           : std_logic_vector(7 downto 0);

begin
    tx_in_s <= ascii_i;

    process(clk_i, rst_i)
    begin
        if(rst_i = '0') then
            tx_data_s   <= (others => '0');
            else if (clk_i'event and clk_i = '1') then
                if (en_i = '1') then
                    tx_data_s   <= tx_in_s;
                end if;
            end if;
        end process;

    process(clk_i, rst_i)
    begin
        if (rst_i = '0') then
            c_state_s     <= rst_st;
        elsif (clk_i'event and clk_i = '1') then
            c_state_s   <= nxt_state_s;
        end if;
    end process;

    process(c_state_s, en_i, br_clk_i)
    begin
        nxt_state_s <= c_state_s;
        case c_state_s is
             when rst_st    =>  if(en_i = '1') then
                                nxt_state_s <= wait_st;
                                end if;
             when wait_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= c_start_st;
                                end if;
             when c_start_st=>  if (br_clk_i = '1') then
                                nxt_state_s <= bit0_st;
                                end if;
                                       
             when bit0_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit1_st;
                                end if;
                                       
             when bit1_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit2_st;
                                end if;
                                       
             when bit2_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit3_st;
                                end if;
               
             when bit3_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit4_st;
                                end if;
                                       
             when bit4_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit5_st;
                                end if;
                                       
             when bit5_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit6_st;
                                end if;
                                       
             when bit6_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= bit7_st;
                                end if;
                                       
             when bit7_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= stop_st;
                                end if;
                                       
             when stop_st   =>  if (br_clk_i = '1') then
                                nxt_state_s <= rst_st;
                                end if;
                                       
             when others    => nxt_state_s <=  rst_st;
               
           end case;
       end process;

       tx_o <=  '1' when ( (c_state_s = stop_st) or
                           (c_state_s = wait_st) or
                           (c_state_s = rst_st)) else
                '0' when ( (c_state_s = start_st) ) else
                
                tx_data_s(0) when (c_state_s = bit0_st) else
                tx_data_s(1) when (c_state_s = bit1_st) else
                tx_data_s(2) when (c_state_s = bit2_st) else
                tx_data_s(3) when (c_state_s = bit3_st) else
                tx_data_s(4) when (c_state_s = bit4_st) else
                tx_data_s(5) when (c_state_s = bit5_st) else
                tx_data_s(6) when (c_state_s = bit6_st) else
                tx_data_s(7) when (c_state_s = bit7_st) else
                '1';
        tx_finish_s <= '1' when (c_state_s = stop_st) else '0';
        process(clk_i, rst_i)
        begin
            if (rst_i = '0') then
                tx_finish_delay_s <= (others => '0'); 
            elsif (clk_i'event and clk_i = '1') then
                tx_finish_delay_s(0) <= tx_finish_s;
                tx_finish_delay_s(1) <= tx_finish_delay_s(0);
            end if;
        end process;

end rv_UART_TX_a;
