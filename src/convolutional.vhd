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

    -- Signal in input/output to "a" buffer
    signal a_dff_out : std_logic_vector(4 downto 0);

    -- Signal in input/output to "c" buffer
    signal c_dff_out : std_logic_vector(10 downto 0);

    -- Signal used to enable the two DFF_N
    signal en_dff    : std_logic;

    signal c_new     : std_logic;

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

    en_dff <= '1' when (i_valid = '1' and (a_k_in = '0' or a_k_in = '1')) else '0';
    c_new <= c_dff_out(7) xor c_dff_out(9) xor a_k_in xor a_dff_out(2) xor a_dff_out(3);

    -- DFF of last occours of a
    DFF_A_BUFFER : DFF_N
        generic map (N => A_BUFFER_LENGHT)
        port map(
            clk => clk,
            arstn => rst,
            en => en_dff,
            d => a_k_in,
            q => a_dff_out
        );
    
    -- DFF of last occours of c
    DFF_C_BUFFER : DFF_N
        generic map (N => C_BUFFER_LENGHT)
        port map(
            clk => clk,
            arstn => rst,
            en => en_dff,
            d => c_new,
            q => c_dff_out
        );
    

    -- Process used to generate convolutional bit 
    p_CONV: process(clk, rst)

    begin

        if rst = '0' then
            a_k_out <= '0';
            c_k     <= '0';
            o_valid <= '0';
        
        elsif rising_edge(clk) then

            o_valid <= en_dff;           
            
            if en_dff = '1' then
                
                a_k_out <= a_k_in;
                c_k     <= c_new;
            
            end if;
        
        end if;

    end process;
    
    

end architecture;