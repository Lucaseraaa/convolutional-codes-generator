library IEEE;
    use IEEE.std_logic_1164.all;

-- Convolutional Codes Generator entity
entity CONV is

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

architecture BEH of CONV is 

    -- A and C buffer
    -- signal a_buffer : std_logic_vector(4 downto 0);
    -- signal c_buffer : std_logic_vector(10 downto 0);


begin

    p_CONV: process(clk, rst)

    begin

        if rst = '0' then

            -- Reset
            a_k_out <= '0';
            c_k <= '0';
            o_valid <= '0';

        elsif rising_edge(clk) then
            
            -- Base setup o_valid to 0
            o_valid <= '0';

            -- Valid input
            if i_valid = '1' then
                
                -- Update de redundancy bit
                c_k <= not a_k_in;
                a_k_out <= a_k_in;
                o_valid <= '1';

            end if;
        
        end if;

    end process;


end architecture;