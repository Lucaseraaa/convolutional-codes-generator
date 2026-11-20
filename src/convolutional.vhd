library IEEE;
    use IEEE.std_logic_1164.all;

-- Convolutional Codes Generator entity
entity CNV is

    generic (
        K : positive := 11;
        A_BUFFER_LENGHT : positive := 5;
        C_BUFFER_LENGHT : positive := 10
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
        generic map (N => A_BUFFER_LENGHT)
        port map(
            clk => clk,
            arstn => rst,
            en => i_valid,
            d => a_dff_in,
            q => a_dff_out
        );
    
    -- DFF of last occours of c
    DFF_C_BUFFER : DFF_N
        generic map (N => C_BUFFER_LENGHT)
        port map(
            clk => clk,
            arstn => rst,
            en => i_valid,
            d => c_dff_in,
            q => c_dff_out
        );
    

    -- Process used to generate convolutional bit 
    p_CONV: process(clk, rst)

        -- Variable used to keep the xor result
        variable xor_result : std_logic;

    begin

        xor_result := '0';

        if rst = '0' then

            o_valid <= '0';
            a_k_out <= '0';
            c_k <= '0';
            c_dff_in <= '0';
            a_dff_in <= '0';

        elsif rising_edge(clk) then
            
            if i_valid = '1' then

                a_k_out <= a_k_in;
                xor_result := (c_dff_out(0) xor c_dff_out(1)) xor ( a_k_in xor (a_dff_out(0) xor a_dff_out(1))); -- redundancy bit generator
                c_k <= xor_result;

                -- Put the new values in the register
                a_dff_in <= a_k_in;
                c_dff_in <= xor_result;
                
                o_valid <= '1';
            
            else

                -- Next to invalid bit
                o_valid <= '0'; 
                c_k <= '0';

            end if;

        end if;

    end process;
    
    

end architecture;