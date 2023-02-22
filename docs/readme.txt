University of Maryland Baltimore County 
CMPE/ENEE 491/691 
Hardware Security 
Spring 2023 
Lab 1: Vigenere Tableux Cipher
Jordan Kieltyka

Prerequisites: Icarus Verilog (iverilog) installed

Part A:
    1) Navigate to the 'src' directory.
    2) To build, use command 'make encryption' in the 'test' directory.
    3) Navigate to the 'test' directory.
    4) Ensure 'in.txt' is populated and in the 'test' directory.
    5) To perform a simulation, use command 'vcc vtc-encryption.a' in the 'test' directory.
    6) Output will be in 'out.txt' in the 'test' directory.

    The format for 'in.txt':
    <encrypt flag (0 or 1)> <key>
    <plaintext or ciphertext>

Part B:
    1) Navigate to the 'src' directory.
    2) To build, use command 'make crack' in the 'test' directory.
    3) Navigate to the 'test' directory.
    4) Ensure 'plain_cipher.txt' is populated and in the 'test' directory.
    5) To perform a simulation, use command 'vcc vtc-crack.a' in the 'test' directory.
    6) Output will be in 'key.txt' in the 'test' directory.

    The format for 'plain_cipher.txt':
    <plaintext>
    <ciphertext>
    ...

Notes
    * To build both Part A and Part B, use the command 'make'.
    * To clean the 'test' directory of builds, use the command 'make clean'.