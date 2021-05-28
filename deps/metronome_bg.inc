; ///////////////////////
; //                   //
; //  File Attributes  //
; //                   //
; ///////////////////////

; Filename: metronome_bg.png
; Pixel Width: 160px
; Pixel Height: 168px

; WARNING: Height of input image padded 6px to 168px

; /////////////////
; //             //
; //  Constants  //
; //             //
; /////////////////

metronome_bg_tile_map_size EQU $0190
metronome_bg_tile_map_width EQU $14
metronome_bg_tile_map_height EQU $15

metronome_bg_tile_data_size EQU $0350
metronome_bg_tile_count EQU $35

; ////////////////
; //            //
; //  Map Data  //
; //            //
; ////////////////

metronome_bg_map_data:
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$04
DB $02,$02,$05,$02,$02,$06,$07,$02,$02,$08,$02,$02,$09,$0A,$02,$0B
DB $0C,$00,$0D,$0E,$00,$00,$0F,$00,$00,$10,$11,$00,$00,$12,$00,$00
DB $13,$14,$00,$15,$0C,$00,$0D,$0E,$00,$00,$0F,$00,$00,$10,$11,$00
DB $00,$12,$00,$00,$13,$14,$00,$15,$16,$17,$18,$19,$17,$17,$1A,$17
DB $17,$1B,$1C,$17,$17,$1D,$17,$17,$1E,$1F,$17,$20,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; /////////////////
; //             //
; //  Tile Data  //
; //             //
; /////////////////

metronome_bg_tile_data:
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$7F,$7F,$40,$40,$40,$40,$40,$40
DB $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$01,$01,$01,$01,$01,$01
DB $00,$00,$00,$00,$00,$00,$00,$00,$0F,$0F,$08,$08,$08,$08,$08,$08
DB $00,$00,$00,$00,$00,$00,$00,$00,$E1,$E1,$21,$21,$21,$21,$21,$21
DB $00,$00,$00,$00,$00,$00,$00,$00,$FC,$FC,$04,$04,$04,$04,$04,$04
DB $00,$00,$00,$00,$00,$00,$00,$00,$3F,$3F,$20,$20,$20,$20,$20,$20
DB $00,$00,$00,$00,$00,$00,$00,$00,$87,$87,$84,$84,$84,$84,$84,$84
DB $00,$00,$00,$00,$00,$00,$00,$00,$F0,$F0,$10,$10,$10,$10,$10,$10
DB $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$80,$80,$80,$80,$80,$80
DB $00,$00,$00,$00,$00,$00,$00,$00,$FE,$FE,$02,$02,$02,$02,$02,$02
DB $40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40
DB $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
DB $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
DB $21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21,$21
DB $04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
DB $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
DB $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
DB $10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10
DB $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
DB $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
DB $40,$40,$40,$40,$40,$40,$7F,$7F,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
DB $01,$01,$01,$01,$01,$01,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
DB $08,$08,$08,$08,$08,$08,$0F,$0F,$00,$00,$00,$00,$00,$00,$00,$00
DB $21,$21,$21,$21,$21,$21,$E1,$E1,$00,$00,$00,$00,$00,$00,$00,$00
DB $04,$04,$04,$04,$04,$04,$FC,$FC,$00,$00,$00,$00,$00,$00,$00,$00
DB $20,$20,$20,$20,$20,$20,$3F,$3F,$00,$00,$00,$00,$00,$00,$00,$00
DB $84,$84,$84,$84,$84,$84,$87,$87,$00,$00,$00,$00,$00,$00,$00,$00
DB $10,$10,$10,$10,$10,$10,$F0,$F0,$00,$00,$00,$00,$00,$00,$00,$00
DB $80,$80,$80,$80,$80,$80,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
DB $02,$02,$02,$02,$02,$02,$FE,$FE,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$1C,$1C,$22,$22,$22,$22,$22,$22,$22,$22,$1C,$1C,$00,$00
DB $00,$00,$0C,$0C,$04,$04,$04,$04,$04,$04,$04,$04,$0E,$0E,$00,$00
DB $00,$00,$1C,$1C,$02,$02,$04,$04,$08,$08,$10,$10,$1E,$1E,$00,$00
DB $00,$00,$1C,$1C,$02,$02,$0C,$0C,$02,$02,$02,$02,$1C,$1C,$00,$00
DB $00,$00,$12,$12,$12,$12,$1E,$1E,$02,$02,$02,$02,$02,$02,$00,$00
DB $00,$00,$1E,$1E,$10,$10,$1C,$1C,$02,$02,$02,$02,$1C,$1C,$00,$00
DB $00,$00,$0C,$0C,$10,$10,$1C,$1C,$12,$12,$12,$12,$0C,$0C,$00,$00
DB $00,$00,$1E,$1E,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00,$00
DB $00,$00,$0C,$0C,$12,$12,$0C,$0C,$12,$12,$12,$12,$0C,$0C,$00,$00
DB $00,$00,$0E,$0E,$0A,$0A,$0E,$0E,$02,$02,$02,$02,$02,$02,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
DB $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
DB $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
