
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
TOP_WHOLE_BALL_PART             equ $32
TOP_HALF_BALL_PART              equ $34
BOTTOM_WHOLE_BALL_PART          equ $36
BOTTOM_HALF_BALL_PART           equ $38

SECTION "StartOfGameCode",ROM0    
begin: ; GingerBread assumes that the label "begin" is where the game should start

    ; We need to switch bank to whatever bank contains the tile data 
    ld a, BANK(metronome_bg_tile_data)
    ld [ROM_BANK_SWITCH], a 
    
    ld hl, metronome_bg_tile_data
    ld de, TILEDATA_START
    ld bc, metronome_bg_tile_data_size
    call mCopyVRAM
    
    ld a, BANK(metronome_bg_map_data)
    ld [ROM_BANK_SWITCH], a 
    
    CopyRegionToVRAM 18, 20, metronome_bg_map_data, BACKGROUND_MAPDATA_START
    
    call StartLCD

    call SetupHighScore

TitleLoop:

    ld a, 1 
    
    halt
    nop ; Always do a nop after a halt, because of a CPU bug
    
    call ReadKeys
    and KEY_START
    cp 0
    
    jp nz, TransitionToGame
    
    jr TitleLoop

TransitionToGame:

    call InitBallPosition

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
    ; Display current high score 
    ld a, [SRAM_HIGH_SCORE]
    ld b, a 
    
    call DisableSaveData ; Since we no longer need it. Always disable SRAM as quickly as possible.
    
    ld a, b 
    ld b, $27 ; tile number of 0 character on the title screen   
    ld c, 0   ; draw to background
    ld d, 8   ; X position 
    ld e, 14  ; Y position 
    call RenderTwoDecimalNumbers
    
    ret 

; Modifies AF
InitBallPosition:    
    ; Slot tracker
    ld a, 5
    ld [BALL_SLOT], a

    ; direction
    ld a, 0
    ld [BALL_DIRECTION], a

    ; Init score
    ld [SCORE], a

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

    xor a ; Flags (including GBC sprite color palette)
    ld a, %10000
    ld [SPRITES_START+3], a
    ld [SPRITES_START+7], a 
    ld [SPRITES_START+11], a 
    ld [SPRITES_START+15], a 
    ld [SPRITES_START+19], a 
    ld [SPRITES_START+23], a 
    
    jr GameLoop

GameLoop:
    ; Loop will bounce the ball from side to side, the player must hit the right button when the ball is in the last slot on each end
    ld a, [BALL_SLOT] ; Current slot
    cp 1
    jr z, .slot1      ; If current slot == 1 jump to .slot1
    cp 6
    jr z, .slot6      ; If current slot == 6 jump to .slot6
.otherSlot
    ;Otherwise the rest of the slots are treated the same
    ld a, [BALL_DIRECTION]
    cp 1
    jr z, .slotRight
    jr .slotLeft
.slot1
    ld a, 1
    ld [BALL_DIRECTION], a
    ; TODO: check for inputs
    call .incScore
    jr .slotRight
.slot6
    xor a ; let a == 0 
    ld [BALL_DIRECTION], a
    ; TODO: check for inputs
    call .incScore
    jr .slotLeft
.slotLeft
    ld a, [BALL_SLOT]
    dec a
    ld [BALL_SLOT], a
    call ShortWait
    jp UpdateBallPostion
.slotRight
    ld a, [BALL_SLOT]
    inc a
    ld [BALL_SLOT], a
    call ShortWait
    jp UpdateBallPostion
.incScore
    ld a, [SCORE]
    inc a
    ld [SCORE], a
    ret

ShortWait:
    ld b, 10
    
.loop:     
    halt 
    nop 
    
    dec b 
    ld a, b
    cp 0 
    jr nz, .loop 
    
    ret