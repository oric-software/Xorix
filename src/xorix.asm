#include "../oric-common/include/asm/ch376.h"
#include "../oric-common/include/asm/via6522_1.h"
#include "../oric-common/include/asm/via6522_2.h"
#include "../oric-common/include/asm/keyboard.h"
#include "../oric-common/include/asm/telemon.h"
#include "../oric-common/include/asm/orix.h"

#include "../oric-common/include/asm/macro_orix.h"

; #include "../oric-common/vars/telemon_vars.inc.asm"
;#include "../oric-common/vars/orix_vars.inc.asm"

#define MAX_POS_Y 189


#define  RES $00
#define  RESB $02


.text
_xorix_start:
  jsr _cursor_decal

restart_display
  jsr _xorix_display_cursor  
  
loop2
	BRK_TELEMON(XRDW0) ; read keyboard
	cmp #KEY_LEFT
	beq loop2
	cmp #KEY_RIGHT
	beq move_right
	cmp #KEY_UP
	beq move_up
	cmp #KEY_DOWN
	beq move_down	
	cmp #KEY_RETURN ; enter ?
	jmp loop2
move_right
  ldx pos_x
  cpx #220
  beq loop2
  inx 
  stx pos_x
  jmp restart_display
move_down
  ldx pos_y
  cpx #MAX_POS_Y
  beq loop2
  stx tmp
  jsr _xorix_erase_cursor
  ldx tmp
  
  inx 
  stx pos_y
  jmp restart_display  
move_up
  ldx pos_y
  cpx #1
  beq loop2
  stx tmp
  jsr _xorix_erase_cursor
  ldx tmp
  dex
  stx pos_y
  jmp restart_display  
  
  
  rts

_xorix_display_cursor
.(
  ldx pos_y
  
  lda TABLE_LOW_HIRES,x
  sta RESB
  
  lda TABLE_HIGH_HIRES,x
  sta RESB+1
  
  lda #<cursor_first 
  sta RES
  
  lda #>cursor_first 
  sta RES+1
  
  ldx #0
loop
  ldy #0  
  lda (RES),y
  sta (RESB),y
  iny 
  lda (RES),y
  sta (RESB),y
  
  lda RESB
  clc
  adc #40
  bcc next
  inc RESB+1
next
  sta RESB
  inc RES
  inc RES
  inx 
  cpx #11
  bne loop

  rts
.)

_xorix_erase_cursor
.(
  ldx pos_y
  
  lda TABLE_LOW_HIRES,x
  sta RESB
  
  lda TABLE_HIGH_HIRES,x
  sta RESB+1
  
  lda #<cursor_first 
  sta RES
  
  lda #>cursor_first 
  sta RES+1
  
  ldx #0
loop
  ldy #0  
  lda #64
  sta (RESB),y
  iny 
  lda #64
  sta (RESB),y
  
  lda RESB
  clc
  adc #40
  bcc next
  inc RESB+1
next
  sta RESB
  inc RES
  inc RES
  inx 
  cpx #11
  bne loop

  rts
.)  

_cursor_decal
.(
  rts
  ldx #0
loop  
  lda cursor_first,x
  clc
  ror 
  sta cursor_second,x
  inx
  cpx #11*2
  bne loop
  rts
.)
  
  
#include "src/data/cursor_data.txt"
pos_x
.byt 0
pos_y
.byt 0
tmp
.byt 0
#include "..\oric-common\tables\asm\hires_first_line_adress.asm"





