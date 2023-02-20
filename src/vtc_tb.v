`include "letters.v"

module vtc_tb();

    reg[7:0] buffer;
    integer in_file;
    integer out_file;

    reg encrypt_flag;
    reg[7:0] key[1024:0];
    integer key_length = 0;

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // determine whether to encrypt or decrypt
        encrypt_flag = (8'h30 != $fgetc(in_file));

        // get the key
        buffer[7:0] = $fgetc(in_file);
        for (integer i = 0; 1024 > i && ! $feof(in_file); i++) begin
            
            buffer[7:0] = $fgetc(in_file);
            
            if (8'h0a == buffer[7:0]) begin
                i = 1024;
            end
            else begin
                key[i] = to_lower(buffer[7:0]);
                key_length++;
            end

        end
        
        $display("encrypt: %d", encrypt_flag);
        $write("key: ");
        for(integer i = 0; i < key_length; i++) begin
            $write("%c", key[i]);
        end
        $write("\n");
        $display("key length: %d", key_length);

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule