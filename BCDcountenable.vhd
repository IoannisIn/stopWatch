Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;
Entity BCDcountenable Is
	Port 
	(
		clock, reset, enable, E : In STD_LOGIC;
		carry                   : Out STD_LOGIC;
		BCD0                    : Buffer STD_LOGIC_VECTOR(3 Downto 0));

End BCDcountenable;
Architecture Behavior Of BCDcountenable Is
Begin
	Process (clock)
	Begin
		If (clock'EVENT And clock = '1') Then
			If Reset = '1' Then
				BCD0 <= "0000";
			Elsif E = '1' Then
				If BCD0 = "1001" Then
					BCD0  <= "0000";
					Carry <= '1';
				Else
					BCD0  <= BCD0 + '1';
					carry <= '0';
				End If;
			End If;
		End If;
	End Process;
End Behavior;