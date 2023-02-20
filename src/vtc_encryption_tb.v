/**
 * File: vtc_encryption_tb.v
 *
 * Contains the testbench for testing Vigenere Tableux Cipher
 * encryption and decryption. 
 *
 * input: in.txt
 * output: out.txt
 *
 * input file format:
 * <encryption flag> <key>
 * <plain text / cipher text> 
 */

`include "constants.v"
`include "letters.v"
`include "vtc_encryption.v"

module vtc_encryption_tb();

    reg[`BYTE] buffer;
    integer in_file;
    integer out_file;

    reg encrypt_flag;
    reg[`BYTE] key[`KIBIBIT];
    integer key_length = 0;

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // determine whether to encrypt or decrypt
        encrypt_flag = (8'h30 != $fgetc(in_file));

        // get the key
        buffer[`BYTE] = $fgetc(in_file);
        for (integer i = 0; `MAX_KEY_STR_LEN > i && ! $feof(in_file); i++) begin
            
            buffer[`BYTE] = $fgetc(in_file);
            
            if ("\n" == buffer[`BYTE]) begin
                i = `MAX_KEY_STR_LEN;
            end
            else begin
                key[i] = to_lower(buffer[`BYTE]);
                key_length++;
            end

        end

        // parse through the remainder of the input file and cycle through the key characters
        for (integer i = 0; ! $feof(in_file); i = (i < key_length - 1) ? (i + 1) : 0) begin

            buffer[`BYTE] = $fgetc(in_file);

            if (! $feof(in_file)) begin
            
                // encrypt
                if (encrypt_flag) begin
                    buffer[`BYTE] = vtc_encrypt(key[i], buffer[`BYTE]);
                end

                // decrypt
                else begin
                    buffer[`BYTE] = vtc_decrypt(key[i], buffer[`BYTE]);
                end

                // correct key cycle for non-letters
                if (! is_letter(buffer[`BYTE]) && 0 <= i) begin
                    i--;
                end

                $fwrite(out_file, "%c", buffer[`BYTE]);
            end
        end

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule