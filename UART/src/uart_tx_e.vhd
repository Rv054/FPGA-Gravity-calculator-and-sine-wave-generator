-- -------------------------------------------------------
-- The files contains UART Transmitter input-output signals.
-- Author :- Rishi Vaghasiya (35869)
-- Wintersemester 2023/24
-- -------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity rv_UART_TX is 
port 	(
	clk_i		: in  std_logic;
	rst_i		: in  std_logic;
	br_clk_i	: in  std_logic;
	ascii_i		: in  std_logic_vector(7 downto 0); -- ascii input
	en_i		: in  std_logic; -- enable bit
	tx_o		: out std_logic);
end rv_UART_TX;
