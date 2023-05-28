Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;

Entity TopLevel Is
	Port 
	(
		start, stop, reset, clock_50 : In STD_LOGIC;
		HEX3, HEX2, HEX1, HEX0       : Out STD_LOGIC_VECTOR(6 Downto 0) 
	);
End TopLevel;

Architecture structure Of TopLevel Is
	Component BCDcount
		Port 
		(
			clock, reset, enable : In STD_LOGIC;
			carry                : Out STD_LOGIC;
			BCD                  : Out STD_LOGIC_VECTOR(3 Downto 0));
	End Component;
	Component CLK100Hz
		Port 
		(
			clk_in  : In STD_LOGIC;
			clk_out : Out STD_LOGIC);
	End Component;
	Component HEXdecoder
		Port 
		(
			Digin  : In STD_LOGIC_VECTOR(3 Downto 0);
			Segout : Out STD_LOGIC_VECTOR(6 Downto 0));
	End Component;
	Component fsm
		Port 
		(
			clock, start, stop, reset : In STD_LOGIC;
			clear, enable             : Out STD_LOGIC);
	End Component;
	
	Signal clear, enable, clk100  : STD_LOGIC;
	Signal carry2, carry1, carry0 : STD_LOGIC;
	Signal BCD3, BCD2, BCD1, BCD0 : STD_LOGIC_VECTOR(3 Downto 0);

Begin
	fsm1 : fsm
	Port Map(clock_50, start, stop, reset, clear, enable);
	clkdvd : clk100Hz
	Port Map(clock_50, clk100);
	BCDC0 : BCDcount
	Port Map(clk100, clear, enable, carry0, BCD0);
	BCDC1 : BCDcount
	Port Map(carry0, clear, '1', carry1, BCD1);
	BCDC2 : BCDcount
	Port Map(carry1, clear, '1', carry2, BCD2);
	BCDC3 : BCDcount
	Port Map(carry2, clear, '1', Open, BCD3);
	HEXdecoder1 : HEXdecoder
	Port Map(BCD0, HEX0);
	HEXdecoder2 : HEXdecoder
	Port Map(BCD1, HEX1);
	HEXdecoder3 : HEXdecoder
	Port Map(BCD2, HEX2);
	HEXdecoder4 : HEXdecoder
	Port Map(BCD3, HEX3);
End structure;