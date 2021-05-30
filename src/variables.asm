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
LEVEL: DS 1               ; Current level

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
ZERO_CHAR                       equ $45

SECTION "Text definitions",ROM0
CHARMAP "A",$56
CHARMAP "B",$57
CHARMAP "C",$58
CHARMAP "D",$59
CHARMAP "E",$5A
CHARMAP "F",$5B
CHARMAP "G",$5C
CHARMAP "H",$5D
CHARMAP "I",$5E
CHARMAP "J",$5F
CHARMAP "K",$60
CHARMAP "L",$61
CHARMAP "M",$62
CHARMAP "N",$63
CHARMAP "O",$64
CHARMAP "P",$65
CHARMAP "Q",$66
CHARMAP "R",$67
CHARMAP "S",$68
CHARMAP "T",$69
CHARMAP "U",$6A
CHARMAP "V",$6B
CHARMAP "W",$6C
CHARMAP "X",$6D
CHARMAP "Y",$6E
CHARMAP "Z",$6F
CHARMAP "a",$76
CHARMAP "b",$77
CHARMAP "c",$78
CHARMAP "d",$79
CHARMAP "e",$7A
CHARMAP "f",$7B
CHARMAP "g",$7C
CHARMAP "h",$7D
CHARMAP "i",$7E
CHARMAP "j",$7F
CHARMAP "k",$80
CHARMAP "l",$81
CHARMAP "m",$82
CHARMAP "n",$83
CHARMAP "o",$84
CHARMAP "p",$85
CHARMAP "q",$86
CHARMAP "r",$87
CHARMAP "s",$88
CHARMAP "t",$89
CHARMAP "u",$8A
CHARMAP "v",$8B
CHARMAP "w",$8C
CHARMAP "x",$8D
CHARMAP "y",$8E
CHARMAP "z",$8F
CHARMAP ":",$91
CHARMAP " ",$35
CHARMAP "<end>",$0 ; Choose some non-character tile that's easy to remember

; Text definitions
ScoreText:
DB "Score: <end>"
HighScoreText:
DB "High Score: <end>"
LevelText:
DB "Level: <end>"
ClearText:
DB "                         <end>"
