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

architecture struct of CNV is 

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
            C_WIDTH : natural := 11
        );

        port(
            a_in        : in    std_logic; -- Current input
            a_latest    : in    std_logic_vector(A_WIDTH - 1 downto 0); -- input buffer
            c_latest    : in    std_logic_vector(C_WIDTH - 1 downto 0); -- c buffer
            conv_output : out   std_logic
        );

    end component;

    -- Signal out from buffers
    signal a_buffer_out : std_logic_vector(A_BUFFER_LENGHT - 1 downto 0);
    signal c_buffer_out : std_logic_vector(C_BUFFER_LENGHT - 1 downto 0);

    -- Convolutional bit output
    signal xor_result : std_logic;

begin
 
    -- Buffers

    A_BUFFER : SHIFT_REG_N
    generic map(
        WIDTH => A_BUFFER_LENGHT
    )
    port map (
        clk     => clk,
        rst     => rst,
        en      => i_valid,
        d       => a_k_in,
        q       => a_buffer_out
    ); 

    C_BUFFER : SHIFT_REG_N
    generic map(
        WIDTH => C_BUFFER_LENGHT
    )
    port map (
        clk     => clk,
        rst     => rst,
        en      => i_valid,
        d       => xor_result,
        q       => c_buffer_out
    ); 

    -- Logic
    XOR_LOGIC : CONV_GENERATOR
    port map (
        a_in        => a_k_in,
        a_latest    => a_buffer_out,
        c_latest    => c_buffer_out,
        conv_output => xor_result
    );

    -- Process structure
    p_OUT_REG: process(clk, rst)
    begin
        if rst = '0' then
            a_k_out <= '0';
            c_k     <= '0';
            o_valid <= '0';
        elsif rising_edge(clk) then
            o_valid <= '0';
            if i_valid = '1' then
                a_k_out <= a_k_in;
                c_k     <= xor_result;
                o_valid <= '1';
            end if;
        end if;
    end process;


end architecture;