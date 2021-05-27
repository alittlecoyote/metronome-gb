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

INCLUDE "../deps/gingerbread.asm"

; To compile this game without gbt-player, comment out this line (don't set it to 0)
;USE_GBT_PLAYER EQU 1

; This section is for including files that need to be in data banks
SECTION "Include@banks",ROMX
INCLUDE "../deps/ibmpc1.inc"
INCLUDE "../deps/metronome_bg.inc"

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
