/**
 * File: vtc_crack_tb.v
 *
 * Contains the testbench for testing cracking Vigenere Tableux Cipher
 * when multiple pairs plain text and cipher text is provided. 
 *
 * input: in.txt
 * output: out.txt
 *
 * input file format:
 * <plain text> 
 * <cipher text>
 * ... 
 */

`include "constants.v"
`include "letters.v"
`include "vtc_encryption.v"

module vtc_encryption_tb();

    reg[`BYTE] buffer;
    integer plain_cipher_file;
    integer key_file;

    reg[`BYTE] key[`KIBIBIT][`KIBIBIT];
    reg[`BYTE] text[`KIBIBIT][`KIBIBIT];
    reg[`BYTE] cipher[`KIBIBIT][`KIBIBIT];
    integer text_length[`KIBIBIT];
    integer key_length[`KIBIBIT];
    integer num_of_pairs = 0;

    initial begin
        
        // open in and out text files
        plain_cipher_file = $fopen("plain_cipher.txt", "r");
        key_file = $fopen("key.txt", "w");

        // get each plain text and cipher text pair
        for (integer i = 0; `MAX_NUM_KEYS > i && ! $feof(plain_cipher_file); i++) begin

            // get the plain text
            buffer[`BYTE] = 8'h0;
            text_length[i] = 0;
            for (integer j = 0; `MAX_KEY_STR_LEN > j && ! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]; j++) begin

                buffer[`BYTE] = $fgetc(plain_cipher_file);
                if (! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]) begin
                    text[i][j] = buffer[`BYTE];
                    text_length[i]++;
                end
                
            end

            // get the cipher text
            buffer[`BYTE] = 8'h0;
            for (integer j = 0; `MAX_KEY_STR_LEN > j && ! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]; j++) begin

                buffer[`BYTE] = $fgetc(plain_cipher_file);
                if (! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]) begin
                    cipher[i][j] = buffer[`BYTE];
                end

            end

            num_of_pairs++;

        end

        // crack vtc keys
        for (integer i = 0; num_of_pairs > i; i++) begin
            
            key_length[i] = 0;
            
            for (integer j = 0; text_length[i] > j; j++) begin

                if (is_letter(text[i][j]) && is_letter(cipher[i][j])) begin
                    key[i][key_length[i]] = vtc_crack(text[i][j], cipher[i][j]);
                    key_length[i]++;
                end

            end

        end

        // write vtc keys to output file
        for (integer i = 0; num_of_pairs > i; i++) begin

            for (integer j = 0; key_length[i] > j; j++) begin

                $fwrite(key_file, "%c", key[i][j]);

            end

            $fwrite(key_file, "\n");

        end

        // close in and out text files
        $fclose(plain_cipher_file);
        $fclose(key_file);
    
    end

endmodule