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
        rst     : in std_logic; -- active-low
        
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

    -- Signal in input/output to "a" buffer
    signal a_dff_in  : std_logic;
    signal a_dff_out : std_logic_vector(4 downto 0);

    -- Signal in input/output to "c" buffer
    signal c_dff_in  : std_logic;
    signal c_dff_out : std_logic_vector(9 downto 0);

    -- Declare component DFF_N
    component DFF_N is
        generic ( N : natural := 8 );
        port (
            clk     : in std_logic;
            arstn   : in std_logic;
            en      : in std_logic;
            d       : in std_logic;
            q       : out std_logic_vector(N - 1 downto 0)
        );
    end component;

begin

    -- DFF of last occours of a
    DFF_A_BUFFER : DFF_N
        generic map (M => A_BUFFER_LENGHT)
        port map(
            clk => clk,
            arstn => rst,
            en => i_valid,
            d => a_dff_in,
            q => a_dff_out
        );
    
    -- DFF of last occours of c
    DFF_A_BUFFER : DFF_N
        generic map (M => C_BUFFER_LENGHT)
        port map(
            clk => clk,
            arstn => rst,
            en => i_valid,
            d => c_dff_in,
            q => c_dff_out
        );
    
    

end architecture;