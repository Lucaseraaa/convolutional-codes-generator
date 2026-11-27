library IEEE;
    use IEEE.std_logic_1164.all;

-- Convolutional Codes Generator entity
entity CONV is

    generic (
        K : positive := 11;
        A_BUFFER_LENGTH : positive := 5;
        C_BUFFER_LENGTH : positive := 11
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
    signal a_buffer : std_logic_vector(A_BUFFER_LENGTH - 1 downto 0);
    signal c_buffer : std_logic_vector(C_BUFFER_LENGTH - 1 downto 0);


begin

    p_CONV: process(clk, rst)
        variable xor_result : std_logic;
    begin
        xor_result := '0';

        if rst = '0' then

            -- Reset
            a_k_out <= '0';
            c_k <= '0';
            o_valid <= '0';
            a_buffer <= (others => '0');
            c_buffer <= (others => '0');

        elsif rising_edge(clk) then
            
            -- Base setup o_valid to 0
            o_valid <= '0';

            -- Valid input
            if i_valid = '1' then
                
                -- xor combination result
                xor_result := c_buffer(7) xor c_buffer(9) xor a_k_in xor a_buffer(2) xor a_buffer(3); 
                
                -- Update de redundancy bit
                c_k <= xor_result;
                o_valid <= '1';
                a_k_out <= a_k_in;

                -- Update the buffer value
                a_buffer <= a_buffer(A_BUFFER_LENGTH - 2 downto 0) & a_k_in;
                c_buffer <= c_buffer(C_BUFFER_LENGTH - 2 downto 0) & xor_result;

            end if;
        
        end if;

    end process;


end architecture;