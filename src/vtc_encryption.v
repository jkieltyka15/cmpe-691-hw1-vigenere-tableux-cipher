`ifndef _VTC_ENCRYPTION_V_
`define _VTC_ENCRYPTION_V_

`include "letters.v"
`define MAX 10

/**
 * Encrypts a single ASCII character using the Vigenere Tableux Cipher.
 */
function reg[`BYTE] vtc_encrypt(input reg[`BYTE] key, input reg[`BYTE] text);
    begin
        reg[`BYTE] cipher;

        // convert input to lower case
        key[`BYTE] = to_lower(key[`BYTE]);
        text[`BYTE] =  to_lower(text[`BYTE]);
        cipher[`BYTE] = text[`BYTE];

        // calculate cipher character
        if (is_lower(key[`BYTE]) && is_lower(text[`BYTE])) begin
            cipher[`BYTE] -= (key - "a");
            if ("a" > cipher[`BYTE]) begin
                cipher[`BYTE] += 8'h1a;
            end
        end

        vtc_encrypt = cipher[`BYTE];

    end
endfunction

/**
 * Decrypts a single ASCII character using the Vigenere Tableux Cipher.
 */
function reg[`BYTE] vtc_decrypt(input reg[`BYTE] key, input reg[`BYTE] cipher);
    begin
        reg[`BYTE] text;

        // convert input to upper case
        key[`BYTE] = to_upper(key[`BYTE]);
        cipher[`BYTE] =  to_upper(cipher[`BYTE]);
        text[`BYTE] = cipher[`BYTE];

        // calculate cipher character
        if (is_upper(key[`BYTE]) && is_upper(cipher[`BYTE])) begin
            text[`BYTE] += (key - "A");
            if ("Z" < text[`BYTE]) begin
                text[`BYTE] -= 8'h1a;
            end
        end

        vtc_decrypt = text[`BYTE];

    end
endfunction

`endif // _VTC_ENCRYPTION_V_