CharsetTileData:
    chr_IBMPC1  1,8 ; load whole ipbpc charset (should really only load what i need, but lazy)

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

    ; Draw "Level:"
    ld c, 0
    ld b, 0
    ld hl, LevelText
    ld d, 3
    ld e, 1
    call RenderTextToEnd

    ; Draw "Score:"
    ld c, 0
    ld b, 0
    ld hl, ScoreText
    ld d, 3
    ld e, 3
    call RenderTextToEnd

    call InitGameVariables
    call UpdateBallPostion
    jr GameLoop

; Modifies AF
InitGameVariables:
    ; Slot tracker - Lets put the ball in slot 5 to begin
    ld a, 5
    ld [BALL_SLOT], a

    ; Init Level - 1
    ld a, 1
    ld [LEVEL], a

    ; Init ball delay to 20, the lower this is the faster the ball
    ld a, $14
    ld [BALL_DELAY], a

    ; direction - 0 - left
    xor a
    ld [BALL_DIRECTION], a

    ; Init score - 0
    ld [SCORE], a

    ; Init hits - 0
    ld [LEFT_HIT], a
    ld [RIGHT_HIT], a

    ret
