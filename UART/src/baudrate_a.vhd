-- -------------------------------------------------------
-- The files contains Baudrate generator architecture.
-- Author :- Rishi Vaghasiya (35869)
-- Wintersemester 2023/24
-- -------------------------------------------------------

architecture rv_baudrate_a of rv_baudrate_e is
    
    signal cnt_is    : integer range br_max_cnt_c downto 0;  -- Counter variable
    signal cnt_end_s : integer range br_max_cnt_c downto 0;  -- Stop for the counter
    signal cnt_mid_s : integer range br_max_cnt_c downto 0;  -- Middle of the counter

begin

    process(clk_i, rst_i, baud_rate_i)
    begin
        if (rst_i = '0') then
            cnt_is <= 0;
        elsif (clk_i'event and clk_i = '1') then
            if (cnt_is >= cnt_end_s - 1 or br_start_i = '1') then
                cnt_is <= 0;
            else
                cnt_is <= cnt_is + 1;
            end if;
        end if;

        -- Dynamically set the baud rate parameters
        if baud_rate_i = '0' then
            cnt_end_s <= b96_g;    -- Counter value for 9600 baud rate
            cnt_mid_s <= b96_2_g;  -- Half of the counter for 9600 baud rate
        else
            cnt_end_s <= b192_g;   -- Counter value for 19200 baud rate
            cnt_mid_s <= b192_2_g; -- Half of the counter for 19200 baud rate
        end if;
    end process;

    -- Output signals based on counter value
    br_2_o <= '1' when (cnt_is = cnt_mid_s) else '0';   -- Pulse in the middle of the counter interval
    brx_o  <= '1' when (cnt_is = 0) else '0';           -- Zero crossing, marks the beginning of the baud rate interval
    test_o <= '1' when (cnt_is = 1) else '0';           -- Test signal, possibly for debugging

end rv_baudrate_a;
