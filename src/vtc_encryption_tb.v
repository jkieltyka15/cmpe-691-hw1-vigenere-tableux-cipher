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
        
        $display("encrypt: %d", encrypt_flag);
        $write("key: ");
        for(integer i = 0; i < key_length; i++) begin
            $write("%c", to_lower(key[i]));
        end
        $write("\n");
        $display("key length: %d", key_length);

        // test encrypt
        $display("encrypt: %c", vtc_encrypt("c", "a"));

        // teset decrypt
        $display("decrypt: %c", vtc_decrypt("c", vtc_encrypt("c", "a")));

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule