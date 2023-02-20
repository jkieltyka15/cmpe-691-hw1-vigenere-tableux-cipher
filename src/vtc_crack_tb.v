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

    integer in_file;
    integer out_file;

    initial begin
        
        // open in and out text files
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        // test cracking key
        $display("%c", vtc_crack("T", "x"));
        $display("%c", vtc_crack("H", "e"));
        $display("%c", vtc_crack("I", "w"));
        $display("%c", vtc_crack("S", "v"));
        $display("%c", vtc_crack("I", "c"));
        $display("%c", vtc_crack("S", "k"));

        // close in and out text files
        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule