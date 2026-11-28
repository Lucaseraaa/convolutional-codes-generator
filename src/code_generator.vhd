library ieee;
  use ieee.std_logic_1164.all;


-- Convolutional Generator

-- This component is generates the redundancty output, using the current input 
-- and the memory bits

entity CONV_GENERATOR is

    generic (
        A_WIDTH : natural := 5;
        C_WIDTH : natural := 10
    );

    port(
        a_in        : in    std_logic; -- Current input
        a_latest    : in    std_logic_vector(A_WIDTH - 1 downto 0); -- input buffer
        c_latest    : in    std_logic_vector(C_WIDTH - 1 downto 0); -- c buffer
        conv_output : out   std_logic
    );

end entity;

architecture BEH of CONV_GENERATOR is 

begin

    conv_output <= (c_latest(8) xor c_latest(10)) xor (a_in xor (a_latest(3) xor a_latest(4)));

end architecture;