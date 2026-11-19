library IEEE;
    use IEEE.std_logic_1164.all;

-- Convolutional Codes Generator entity
entity CNV is
    generic (
        K : positive := 11,
        A_BUFFER_LENGTH : positive := 5,
        C_BUFFER_LENGTH : positive := 8,
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

architecture BEH of CNV is 

    -- Signals --

    -- Signal in output to "a" buffer
    signal a_dff_out : positive := 5;

    -- Signal in output to "c" buffer
    signal c_dff_out : positive := 10;

    -- Declare component DFF_N
    component DFF_N is
        generic ( N : natural := 8 );
        port (
            clk     : in std_logic;
            a_rst_n : in std_logic;
            en      : in std_logic;
            d       : in std_logic;
            q       : out std_logic_vector(N - 1 downto 0)
        );
    end component;

begin

end architecture;