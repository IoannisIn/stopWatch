Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;

Entity BCDcount Is
	Port 
	(
		Clock  : In STD_LOGIC;
		Reset  : In STD_LOGIC;
		Enable : In STD_LOGIC;
		Carry  : Out STD_LOGIC;
		BCD    : Out STD_LOGIC_VECTOR(3 Downto 0));

End BCDcount;

Architecture Behavior Of BCDcount Is
	Signal count : std_logic_vector(3 Downto 0);
Begin
	Process (Reset, Clock)
	Begin
		If Reset = '1' Then
			count <= "0000";
			Carry <= '0';
		Elsif Clock'EVENT And Clock = '1' Then
			If Enable = '1' Then
				If count = "1001" Then
					count <= "0000";
					Carry <= '1';
				Else
					count <= count + 1;
					Carry <= '0';
				End If;
			End If;
		End If;
	End Process;
	BCD <= count;
End Behavior;