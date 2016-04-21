----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:30:30 04/20/2016 
-- Design Name: 
-- Module Name:    Sonar - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sonar is
    Port ( clk : in  STD_LOGIC;
           trigger_pin : out  STD_LOGIC;
           echo_pin : in  STD_LOGIC;
           LED0 : out  STD_LOGIC);
end Sonar;

architecture Behavioral of Sonar is

signal count : std_logic_vector (23 downto 0);
constant setPulseTrigg : std_logic_vector(13 downto 0) := "10100100000100"; --10us + 200us
constant readTime : std_logic_vector (20 downto 0) := "111001111110111100000"; --38ms
signal echoTime : std_logic_vector (20 downto 0);  --time for echo to return to echo pin


begin

TriggerTimer : Process (clk)        --TRIGGER SET 10us to set, then 200us for bursts
Begin
	if (clk'event and clk = '1') then
		if(count > setPulseTrigg) then    --Reset timer and trigger
			trigger_pin <= '0';
			count <= (others => '0');
		else
			trigger_pin <= '1';			--Trigger on and timer counting to 10us
			count <= std_logic_vector(unsigned(count) + 1 );
		end if;
	end if;
end process TriggerTimer;


EchoTimer : Process (clk, echo_pin)	--Determine echo read time
Begin
	if(clk'event and clk = '1') then
		if(echo_pin = '1') then
			echoTime <= std_logic_vector(unsigned(echoTime) + 1);
		else
			echoTime <= (others => '0');
		end if;
	end if;
end process EchoTimer;

CheckLED : Process (clk)					--If read time is longer than 38ms turn off LED
Begin
	if(echoTime < readTime) then
		LED0 <= '1';
	else
		LED0 <= '0';
	end if;
end process CheckLED;

end Behavioral;

