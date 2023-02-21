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

    reg[`BYTE] key[`KIBIBIT][`KIBIBIT];
    reg[`BYTE] text[`KIBIBIT][`KIBIBIT];
    reg[`BYTE] cipher[`KIBIBIT][`KIBIBIT];
    integer text_length[`KIBIBIT];
    integer key_length[`KIBIBIT];
    integer num_of_pairs = 0;

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // get each plain text and cipher text pair
        for (integer i = 0; `MAX_NUM_KEYS > i && ! $feof(in_file); i++) begin

            // get the plain text
            buffer[`BYTE] = 8'h0;
            text_length[i] = 0;
            for (integer j = 0; `MAX_KEY_STR_LEN > j && ! $feof(in_file) && "\n" != buffer[`BYTE]; j++) begin

                buffer[`BYTE] = $fgetc(in_file);
                if (! $feof(in_file) && "\n" != buffer[`BYTE]) begin
                    text[i][j] = buffer[`BYTE];
                    text_length[i]++;
                end
                
            end

            // get the cipher text
            buffer[`BYTE] = 8'h0;
            for (integer j = 0; `MAX_KEY_STR_LEN > j && ! $feof(in_file) && "\n" != buffer[`BYTE]; j++) begin

                buffer[`BYTE] = $fgetc(in_file);
                if (! $feof(in_file) && "\n" != buffer[`BYTE]) begin
                    cipher[i][j] = buffer[`BYTE];
                end

            end

            num_of_pairs++;

        end

        // write plain text key pairs to output file
        for (integer i = 0; num_of_pairs > i; i++) begin

            for (integer j = 0; text_length[i] > j; j++) begin
                $fwrite(out_file, "%c", text[i][j]);
            end

            $fwrite(out_file, "\n");

            for (integer j = 0; text_length[i] > j; j++) begin
                $fwrite(out_file, "%c", cipher[i][j]);
            end

            $fwrite(out_file, "\n");

        end

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule