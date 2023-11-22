library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_rv_UART_TX_e is
end tb_rv_UART_TX_e;

architecture tb_rv_UART_TX_a of tb_rv_UART_TX_e is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1'; -- Active low reset
    signal br_clk : std_logic := '0'; -- Baud rate clock
    signal ascii_data : std_logic_vector(7 downto 0) := "01001001"; -- ASCII 'I'
    signal en : std_logic := '0'; -- Enable signal
    signal tx_o : std_logic;

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
    COMPONENT rv_UART_TX
        port (
            clk_i    : in  std_logic;
            rst_i    : in  std_logic;
            br_clk_i : in  std_logic;
            ascii_i  : in  std_logic_vector(7 downto 0);
            en_i     : in  std_logic;
            tx_o     : out std_logic
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

        -- Test scenario 1: Baud rate 1
        en <= '1';
        wait for 50 ns;
        en <= '0';

        -- Test scenario 2: Baud rate 2
        br_clk <= not br_clk; -- Toggle baud rate clock
        wait for 50 ns;

        -- Add more test scenarios as needed

        wait;
    end process;

    -- Instantiate the DUT
    UUT: rv_UART_TX
        port map (
            clk_i    => clk,
            rst_i    => rst,
            br_clk_i => br_clk,
            ascii_i  => ascii_data,
            en_i     => en,
            tx_o     => tx_o
        );

    -- Monitor process
    process
    begin
        wait for 10 ns; -- Initial wait
        while now < 1000 ns loop
            -- Monitor the tx_o signal
            if (tx_o = '1') then
                report "Transmitted data is 1";
            else
                report "Transmitted data is 0";
            end if;
            wait for 10 ns; -- Check every 10 ns
        end loop;
        wait;
    end process;

end tb_rv_UART_TX_a;
