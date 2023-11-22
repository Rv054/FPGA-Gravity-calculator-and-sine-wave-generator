library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_rv_UART_RX_e is
end tb_rv_UART_RX_e;

architecture tb_rv_UART_RX_a of tb_rv_UART_RX_e is

    signal clk_s  : std_logic := '0';
    signal rst_s  : std_logic := '1'; -- Active low reset
    signal br_s   : std_logic := '0'; -- Baudrate signal
    signal br2_s  : std_logic := '0'; -- Baudrate 2 signal
    signal rx_s   : std_logic := '1'; -- Start with idle state

    signal cry_s    : std_logic;
    signal ascii_s  : std_logic_vector(7 downto 0);
    signal rx_s     : std_logic;

    COMPONENT rv_UART_RX_e
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

    begin
        UUT : tb_rv_UART_RX_e port map (clk_s, rst_s, br_s, br2_s, rx_s, cry_s, ascii_s, rx_s);

        process
        begin


end tb_rv_UART_RX_a;
