SECTION "RAM variables",WRAM0[USER_RAM_START]
BALL_POSITION: DS 1       ; Specifies the x position of the ball
BALL_SLOT: DS 1           ; Specifies which slot the ball is in
BALL_DIRECTION: DS 1      ; If 0 direction=left, else direction=right
SCORE: DS 1               ; Score of the current game
LEFT_HIT: DS 1            ; Whether the player hit the ball with the left key
RIGHT_HIT: DS 1           ; Whether the player hit the ball with the right key
BALL_DELAY: DS 1          ; Delay on the ball travelling to next square
LEFT_STILL_PRESSED: DS 1  ; Tracks if the left button is being held down
RIGHT_STILL_PRESSED: DS 1 ; Tracks if the right button is being held down

SECTION "SRAM variables",SRAM[SAVEDATA_START]
SRAM_INTEGRITY_CHECK: DS 2 ; Two bytes that should read $1337; if they do not, the save is considered corrupt or unitialized
SRAM_HIGH_SCORE: DS 1

; Definition of some constants
BALL_HEIGHT                     equ 77
BALL_SLOT_1                     equ 10
BALL_SLOT_2                     equ 37
BALL_SLOT_3                     equ 64
BALL_SLOT_4                     equ 91
BALL_SLOT_5                     equ 118
BALL_SLOT_6                     equ 145
TOP_WHOLE_BALL_PART             equ $2C
TOP_HALF_BALL_PART              equ $2E
BOTTOM_WHOLE_BALL_PART          equ $30
BOTTOM_HALF_BALL_PART           equ $32

SECTION "Text definitions",ROM0
CHARMAP "A",$76
CHARMAP "B",$77
CHARMAP "C",$78
CHARMAP "D",$79
CHARMAP "E",$7A
CHARMAP "F",$7B
CHARMAP "G",$7C
CHARMAP "H",$7D
CHARMAP "I",$7E
CHARMAP "J",$7F
CHARMAP "K",$80
CHARMAP "L",$81
CHARMAP "M",$82
CHARMAP "N",$83
CHARMAP "O",$84
CHARMAP "P",$85
CHARMAP "Q",$86
CHARMAP "R",$87
CHARMAP "S",$88
CHARMAP "T",$89
CHARMAP "U",$8A
CHARMAP "V",$8B
CHARMAP "W",$8C
CHARMAP "X",$8D
CHARMAP "Y",$8E
CHARMAP "Z",$8F
CHARMAP "a",$96
CHARMAP "b",$97
CHARMAP "c",$98
CHARMAP "d",$99
CHARMAP "e",$9A
CHARMAP "f",$9B
CHARMAP "g",$9C
CHARMAP "h",$9D
CHARMAP "i",$9E
CHARMAP "j",$9F
CHARMAP "k",$A0
CHARMAP "l",$A1
CHARMAP "m",$A2
CHARMAP "n",$A3
CHARMAP "o",$A4
CHARMAP "p",$A5
CHARMAP "q",$A6
CHARMAP "r",$A7
CHARMAP "s",$A8
CHARMAP "t",$A9
CHARMAP "u",$AA
CHARMAP "v",$AB
CHARMAP "w",$AC
CHARMAP "x",$AD
CHARMAP "y",$AE
CHARMAP "z",$AF
CHARMAP ":",$6F
CHARMAP " ",$55
CHARMAP "<end>",$0 ; Choose some non-character tile that's easy to remember

; Text definitions
ScoreText:
DB "Score: <end>"
HighScoreText:
DB "High Score: <end>"
ClearText:
DB "                         <end>"
