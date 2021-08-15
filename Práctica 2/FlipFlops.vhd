LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY flipflops IS PORT(
	CLK,CLR,PRE,D,J,K,T,S,R:IN STD_LOGIC;
	SEL : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	Q,NQ: INOUT STD_LOGIC
);
END flipflops;

ARCHITECTURE A_flipflops OF flipflops IS
BEGIN
	PROCESS(CLK,CLR,PRE,D,J,K,T,S,R)
	BEGIN
		IF(CLR='0')THEN
			Q<='0';
			NQ<= '1';
		ELSIF (CLK'EVENT AND CLK='1')THEN
			IF(PRE='1')THEN
				Q<='1';
				NQ<= '0';
			ELSIF(SEL="00")THEN
				IF(D='0')THEN
					Q<='0';
					NQ<= '1';
				ELSE
					Q<='1';
					NQ<= '0';
				END IF;
			ELSIF(SEL="01") THEN
				Q<=S OR(NOT R AND Q);
	 		    NQ<=NOT(S OR(NOT R AND Q));
			ELSIF(SEL="10") THEN
				Q<=(J AND NOT Q)OR(NOT K AND Q);
	 		    NQ<=NOT((J AND NOT Q)OR(NOT K AND Q));
			ELSIF(SEL="11")THEN
				Q<=T XOR Q;
	 		    NQ<=NOT(T XOR Q);
			END IF;
		END IF;
	END PROCESS;
END A_flipflops;