`ifndef _LETTERS_V_
`define _LETTERS_V_

`include "constants.v"

/**
 * Checks to see if an ASCII character is a lower case letter.
 */
function reg is_lower(input reg[`BYTE] character);
    begin
        if ("a" <= character[`BYTE] && "z" >= character[`BYTE]) begin
            is_lower = 1'h1;
        end
        else begin
            is_lower = 1'h0;
        end
    end
endfunction

/**
 * Checks to see if an ASCII character is an UPPER CASE letter.
 */
function reg is_upper(input reg[`BYTE] character);
    begin
        if ("A" <= character[`BYTE] && "Z" >= character[`BYTE]) begin
            is_upper = 1'h1;
        end
        else begin
            is_upper = 1'h0;
        end
    end
endfunction

/**
 * Converts a lower case ASCII character to UPPER CASE.
 */
function reg[`BYTE] to_upper(input reg[`BYTE] character);
    begin
        to_upper[`BYTE] = character[`BYTE];
        if (is_lower(character[`BYTE])) begin
            to_upper[`BYTE] -= 8'h20;
        end
    end
endfunction

/**
 * Converts an UPPER CASE ASCII character to lower case.
 */
function reg[`BYTE] to_lower(input reg[`BYTE] character);
    begin
        to_lower[`BYTE] = character[`BYTE];
        if (is_upper(character[`BYTE])) begin
            to_lower[`BYTE] += 8'h20;
        end
    end
endfunction

`endif // _LETTERS_V_