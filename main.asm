
; This section is for including files that either need to be in the home section, or files where it doesn't matter
SECTION "Includes@home",ROM0

; Prior to importing GingerBread, some options can be specified

; Max 15 characters, should be uppercase ASCII
GAME_NAME EQUS "METRONOME"

; Include SGB support in GingerBread. This makes the GingerBread library take up a bit more space on ROM0. To remove support, comment out this line (don't set it to 0)
;SGB_SUPPORT EQU 1

; Include GBC support in GingerBread. This makes the GingerBread library take up slightly more space on ROM0. To remove support, comment out this line (don't set it to 0)
;GBC_SUPPORT EQU 1

; Set the size of the ROM file here. 0 means 32 kB, 1 means 64 kB, 2 means 128 kB and so on.
ROM_SIZE EQU 1

; Set the size of save RAM inside the cartridge.
; If printed to real carts, it needs to be small enough to fit.
; 0 means no RAM, 1 means 2 kB, 2 -> 8 kB, 3 -> 32 kB, 4 -> 128 kB
RAM_SIZE EQU 1

INCLUDE "deps/gingerbread.asm"

; To compile this game without gbt-player, comment out this line (don't set it to 0)
;USE_GBT_PLAYER EQU 1

; This section is for including files that need to be in data banks
SECTION "Include@banks",ROMX
INCLUDE "deps/ibmpc1.inc"
INCLUDE "images/metronome_bg.inc"

IF DEF(USE_GBT_PLAYER)
INCLUDE "gbt_player.inc"
ENDC

; Macro for copying a rectangular region into VRAM
; Changes ALL registers
; Arguments:
; 1 - Height (number of rows)
; 2 - Width (number of columns)
; 3 - Source to copy from
; 4 - Destination to copy to
CopyRegionToVRAM: MACRO

I SET 0
REPT \1

    ld bc, \2
    ld hl, \3+(I*\2)
    ld de, \4+(I*32)

    call mCopyVRAM

I SET I+1
ENDR
ENDM

SECTION "RAM variables",WRAM0[USER_RAM_START]
BALL_POSITION: DS 1  ; Specifies the x position of the ball
BALL_SLOT: DS 1      ; Specifies which slot the ball is in
BALL_DIRECTION: DS 1 ; If 0 direction=left, else direction=right
SCORE: DS 1          ; Score of the current game
HIT: DS 1            ; Whether the player hit the ball

SECTION "SRAM variables",SRAM[SAVEDATA_START]
SRAM_INTEGRITY_CHECK: DS 2 ; Two bytes that should read $1337; if they do not, the save is considered corrupt or unitialized
SRAM_HIGH_SCORE: DS 1

; Definition of some constants
BALL_SPEED                      equ 1
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

SECTION "StartOfGameCode",ROM0
CharsetTileData:
    chr_IBMPC1  1,8 ; load whole ipbpc charset (should really only load what i need)

begin:

    ; Switch bank to whatever bank contains the tile data
    ld a, BANK(metronome_bg_tile_data)
    ld [ROM_BANK_SWITCH], a

    ld hl, metronome_bg_tile_data
    ld de, TILEDATA_START
    ld bc, metronome_bg_tile_data_size
    call mCopyVRAM

    ld  hl, CharsetTileData
    ld  de, TILEDATA_START + metronome_bg_tile_data_size
    ld  bc, 8*256       ; the ASCII character set: 256 characters, each with 8 bytes of display data
    call    mCopyVramMono

    ld a, BANK(metronome_bg_map_data)
    ld [ROM_BANK_SWITCH], a

    CopyRegionToVRAM 18, 20, metronome_bg_map_data, BACKGROUND_MAPDATA_START

    call StartLCD

    call SetupHighScore

SetupHighScore:
    ; For this game, we only ever use one save data bank, the first one (0)
    xor a
    call ChooseSaveDataBank

    ; Activate save data so we can read and write it
    call EnableSaveData

    ; If the integrity check doesn't read $1337, we should initialize a default high score of 0 and then write $1337 to the integrity check position
    ld a, [SRAM_INTEGRITY_CHECK]
    cp $13
    jr nz, .initializeSRAM

    ld a, [SRAM_INTEGRITY_CHECK+1]
    cp $37
    jr nz, .initializeSRAM

    ; If we get here, no initialization is necessary
    jr .print

.initializeSRAM:
    ; Initialize high score to 0
    xor a
    ld [SRAM_HIGH_SCORE], a

    ; Intialize integrity check so that high score will not be overwritten on next boot
    ld a, $13
    ld [SRAM_INTEGRITY_CHECK], a

    ld a, $37
    ld [SRAM_INTEGRITY_CHECK+1], a

    jr .print

.print:

    ld c, 0
    ld b, 0
    ld hl, HighScoreText
    ld d, 2
    ld e, 14
    call RenderTextToEnd

    ; Display current high score
    ld a, [SRAM_HIGH_SCORE]
    ld b, a

    call DisableSaveData ; Since we no longer need it. Always disable SRAM as quickly as possible.

    ld a, b
    ld b, $65 ; tile number of 0 character on the title screen
    ld c, 0   ; draw to background
    ld d, 14   ; X position
    ld e, 14  ; Y position
    call RenderTwoDecimalNumbers

TitleLoop:

    ld a, 1

    halt
    nop ; Always do a nop after a halt, because of a CPU bug

    call ReadKeys
    and KEY_START
    cp 0

    jp nz, TransitionToGame

    jr TitleLoop

; Modifies ABCDEFHL
TransitionToGame:
    ; Clear highscore line
    ld c, 0
    ld b, 0
    ld hl, ClearText
    ld d, 0
    ld e, 14
    call RenderTextToEnd

    ; Draw "Score:"
    ld c, 0
    ld b, 0
    ld hl, ScoreText
    ld d, 3
    ld e, 3
    call RenderTextToEnd

    call InitGame
    call UpdateBallPostion
    jr GameLoop

; Modifies AF
InitGame:
    ; Slot tracker - Lets put the ball in slot 5 to begin
    ld a, 5
    ld [BALL_SLOT], a

    ; direction - 0 - left
    ld a, 0
    ld [BALL_DIRECTION], a

    ; Init score - 0
    ld [SCORE], a

    ;Init hit
    ld [HIT], a

    ret

; Modifies AF
UpdateBallPostion:
    ld a, [BALL_SLOT]
    cp 6
    jr z, .slot6
    cp 5
    jr z, .slot5
    cp 4
    jr z, .slot4
    cp 3
    jr z, .slot3
    cp 2
    jr z, .slot2
    cp 1
    jr z, .slot1
.slot6
    ld a, BALL_SLOT_6
    jr .write
.slot5
    ld a, BALL_SLOT_5
    jr .write
.slot4
    ld a, BALL_SLOT_4
    jr .write
.slot3
    ld a, BALL_SLOT_3
    jr .write
.slot2
    ld a, BALL_SLOT_2
    jr .write
.slot1
    ld a, BALL_SLOT_1
.write
    ld [BALL_POSITION], a

    ret

GameLoop:
    ; Loop will bounce the ball from side to side, 
    ; the player must hit the right button when the ball is in the last slot on each end
    call DrawScore
    call DrawBall
    call WaitForInputs

    ld a, [BALL_SLOT] ; Current slot
    cp 1
    jr z, .slot1      ; If current slot == 1 jump to .slot1
    cp 6
    jr z, .slot6      ; If current slot == 6 jump to .slot6
.otherSlot
    ; Otherwise the rest of the slots are treated the same way

    ; If the player got a hit in a non end slot then its game over
    ld a, [HIT]
    cp 0
    jp nz, GameOver
    ; Otherwise the ball continues
    ld a, [BALL_DIRECTION]
    cp 1
    jr z, .slotRight
    jr .slotLeft
.slot1
    ; If the player doesn't get a hit in an end slot then its game over
    ld a, [HIT]
    cp 0
    jp z, GameOver
    ; Otherwise reset the hit and the ball continues
    call ResetHit

    ld a, 1
    ld [BALL_DIRECTION], a
    call .incScore
    jr .slotRight
.slot6
    ; If the player doesn't get a hit in an end slot then its game over
    ld a, [HIT]
    cp 0
    jp z, GameOver
    call ResetHit

    xor a ; let a == 0
    ld [BALL_DIRECTION], a
    call .incScore
    jr .slotLeft
.slotLeft
    ld a, [BALL_SLOT]
    dec a
    ld [BALL_SLOT], a
    call UpdateBallPostion
    jr GameLoop
.slotRight
    ld a, [BALL_SLOT]
    inc a
    ld [BALL_SLOT], a
    call UpdateBallPostion
    jr GameLoop
.incScore
    ld a, [SCORE]
    inc a
    daa
    ld [SCORE], a
    ret

WaitForInputs:
    ld b, 20  ; TODO make this tick down to increase speed

.loop:
    halt
    nop

    call ReadKeys
    push af  ; Push the keys to AF to get them back once we know the slot

    ld a, [BALL_SLOT] ; Current slot
    cp 1
    jr z, .slot1      ; If current slot == 1 jump to .slot1
    cp 6
    jr z, .slot6      ; If current slot == 6 jump to .slot6
    jr .otherSlot

.continueLoop
    dec b
    ld a, b
    cp 0
    jr nz, .loop

    ret

.otherSlot
    pop af
    and KEY_A | KEY_LEFT
    cp 0
    call nz, SetHit
    jr .continueLoop
.slot1
    pop af
    and KEY_LEFT
    cp 0
    call nz, SetHit
    jr .continueLoop
.slot6
    pop af
    and KEY_A
    cp 0
    call nz, SetHit
    jr .continueLoop

SetHit:
    ld a, 1
    ld [HIT], a
    ret

ResetHit:
    xor a
    ld [HIT], a
    ret

; Modifies ABCDE
DrawScore:
    ld a, [SCORE]
    ld b, $65 ; tile number of 0 character on the title screen
    ld c, 0   ; draw to background
    ld d, 9   ; X position
    ld e, 3  ; Y position
    call RenderTwoDecimalNumbers
    ret

; Modifies AF
DrawBall:

    ; Write y positions
    ld a, BALL_HEIGHT        ; Y location
    ld [SPRITES_START], a    ; Top Left
    ld [SPRITES_START+4], a  ; Top Middle
    ld [SPRITES_START+8], a  ; Top Right
    add 8                    ; The bottom row is 8 pixels down
    ld [SPRITES_START+12], a ; Bottom Left
    ld [SPRITES_START+16], a ; Bottom Middle
    ld [SPRITES_START+20], a ; Bottom Right

    ; Write x positions
    ld a, [BALL_POSITION]    ; X location
    ld [SPRITES_START+1], a  ; Top Left
    ld [SPRITES_START+13], a ; Bottom Left
    add 8                    ; Middle column is 8 pixels across
    ld [SPRITES_START+5], a  ; Top Middle
    ld [SPRITES_START+17], a ; Bottom Middle
    add 7                    ; Right column is 7 pixels across
    ld [SPRITES_START+9], a  ; Top Right
    ld [SPRITES_START+21], a ; Bottom Right

    ; Write sprite numbers
    ld a, TOP_WHOLE_BALL_PART
    ld [SPRITES_START+2], a  ; Top Left
    ld [SPRITES_START+6], a  ; Top Middle

    ld a, TOP_HALF_BALL_PART
    ld [SPRITES_START+10], a ; Top Right

    ld a, BOTTOM_WHOLE_BALL_PART
    ld [SPRITES_START+14], a ; Bottom Left
    ld [SPRITES_START+18], a ; Bottom Middle

    ld a, BOTTOM_HALF_BALL_PART
    ld [SPRITES_START+22], a ; Bottom Right

    ld a, %10000             ; Flags - Use alt palette
    ld [SPRITES_START+3], a
    ld [SPRITES_START+7], a
    ld [SPRITES_START+11], a
    ld [SPRITES_START+15], a
    ld [SPRITES_START+19], a
    ld [SPRITES_START+23], a

    ret

GameOver:
; Compare player's score with high score and save new high score if it's higher 
    ld a, [SCORE]
    ld b, a 
    
    call EnableSaveData
    ld a, [SRAM_HIGH_SCORE]
    
    cp b 
    call c, .newHighScore
    
    call DisableSaveData
    
    ; Resets the game  
    jp GingerBreadBegin 
    
; Local function for writing high score to SRAM     
.newHighScore:
    ld a, b 
    ld [SRAM_HIGH_SCORE], a 
    ret
