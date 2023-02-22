TDIR = ../test
ENCRYPTION = $(TDIR)/vtc-encryption.a
CRACK = $(TDIR)/vtc-crack.a

VERILOG = iverilog
VVP = vvp
FLAGS = -g2012

all: encryption crack

encryption:
	$(VERILOG) $(FLAGS) vtc_encryption_tb.v -o $(ENCRYPTION)

crack:
	$(VERILOG) $(FLAGS) vtc_crack_tb.v -o $(CRACK)

clean:
	rm -f $(TDIR)/*.a