library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_rv_UART_RX_e is
end tb_rv_UART_RX_e;

architecture tb_rv_UART_RX_a of tb_rv_UART_RX_e is
    signal clk : std_logic := '0';
    signal rst : std_logic := '1'; -- Active low reset
    signal br_i : std_logic := '0'; -- Baudrate signal
    signal br2_i : std_logic := '0'; -- Baudrate 2 signal
    signal rx_i : std_logic := '1'; -- Start with idle state

    signal cry_o : std_logic;
    signal ascii_o : std_logic_vector(7 downto 0);
    signal rx_o : std_logic;

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
    COMPONENT rv_UART_RX
        port (
            clk_i    : in  std_logic;
            rst_i    : in  std_logic;
            br_i     : in  std_logic;
            br2_i    : in  std_logic;
            rx_i     : in  std_logic;
            cry_o    : out std_logic;
            ascii_o  : out std_logic_vector(7 downto 0);
            rx_o     : out std_logic
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

        -- Test scenario 1: Baudrate 1, sending ASCII 'A'
        br_i <= '1';
        br2_i <= '0';
        rx_i <= '0'; -- Start bit
        wait for 10 ns;
        rx_i <= '1'; -- ASCII 'A' (01000001) - 8 bits
        wait for 50 ns;

        -- Test scenario 2: Baudrate 2, sending ASCII 'B'
        br_i <= '0';
        br2_i <= '1';
        rx_i <= '0'; -- Start bit
        wait for 10 ns;
        rx_i <= '1'; -- ASCII 'B' (01000010) - 8 bits
        wait for 50 ns;

        -- Add more test scenarios as needed

        wait;
    end process;

    -- Instantiate the DUT
    UUT: rv_UART_RX
        port map (
            clk_i   => clk,
            rst_i   => rst,
            br_i    => br_i,
            br2_i   => br2_i,
            rx_i    => rx_i,
            cry_o   => cry_o,
            ascii_o => ascii_o,
            rx_o    => rx_o
        );

end tb_rv_UART_RX_a;
