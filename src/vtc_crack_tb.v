/**
 * File: vtc_crack_tb.v
 *
 * Contains the testbench for testing cracking Vigenere Tableux Cipher
 * when multiple pairs plaintext and ciphertext is provided. 
 *
 * input: in.txt
 * output: out.txt
 *
 * input file format:
 * <plaintext> 
 * <ciphertext>
 * ... 
 */

`include "constants.v"
`include "letters.v"
`include "vtc_encryption.v"

module vtc_encryption_tb();

    reg is_valid_key = 1'h1;
    integer longest_key = 0;

    reg[`BYTE] buffer;
    integer plain_cipher_file;
    integer key_file;

    // used for cracking vtc key
    reg[`BYTE] key[`KIBIBIT][`KIBIBIT];
    reg[`BYTE] text[`KIBIBIT][`KIBIBIT];
    reg[`BYTE] cipher[`KIBIBIT][`KIBIBIT];
    integer text_length[`KIBIBIT];
    integer key_length[`KIBIBIT];
    integer num_of_pairs = 0;

    // used for key minimization
    integer tmp_key_length = 0;
    integer key_iterator = 0;
    reg isMinimized = 1'h0;

    initial begin
        
        // open in and out text files
        plain_cipher_file = $fopen("plain_cipher.txt", "r");
        key_file = $fopen("key.txt", "w");

        // get each plaintext and ciphertext pair
        for (integer i = 0; `MAX_NUM_KEYS > i && ! $feof(plain_cipher_file); i++) begin

            // get the plaintext
            buffer[`BYTE] = 8'h0;
            text_length[i] = 0;
            for (integer j = 0; `MAX_KEY_STR_LEN > j && ! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]; j++) begin

                buffer[`BYTE] = $fgetc(plain_cipher_file);
                if (! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]) begin
                    text[i][j] = to_upper(buffer[`BYTE]);
                    text_length[i]++;
                end
                
            end

            // get the ciphertext
            buffer[`BYTE] = 8'h0;
            for (integer j = 0; `MAX_KEY_STR_LEN > j && ! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]; j++) begin

                buffer[`BYTE] = $fgetc(plain_cipher_file);
                if (! $feof(plain_cipher_file) && "\n" != buffer[`BYTE]) begin
                    cipher[i][j] = to_lower(buffer[`BYTE]);
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

        // minimize vtc keys
        for (integer i = 0; num_of_pairs > i; i++) begin

            tmp_key_length = 1;
            isMinimized = 1'h0;

            for (integer j = tmp_key_length; key_length[i] > j && ! isMinimized; j++) begin
                
                // character matching beginning of key found
                if (key[i][0] == key[i][j]) begin

                    tmp_key_length = j;
                    isMinimized = 1'h1;

                    // verify minimized key is valid
                    key_iterator = 0;
                    for (integer z = 0; key_length[i] > z && isMinimized; z++) begin

                        // invalid minimized key
                        if (key[i][key_iterator] != key[i][z]) begin
                            isMinimized = 1'h0;
                            tmp_key_length = z;
                        end

                        key_iterator = (key_iterator >= tmp_key_length - 1) ? 0 : key_iterator + 1;

                    end

                end

            end

            // minimized key found
            if (isMinimized) begin
                key_length[i] = tmp_key_length;
            end

        end

        // find the longest key
        tmp_key_length = 0;
        for (integer i = 0; i < num_of_pairs; i++) begin
            if (tmp_key_length < key_length[i]) begin
                longest_key = i;
                tmp_key_length = key_length[i];
            end
        end

        // verify keys with the same length as the longest key are the same
        for (integer i = longest_key + 1; i < num_of_pairs && is_valid_key; i++) begin

            if (key_length[longest_key] == key_length[i]) begin

                for (integer j = 0; j < key_length[longest_key] && is_valid_key; j++) begin

                    // invalid key found
                    if (key[longest_key][j] != key[i][j]) begin
                        is_valid_key = 1'h0;
                    end

                end

            end
        
        end
        
        // verify key is valid for all plaintext ciphertext pairs
        if (is_valid_key) begin
            
            for (integer i = 0; i < num_of_pairs && is_valid_key; i++) begin

                key_iterator = 0;
                tmp_key_length = 0;

                for (integer j = 0; j < text_length[i] && is_valid_key; j++) begin

                    buffer[`BYTE] = vtc_encrypt(key[longest_key][key_iterator], text[i][j]);
                    if (buffer[`BYTE] != cipher[i][j]) begin
                        is_valid_key = 1'h0;
                    end

                    if (is_letter(buffer[`BYTE])) begin
                        key_iterator = (key_iterator >= key_length[longest_key] - 1) ? 0 : key_iterator + 1;
                    end

                end

            end

        end

        // write the key to the output file if it was valid
        if (is_valid_key) begin
        
            for (integer i = 0; key_length[longest_key] > i; i++) begin
                $fwrite(key_file, "%c", key[longest_key][i]);
            end

        end

        // key was not valid
        else begin
            $fwrite(key_file, "NO VALID KEY WAS FOUND");
        end

        // close in and out text files
        $fclose(plain_cipher_file);
        $fclose(key_file);
    
    end

endmodule