; ///////////////////////
; //                   //
; //  File Attributes  //
; //                   //
; ///////////////////////

; Filename: title_bg.png
; Pixel Width: 160px
; Pixel Height: 144px

; /////////////////
; //             //
; //  Constants  //
; //             //
; /////////////////

title_bg_tile_map_size EQU $0168
title_bg_tile_map_width EQU $14
title_bg_tile_map_height EQU $12

title_bg_tile_data_size EQU $0290
title_bg_tile_count EQU $29

; ////////////////
; //            //
; //  Map Data  //
; //            //
; ////////////////

title_bg_map_data:
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$00,$00,$04,$00,$00
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$05,$06,$07,$08
DB $09,$0A,$0B,$0C,$0D,$0C,$0E,$0F,$10,$11,$12,$13,$14,$15,$16,$17
DB $18,$00,$18,$19,$1A,$1B,$1C,$00,$1D,$1E,$1F,$20,$21,$22,$23,$24
DB $25,$26,$27,$28,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
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
DB $00,$00,$00,$00,$00,$00,$00,$00

; /////////////////
; //             //
; //  Tile Data  //
; //             //
; /////////////////

title_bg_tile_data:
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$00,$00,$00,$00,$0E,$0E,$1F,$1F,$0F,$1F,$0F,$07,$0F,$07
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$C0,$80,$C0,$C0
DB $00,$00,$00,$00,$00,$00,$06,$06,$0E,$0E,$1E,$1E,$1E,$3E,$3E,$3E
DB $00,$00,$00,$00,$00,$00,$06,$06,$06,$07,$06,$07,$06,$07,$06,$07
DB $0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06
DB $E0,$F0,$70,$78,$3D,$39,$3F,$1F,$0F,$1F,$07,$0F,$02,$06,$00,$00
DB $7E,$76,$EE,$E6,$CE,$C6,$CE,$C6,$8E,$86,$0E,$06,$0E,$06,$0E,$06
DB $00,$00,$3F,$3F,$3F,$3F,$3F,$3F,$38,$38,$38,$38,$38,$38,$3F,$7F
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$03,$01,$03,$01,$03,$01,$FF,$FF
DB $06,$07,$8F,$8F,$9F,$9F,$8F,$8F,$86,$87,$86,$87,$86,$87,$86,$87
DB $00,$00,$CF,$CF,$CF,$CF,$CF,$CF,$07,$07,$07,$07,$07,$07,$07,$07
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$00,$00
DB $00,$00,$8F,$8F,$CF,$8F,$8F,$8F,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
DB $00,$00,$E7,$E7,$EF,$EF,$E7,$E7,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$80,$80,$80,$80,$80,$80,$80,$80
DB $00,$00,$F8,$F8,$F8,$F8,$F8,$F8,$38,$38,$38,$38,$38,$38,$38,$38
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$E0,$C0,$E0,$C0,$E0,$C0,$E0,$C0
DB $00,$00,$FC,$FC,$FE,$FE,$FE,$FE,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$7F,$70,$30,$70,$30,$70,$30,$70,$30
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$38,$38,$38,$38,$38,$38,$38,$38
DB $00,$00,$F1,$F1,$F9,$F9,$F9,$F9,$39,$39,$39,$39,$39,$39,$39,$3B
DB $00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$C0,$C0,$C0,$C0,$C0,$C0,$FF,$FF
DB $00,$00,$FC,$FC,$FC,$FC,$FC,$FC,$0C,$1C,$0C,$1C,$0C,$1C,$FC,$FC
DB $0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06,$0E,$06,$06,$06
DB $7F,$7F,$7F,$7F,$38,$38,$38,$38,$38,$38,$3F,$3F,$3F,$3F,$3F,$3F
DB $FF,$FF,$FF,$FF,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF
DB $86,$87,$86,$87,$06,$07,$06,$07,$06,$07,$87,$87,$87,$87,$87,$87
DB $07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$C7,$C7,$E7,$C7,$C7,$C3
DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F,$07,$0F
DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF
DB $E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3,$E3
DB $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$00,$00
DB $38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$18,$18
DB $E0,$C0,$E0,$C0,$E0,$C0,$E0,$C0,$E0,$C0,$FF,$FF,$FF,$FF,$FF,$FF
DB $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$FE,$FE,$FE,$FE,$FE,$FC
DB $70,$30,$70,$30,$70,$30,$70,$30,$70,$30,$70,$30,$70,$30,$30,$30
DB $38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$38,$30,$30
DB $3B,$3B,$3B,$3B,$39,$39,$39,$39,$39,$39,$39,$39,$39,$39,$31,$31
DB $FF,$FF,$FF,$FF,$C0,$C0,$C0,$C0,$C0,$C0,$FF,$FF,$FF,$FF,$FF,$FF
DB $FC,$FC,$FC,$FC,$00,$00,$00,$00,$00,$00,$FC,$FC,$FC,$FC,$FC,$FC
