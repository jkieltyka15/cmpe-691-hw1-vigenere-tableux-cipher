/**
 * File: vtc_encryption.v
 *
 * Contains functions used for the Vigenere Tableux Cipher for
 * encryption, decryption and key cracking.
 */

`ifndef _VTC_ENCRYPTION_V_
`define _VTC_ENCRYPTION_V_

`include "letters.v"

/**
 * Encrypts a single ASCII character using the Vigenere Tableux Cipher.
 *
 * @param key - The character used to encrypt the plain text character.
 * @param text - The plain text character to encrypt.
 *
 * @return An encrypted lower case character.
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
            cipher[`BYTE] += (key - "a");
            if ("z" < cipher[`BYTE]) begin
                cipher[`BYTE] -= 8'h1a;
            end
        end

        vtc_encrypt = cipher[`BYTE];

    end
endfunction

/**
 * Decrypts a single ASCII character using the Vigenere Tableux Cipher.
 *
 * @param key - The character used to decrypt the cipher character.
 * @param cipher - The cipher character to decrypt.
 *
 * @return A decrypted UPPER CASE character.
 */
function reg[`BYTE] vtc_decrypt(input reg[`BYTE] key, input reg[`BYTE] cipher);
    begin
        reg[`BYTE] text;

        // convert input to upper case
        key[`BYTE] = to_upper(key[`BYTE]);
        cipher[`BYTE] =  to_upper(cipher[`BYTE]);
        text[`BYTE] = cipher[`BYTE];

        // calculate plain text character
        if (is_upper(key[`BYTE]) && is_upper(cipher[`BYTE])) begin
            text[`BYTE] -= (key - "A");
            if ("A" > text[`BYTE]) begin
                text[`BYTE] += 8'h1a;
            end
        end

        vtc_decrypt = text[`BYTE];

    end
endfunction

/**
 * Cracks a single ASCII character of the key using the Vigenere Tableux Cipher.
 *
 * @param text - The plain text character.
 * @param cipher - The cipher character.
 *
 * @return A cracked key lower case character.
 */
function reg[`BYTE] vtc_crack(input reg[`BYTE] text, input reg[`BYTE] cipher);
    begin
        reg[`BYTE] key;

        // convert input to lower case
        text[`BYTE] = to_lower(text[`BYTE]);
        cipher[`BYTE] =  to_lower(cipher[`BYTE]);
        key[`BYTE] = cipher[`BYTE];

        // calculate the key character
        if (is_lower(text[`BYTE]) && is_lower(cipher[`BYTE])) begin
            key[`BYTE] += "a" - text[`BYTE];
            if ("a" > key[`BYTE]) begin
                key[`BYTE] += 8'h1a;
            end
        end

        vtc_crack = key[`BYTE];

    end
endfunction

`endif // _VTC_ENCRYPTION_V_