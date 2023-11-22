library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_rv_baudrate_e is
end tb_rv_baudrate_e;

architecture tb_rv_baudrate_a of tb_rv_baudrate_e is

    component rv_baudrate_e
        port (
            clk_i        : in  std_logic;
            rst_i        : in  std_logic;
            br_start_i   : in  std_logic;
            baud_rate_i  : in  std_logic;
            br_2_o       : out std_logic;
            brx_o        : out std_logic;
            test_o       : out std_logic
        );
    end component;

    constant clk2_t :   time := 10ns;
    signal   clk_s  :   std_logic := '0';
    signal   rst_s  :   std_logic;
    signal   start_s:   std_logic;
    signal   br2_s  :   std_logic;
    signal   brx_s  :   std_logic;
    signal   test_s :   std_logic;

    begin
        DUT : tb_rv_baudrate_e port map (clk_s, rst_s, start_s, br2_s, brx_s, test_s);

        process(clk_s)
        begin
            clk_s <= not clk_s after clk2_t;
        end process;

        process
        begin
            rst_s   <= '0';
            start_s <= '0';
            wait for 4 * clk2_t;
            assert(br2_s  = '0') report "0.) BR RX wrong" severity warning;
            assert(brx_s  = '1') report "0.) BR TX wrong" severity warning;
            assert(test_s = '0') report "0.) Test wrong " severity warning;

            rst_s   <= '1';
            wait for 4 * clk2_t;
            assert(br2_s  = '0') report "1.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "1.) BR TX wrong" severity warning;
            assert(test_s = '0') report "1.) Test wrong " severity warning;

            start_s <= '1';
            wait for 2 * clk2_t;
            start_s <= '0';
            wait for 2 * clk2_t;
            assert(br2_s  = '0') report "2.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "2.) BR TX wrong" severity warning;
            assert(test_s = '1') report "2.) Test wrong " severity warning;

            wait for 2602 * 2 * clk2_t;
            assert(br2_s  = '0') report "3.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "3.) BR TX wrong" severity warning;
            assert(test_s = '0') report "3.) Test wrong " severity warning;
            wait for 2 * clk2_t;
            assert(br2_s  = '1') report "4.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "4.) BR TX wrong" severity warning;
            assert(test_s = '0') report "4.) Test wrong " severity warning;
            wait for 2 * clk2_t;
            assert(br2_s  = '0') report "5.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "5.) BR TX wrong" severity warning;
            assert(test_s = '0') report "5.) Test wrong " severity warning;  
            
            wait for 2602 * 2 * clk2_t;
            assert(br2_s  = '0') report "6.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "6.) BR TX wrong" severity warning;
            assert(test_s = '0') report "6.) Test wrong " severity warning;
            wait for 2 * clk2_t;
            assert(br2_s  = '0') report "7.) BR RX wrong" severity warning;
            assert(brx_s  = '1') report "7.) BR TX wrong" severity warning;
            assert(test_s = '0') report "7.) Test wrong " severity warning;
            wait for 2 * clk2_t;
            assert(br2_s  = '0') report "8.) BR RX wrong" severity warning;
            assert(brx_s  = '0') report "8.) BR TX wrong" severity warning;
            assert(test_s = '1') report "8.) Test wrong " severity warning;

            wait for 2 * 104 us;
            wait for 120 * 2 * clk2_t;
            assert false report "End of Simulation!" severity failure;
        end process;

end tb_rv_baudrate_a;
