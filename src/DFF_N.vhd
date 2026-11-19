library ieee;
  use ieee.std_logic_1164.all;

-- D-Flip-Flop: code taken in the Teams of the course

-- Modifications: I only need to use this DFF_N to put the first value on top of the
-- array and take a fixed value of output

entity DFF_N is
  generic (
    N : natural := 8
  );
  port (
    clk   : in std_logic;
    arstn : in std_logic;
    en    : in std_logic;
    d     : in std_logic;
    q     : out std_logic_vector(N - 1 downto 0)
  );
end entity;

architecture struct of DFF_N is
begin

  p_DFF_N : process(clk, arstn)
  begin
    if arstn = '0' then
      q <= (others => '0');
    elsif rising_edge(clk) then
      if en = '1' then
        
        -- Get d on the first position
        q <= q(N-2 downto 0) & d;
        
      end if;
    end if;
  end process;

end architecture;
