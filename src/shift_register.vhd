library ieee;
  use ieee.std_logic_1164.all;

-- Shift Register: code taken in the Teams of the course

-- Change: I only need to use this DFF_N to put the first value on top of the
-- array and take a fixed value of output

entity SHIFT_REG_N is
  generic (
    WIDTH : natural := 8
  );
  port (
    clk   : in std_logic;
    rst : in std_logic;
    en    : in std_logic;
    d     : in std_logic;
    q     : out std_logic_vector(WIDTH - 1 downto 0)
  );
end entity;

architecture struct of SHIFT_REG_N is
 
  signal q_int : std_logic_vector(WIDTH - 1 downto 0);

begin

  p_SHIFT_REG_N : process(clk, arstn)
  begin
    if rst = '0' then
      
      q_int <= (others => '0');
    
    elsif rising_edge(clk) then

      if en = '1' then
        
        -- Get d on the first position
        q_int <= q_int(N - 2 downto 0) & d;
        
      end if;
    end if;
  end process;

  q <= q_int;

end architecture;
