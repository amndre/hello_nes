; hello world program for the NES written in 6502 assembly language
; based on https://nerdy-nights.nes.science/

; header
; ------------------------------------------------------------------------------
    .inesprg 1     ; 1 bank of code
    .ineschr 1     ; 1 bank of character data
    .inesmap 0     ; no bank swapping
    .inesmir 1     ; background mirroring 
  
; variables and constants
; ------------------------------------------------------------------------------
    .rsset $0000  ; start variables at ram location 0
value = $00

    .bank 0
    .org $C000  
reset:
    sei            ; disable interrupt request signal
    cld            ; disable decimal mode

    lda %11100000  ; enable intensify blues flag on ppu_mask
    sta $2001

infinite_loop:
    inc value      ; increment accumulator
    lda value
    jmp infinite_loop   ; infinite loop

    .bank 1
    .org $E000  


; interrupt vectors
; ------------------------------------------------------------------------------
    .org $FFFA

    .dw 0      ; activated every vblank

    .dw reset  ; activated after booting up or after reset
 
    .dw 0      ; audio interrupt, set to 0

    .bank 2
    .org $0000 ; graphics here
    .incbin "mario.chr" ; unused
    