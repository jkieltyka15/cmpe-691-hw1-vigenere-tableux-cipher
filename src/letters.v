/**
 * File: letters.v
 *
 * Contains helpful functions for checking the case of characters,
 * as well as character case conversion functions.
 */

`ifndef _LETTERS_V_
`define _LETTERS_V_

`include "constants.v"

/**
 * Checks to see if an ASCII character is a lower case letter.
 * 
 * @param character - The character to check if it is lower case.
 * 
 * @return 1 if character is lower case. Otherwise 0.
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
 *
 * @param character - The character to check if it is UPPER CASE.
 *
 * @return 1 if the caracter is UPPER CASE. Otherwise 0.
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
 *
 * @param character - The character to convert to UPPER CASE.
 *
 * @return The UPPER CASE version of a lower case character.
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
 *
* @param character - The character to convert to lower case.
 *
 * @return The lower case version of a UPPER CASE character.
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