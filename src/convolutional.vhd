library IEEE;
    use IEEE.std_logic_1164.all;

-- Convolutional Codes Generator entity
entity CNV is
    generic (
        K : positive := 11
    );
    port (
        -- Signals
        clk     : in std_logic;
        rst     : in std_logic;
        
        -- Input data
        a_k_in  : in std_logic;
        i_valid : in std_logic;

        -- Output data
        a_k_out : in std_logic;
        c_k     : out std_logic;
        o_valid : out std_logic;

    );

end entity;