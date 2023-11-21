-- -------------------------------------------------------
-- The files contains UART Receiver input-output signals.
-- Author :- Rishi Vaghasiya (35869)
-- Wintersemester 2023/24
-- -------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity rv_UART_RX is 
port 	(
	clk_i	: in  std_logic;
	rst_i	: in  std_logic;
	br_i	: in  std_logic; -- baudrate 1
	br2_i	: in  std_logic;
	rx_i	: in  std_logic;
	cry_o	: out std_logic; -- carry out bit for baudrate generation
	rx_o	: out std_logic);
end rv_UART_RX;
