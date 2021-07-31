library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.myTypes.all;

entity register_file is
 port ( CLK: 		IN std_logic;
         RESET: 	IN std_logic; --active low
	 ENABLE: 	IN std_logic; --active high
	 RD1: 		IN std_logic;
	 RD2: 		IN std_logic;
	 WR: 		IN std_logic;
	 ADD_WR: 	IN std_logic_vector(REG_SIZE-1 downto 0);
	 ADD_RD1: 	IN std_logic_vector(REG_SIZE-1 downto 0);
	 ADD_RD2: 	IN std_logic_vector(REG_SIZE-1 downto 0);
	 DATAIN: 	IN std_logic_vector(numBit-1 downto 0);
         OUT1: 		OUT std_logic_vector(numBit-1 downto 0);
	 OUT2: 		OUT std_logic_vector(numBit-1 downto 0));
end register_file;

architecture A of register_file is

        subtype REG_ADDR is natural range 0 to numBit-1; -- using natural type
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(numBit-1 downto 0); 
	signal REGISTERS : REG_ARRAY; 
	
begin 
	process (CLK)
	begin
		if CLK'event and CLK='1' then --and enable='1' then
		if reset='0' then
			registers<=(OTHERS=> (others=>'0'));	
			out1<=(others=>'0');
			out2<=(others=>'0');
		else --if CLK'event and CLK='1' and reset='1' then
        if enable='1' then
			if wr='1' then
				registers(to_integer(unsigned(add_wr)))<=datain;
				--bypass
				--if ((add_wr=add_rd1) and (rd1='1')) then 
				--	out1<=datain;
				--end if;
				--if ((add_wr=add_rd2) and (rd2='1')) then 
				--	out2<=datain;
				--end if;
			end if;
			if rd1='1' then
				out1<=registers(to_integer(unsigned(add_rd1)));
			end if;
			if rd2='1' then
				out2<=registers(to_integer(unsigned(add_rd2)));
			end if;

		end if;
		end if;
		end if;
	end process;
end A;

----


configuration CFG_RF_BEH of register_file is
  for A
  end for;
end configuration;
