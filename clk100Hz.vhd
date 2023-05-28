Library IEEE;
Use IEEE.STD_LOGIC_1164.All;

Entity clk100Hz Is
	Port 
	(
		clk_in  : In STD_LOGIC;
		clk_out : Out STD_LOGIC);
End clk100Hz;

Architecture Behavioral Of clk100Hz Is
	Signal temporal : STD_LOGIC;
	Signal counter  : Integer Range 0 To 249999 := 0;
Begin
	frequency_divider : Process (clk_in) Begin
		If (clk_in'EVENT And clk_in = '1') Then
			If (counter = 249999) Then
				temporal <= Not(temporal);
				counter  <= 0;
			Else
				counter <= counter + 1;
			End If;
		End If;
	End Process;
	clk_out <= temporal;
End Behavioral;