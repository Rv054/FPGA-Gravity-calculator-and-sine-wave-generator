-- -------------------------------------------------------
-- The files contains Baudrate generator Entity.
-- Author :- Rishi Vaghasiya (35869)
-- Wintersemester 2023/24
-- -------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
-- add package here for the values of constants.

entity rv_baudrate_e is
    generic(
        -- the constant values will be shifted to the package once created
        
        -- max baudrate counter
        br_max_cnt_c    : integer := 16383;

        -- 9600 baudrate
        b96_g           : integer := 13021;
        b96_2_g         : integer := 6511 ;

        -- 19200 baudrate
        b192_g          : integer := 6510 ;
        b192_2_g        : integer := 3255);

    port (
        clk_i        : in  std_logic;   -- Base clock - 125MHz clock
        rst_i        : in  std_logic;   -- Reset
        br_start_i   : in  std_logic;   -- Start the counter
        baud_rate_i  : in  std_logic;   -- Input to select the baud rate (0 for 9600, 1 for 19200)
        br_2_o       : out std_logic;   -- Half of the bit period
        brx_o        : out std_logic;   -- Begin of the bit period
        test_o       : out std_logic);  -- Monitor

end rv_baudrate_e;
