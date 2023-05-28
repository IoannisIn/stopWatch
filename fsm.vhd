Library ieee;
Use ieee.std_logic_1164.All;
Use ieee.std_logic_unsigned.All;
Entity fsm Is
	Port 
	(
		clock, start, stop, reset : In STD_LOGIC;
		clear, enable             : Out STD_LOGIC);
End fsm;
Architecture Behavior Of FSM Is
	Type state_type Is (nocount, nocountreset, count, countreset);
	Signal y : state_type;
Begin
	Process (clock)
	Begin
		If (clock'EVENT And clock = '1') Then
			Case y Is
				When nocount => 
					If reset = '0' Then
						y <= nocountreset;
					Elsif start = '0' Then
						y <= count;
					Else
						y <= nocount;
					End If;
				When nocountreset => 
					If reset = '1' Then
						y <= nocount;
					Else
						y <= nocountreset;
					End If;
				When count => 
					If reset = '0' Then
						y <= countreset;
					Elsif stop = '0' Then
						y <= nocount;
					Else
						y <= count;
					End If;
				When countreset => 
					If reset = '1' Then
						y <= count;
					Else
						y <= countreset;
					End If;
			End Case;
		End If;
	End Process;
	With y Select
	clear <= '0' When nocount, 
	         '1' When nocountreset, 
	         '0' When count, 
	         '1' When countreset, 
	         '0' When Others;
	With y Select
	enable <= '0' When nocount, 
	          '0' When nocountreset, 
	          '1' When count, 
	          '1' When Others;
End Behavior;