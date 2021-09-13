library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.myTypes.all;


entity logic is
  generic (N : integer := numBit);
  port 	 ( 	FUNC: IN aluOp;
           DATA1, DATA2: IN std_logic_vector(N-1 downto 0);
           OUT_ALU: OUT std_logic_vector(N-1 downto 0));
end logic;



architecture Architectural of logic is
signal nand1,nand2,nand3,nand4:std_logic_vector(N-1 downto 0);
signal s:std_logic_vector (3 downto 0);
begin
	P_ALU: process (func, DATA1, DATA2)

	 begin
		case func is
			
			when XORR|XORI => s<= "0110";
			when ANDR|ANDI => s<= "0001";
			when ORR|ORI =>	s<= "0111";
			
			--when ANDR => gen_and: for i in 0 to N-1 loop
			--						OUTPUT_alu_i(i) <= DATA1(i) and DATA2(i); 	-- and op
			--				 end loop;  
			--when ORR  => gen_or: for i in 0 to N-1 loop
			--						OUTPUT_alu_i(i) <= DATA1(i) or DATA2(i);    	-- or op
			--				 end loop; 
			--when XORR => gen_xor: for i in 0 to N-1 loop
			--						OUTPUT_alu_i(i) <= DATA1(i) xor DATA2(i);	--xor op
			--				 end loop; 
			--when ANDI => gen_and1: for i in 0 to N-1 loop
			--						OUTPUT_alu_i(i) <= DATA1(i) and DATA2(i); 	-- and op
			--				 end loop;  
			--when ORI  => gen_or1: for i in 0 to N-1 loop
			--						OUTPUT_alu_i(i) <= DATA1(i) or DATA2(i);    	-- or op
			--				 end loop; 
			--when XORI => gen_xor1: for i in 0 to N-1 loop
			--						OUTPUT_alu_i(i) <= DATA1(i) xor DATA2(i);	--xor op
			--				 end loop; 
			gen_1: for i in 0 to N-1 loop
				nand1(i)<=not (s(3) and (not(data1(i))) and (not(data2(i))) );
				nand2(i)<=not (s(2) and not(data1(i)) and data2(i) );
				nand3(i)<=not (s(1) and data1(i) and not(data2(i)) );
				nand4(i)<=not (s(0) and data1(i) and data2(i) );
				OUT_ALU(i)<= not (nand1(i) and nand2(i) and nand3(i) and nand4(i));
			
			end loop;
			when others => OUT_ALU<=(others =>'0');	
		end case;
	end process;
end Architectural;
					 
