library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_rv_baudrate_e is
end tb_rv_baudrate_e;

architecture tb_rv_baudrate_a of tb_rv_baudrate_e is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1'; -- Active low reset
    signal br_start : std_logic := '0'; -- Start the counter
    signal baud_rate : std_logic := '0'; -- Baud rate selection (0 for 9600, 1 for 19200)
    signal br_2_o, brx_o, test_o : std_logic;

    -- Clock process
    process
    begin
        wait for 5 ns; -- Initial wait
        while now < 1000 ns loop
            clk <= not clk;
            wait for 5 ns; -- Clock period
        end loop;
        wait;
    end process;

    -- DUT instantiation
    COMPONENT rv_baudrate_e
        generic (
            br_max_cnt_c : integer := 16383;
            b96_g        : integer := 13021;
            b96_2_g      : integer := 6511 ;
            b192_g       : integer := 6510 ;
            b192_2_g     : integer := 3255
        );
        port (
            clk_i        : in  std_logic;
            rst_i        : in  std_logic;
            br_start_i   : in  std_logic;
            baud_rate_i  : in  std_logic;
            br_2_o       : out std_logic;
            brx_o        : out std_logic;
            test_o       : out std_logic
        );
    end COMPONENT;

    -- Stimulus process
    process
    begin
        wait for 10 ns; -- Initial wait

        -- Reset sequence
        rst <= '0';
        wait for 20 ns;
        rst <= '1';

        -- Test scenario 1: 9600 baud rate
        baud_rate <= '0';
        br_start <= '1';
        wait for 50 ns;
        br_start <= '0';

        -- Test scenario 2: 19200 baud rate
        baud_rate <= '1';
        br_start <= '1';
        wait for 50 ns;
        br_start <= '0';

        -- Add more test scenarios as needed

        wait;
    end process;

    -- Instantiate the DUT
    UUT: rv_baudrate_e
        generic map (
            br_max_cnt_c : 16383,
            b96_g        : 13021,
            b96_2_g      : 6511,
            b192_g       : 6510,
            b192_2_g     : 3255
        )
        port map (
            clk_i        => clk,
            rst_i        => rst,
            br_start_i   => br_start,
            baud_rate_i  => baud_rate,
            br_2_o       => br_2_o,
            brx_o        => brx_o,
            test_o       => test_o
        );

end tb_rv_baudrate_a;
