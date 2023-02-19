module vtc_tb();

    reg[7:0] buffer;
    reg[0:0] eof;
    integer in_file;
    integer out_file;

    initial begin
        
        eof = 0;
        in_file = $fopen("in.txt", "r");
        out_file = $fopen("out.txt", "w");

        while(!eof) begin

            buffer[7:0] = $fgetc(in_file);
            if ($feof(in_file)) begin
                eof = 1;
            end 
            else begin
                $fwrite(out_file, "%c", buffer[7:0]);
            end

        end

        $fclose(in_file);
        $fclose(out_file);
    
    end

endmodule