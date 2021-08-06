library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
use work.myTypes.all;
use ieee.std_logic_arith.all;


--devo fare il comparator
entity comparator is
	Port (	DATA1:	In	std_logic_vector(numBit-1 downto 0);
		DATA2i:	In	std_logic;
		tipo :In aluOp;
		OUTALU:	Out	std_logic_vector(numBit-1 downto 0));
end comparator;

architecture Architectural of comparator is


signal s_i: integer;
--signal Cin_i: std_logic;
--signal Cout_i:std_logic
begin
--s_i <='0';
--gen: for i in 0 to numbit-1 generate
--			s_i <= s_i or data1(i);	--xor op
--	end generate; 

comparator_proc: process (data1, data2i, tipo)
begin
	--variable s_i : integer;
	s_i <= conv_integer(unsigned(data1));
	--Cin_i<='1';
	--data2i<= not(data2);
	--s_i <= '0' or data1(0);	--	
	--for i in 1 to numbit-1 loop
	--		s_i <= s_i or data1(i);	--xor op
	--end loop; 
	case tipo is
		when SEQ | SEQI => if conv_integer(unsigned(data1))=0 then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		when SLT | SLTI | SLTU |SLTUI  => if data2i = '0' then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SGT | SGTI | SGTUI |SGTU  =>  if data2i = '1' and conv_integer(unsigned(data1))=0 then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SGE| SGEI | SGEUI |SGEU=> if data2i = '1' then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SNE | SNEI => if conv_integer(unsigned(data1))/=0 then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SLE | SLEI => if conv_integer(unsigned(data1))=0 and data2i = '0' then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		when others => null;
    end case; 
 end process comparator_proc;
end Architectural;
