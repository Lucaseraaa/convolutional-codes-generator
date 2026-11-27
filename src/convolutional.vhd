library IEEE;
    use IEEE.std_logic_1164.all;

-- Convolutional Codes Generator entity
entity CNV is

    generic (
        K : positive := 11;
        A_BUFFER_LENGHT : positive := 5;
        C_BUFFER_LENGHT : positive := 11
    );
    port (
        -- Signals
        clk     : in std_logic;
        rst     : in std_logic; -- active-low
        
        -- Input data
        a_k_in  : in std_logic;
        i_valid : in std_logic;

        -- Output data
        a_k_out : out std_logic;
        c_k     : out std_logic;
        o_valid : out std_logic

    );

end entity;

architecture BEH of CNV is 

    -- Import shift register
    component SHIFT_REG_N is
        generic (
            WIDTH : natural := 8
        );
        port (
            clk   : in std_logic;
            rst   : in std_logic;
            en    : in std_logic;
            d     : in std_logic;
            q     : out std_logic_vector(WIDTH - 1 downto 0)
        );
    end component;

    -- Import convolutional code generator
    component CONV_GENERATOR is

        generic (
            A_WIDTH : natural := 5;
            C_WIDTH : natural := 10
        );

        port(
            a_in        : in    std_logic; -- Current input
            a_latest    : in    std_logic_vector(A_WIDTH - 1 downto 0); -- input buffer
            c_latest    : in    std_logic_vector(C_WIDTH - 1 downto 0); -- c buffer
            conv_output : out   std_logic;
        );

    end component;

begin
 
    

end architecture;