/**
 * Converts a lower case ASCII character to UPPER CASE.
 */
function reg[7:0] to_upper(input reg[7:0] character);
    begin
        to_upper[7:0] = character[7:0];
        if (8'h61 <= character[7:0] && 8'h7a >= character[7:0]) begin
            to_upper[7:0] -= 8'h20;
        end
    end
endfunction

/**
 * Converts an UPPER CASE ASCII character to lower case.
 */
function reg[7:0] to_lower(input reg[7:0] character);
    begin
        to_lower[7:0] = character[7:0];
        if (8'h41 <= character[7:0] && 8'h5a >= character[7:0]) begin
            to_lower[7:0] += 8'h20;
        end
    end
endfunction