// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(BEGIN)
// set fill bit to 1 (black) by default
@1
D=A
@fill
M=D

// read keyboard value and decide whether to blacken or clear
@KBD
D=M;
@BLACKEN
D;JGT

  (CLEAR)
  // set fill bit to 0 if clear
  @0
  D=A
  @fill
  M=D

  (BLACKEN)
  // start pixel_idx at @SCREEN
  @SCREEN
  D=A
  @pixel_idx 
  M=D

    (FILL_LOOP)
    // fill next 16 bits with 1 (black)
    @0
    D=A
    @fill
    D=D-M // gets us -1 if black, else 0 if white
    @pixel_idx
    A=M // A holds address of next group of pixels to modify
    M=D

    // increment pixel_idx by 16
    @1
    D=A
    @pixel_idx
    M=D+M


    // if we've not reached KBD (if KBD (24576) - idx > 0), JMP to FILL_LOOP
    @KBD
    D=A
    @pixel_idx
    D=D-M
    @FILL_LOOP
    D;JGT

@BEGIN
0;JMP