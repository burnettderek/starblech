;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module sprite
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _getVisible
	.globl _setVisible
	.globl _set_sprite_palette
	.globl _set_sprite_data
	.globl _sprite_init
	.globl _sprites_reset
	.globl _isOnScreen
	.globl _setFrame
	.globl _move
	.globl _create_palette
	.globl _update_palette
	.globl _setPalette
	.globl _show
	.globl _hide
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_update_palette_palette_65536_201:
	.ds 8
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_spriteIndex:
	.ds 2
_tileIndex:
	.ds 2
_palette_index:
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;..\sprite.c:7: void sprite_init(struct Sprite* this, byte* data, RENDER_MODE renderMode, int tileWidth, int tileHeight, int frames) {
;	---------------------------------
; Function sprite_init
; ---------------------------------
_sprite_init::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\sprite.c:8: int totalTiles = tileWidth * tileHeight;
	push	de
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;..\sprite.c:9: this->spriteIndex = spriteIndex;
	call	__mulint
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	de
	ld	hl, #_spriteIndex
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	dec	de
;..\sprite.c:10: this->tileIndex = tileIndex;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	hl, #_tileIndex
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:11: this->tileDimension.width = tileWidth;
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	push	de
	ld	e, c
	ld	d, b
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	(de), a
	inc	de
;..\sprite.c:12: this->tileDimension.height = tileHeight;
	ld	a, (hl+)
	ld	(de), a
	pop	de
	inc	bc
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:13: this->renderMode = renderMode;
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:14: this->frames = frames;
	ld	hl, #0x000d
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:15: this->data = data;
	ld	hl, #0x0013
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:16: spriteIndex += totalTiles;
	push	de
	ld	hl, #_spriteIndex
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	ld	a, l
	ld	(_spriteIndex), a
	ld	a, h
	ld	(_spriteIndex + 1), a
;..\sprite.c:17: tileIndex += totalTiles;
	push	de
	ld	hl, #_tileIndex
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	ld	a, l
	ld	(_tileIndex), a
	ld	a, h
	ld	(_tileIndex + 1), a
;..\sprite.c:18: this->visible = true;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x01
;..\sprite.c:19: this->hidden = false;
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x00
;..\sprite.c:20: }
	add	sp, #4
	pop	hl
	add	sp, #7
	jp	(hl)
;..\sprite.c:22: void sprites_reset(void) {
;	---------------------------------
; Function sprites_reset
; ---------------------------------
_sprites_reset::
;..\sprite.c:23: spriteIndex = 0;
	xor	a, a
	ld	hl, #_spriteIndex
	ld	(hl+), a
	ld	(hl), a
;..\sprite.c:24: tileIndex = 1;
	ld	hl, #_tileIndex
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;..\sprite.c:25: palette_index = 0;
	ld	hl, #_palette_index
	ld	(hl), #0x00
;..\sprite.c:26: for(int i = 0; i < MAX_HARDWARE_SPRITES; i++)
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x28
	ret	NC
;..\sprite.c:27: set_sprite_tile(i, 0);
	ld	b, c
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x00
;..\sprite.c:26: for(int i = 0; i < MAX_HARDWARE_SPRITES; i++)
	inc	c
;..\sprite.c:28: }
	jr	00104$
;..\sprite.c:31: bool isOnScreen(struct Sprite* this, int screen_x, int screen_y) {
;	---------------------------------
; Function isOnScreen
; ---------------------------------
_isOnScreen::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\sprite.c:32: if(screen_x < -(this->tileDimension.width * 8)  || screen_x > SCREENWIDTH + (this->tileDimension.width * 8))return false;
	ld	hl, #0x0009
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	de, #0x0000
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#4
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00123$
	bit	7, d
	jr	NZ, 00124$
	cp	a, a
	jr	00124$
00123$:
	bit	7, d
	jr	Z, 00124$
	scf
00124$:
	jr	C, 00101$
	ld	hl, #0x00a0
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00125$
	bit	7, d
	jr	NZ, 00126$
	cp	a, a
	jr	00126$
00125$:
	bit	7, d
	jr	Z, 00126$
	scf
00126$:
	jr	NC, 00102$
00101$:
	xor	a, a
	jr	00107$
00102$:
;..\sprite.c:33: if(screen_y < -(this->tileDimension.height * 8) || screen_y > SCREENHEIGHT + (this->tileDimension.height * 8))return false;
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	de, #0x0000
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00127$
	bit	7, d
	jr	NZ, 00128$
	cp	a, a
	jr	00128$
00127$:
	bit	7, d
	jr	Z, 00128$
	scf
00128$:
	jr	C, 00104$
	ld	hl, #0x0090
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00129$
	bit	7, d
	jr	NZ, 00130$
	cp	a, a
	jr	00130$
00129$:
	bit	7, d
	jr	Z, 00130$
	scf
00130$:
	jr	NC, 00105$
00104$:
	xor	a, a
	jr	00107$
00105$:
;..\sprite.c:34: return true;
	ld	a, #0x01
00107$:
;..\sprite.c:35: }
	add	sp, #6
	pop	hl
	pop	bc
	jp	(hl)
;..\sprite.c:37: void setFrame(struct Sprite* this, int frame) {
;	---------------------------------
; Function setFrame
; ---------------------------------
_setFrame::
	add	sp, #-10
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
;..\sprite.c:38: this->frame = frame;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
;..\sprite.c:39: if(this->hidden || !this->visible)return;
	ld	a, (hl+)
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	NZ,00109$
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z,00109$
;..\sprite.c:40: int frameOffset = frame * this->tileDimension.width * this->tileDimension.height;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ld	c, l
	ld	b, h
	push	hl
	ldhl	sp,	#8
	ld	e, (hl)
	ldhl	sp,	#9
	ld	d, (hl)
	pop	hl
;..\sprite.c:41: int totalTiles = this->tileDimension.width * this->tileDimension.height;
	call	__mulint
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;..\sprite.c:42: set_sprite_data(this->tileIndex, totalTiles, this->data + (frameOffset * 16));
	call	__mulint
	pop	hl
	push	bc
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, (hl)
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ld	b, a
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	push	bc
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;..\sprite.c:43: for(int i = 0; i < totalTiles; i++)
	ld	bc, #0x0000
00107$:
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00134$
	bit	7, d
	jr	NZ, 00135$
	cp	a, a
	jr	00135$
00134$:
	bit	7, d
	jr	Z, 00135$
	scf
00135$:
	jr	NC, 00109$
;..\sprite.c:45: set_sprite_tile(this->spriteIndex + i, this->tileIndex + i);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), c
	add	a, (hl)
	inc	hl
	ld	(hl), a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	add	a, (hl)
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;..\sprite.c:43: for(int i = 0; i < totalTiles; i++)
	inc	bc
	jr	00107$
00109$:
;..\sprite.c:47: }
	add	sp, #10
	ret
;..\sprite.c:49: void setVisible(struct Sprite* this, bool visible) {
;	---------------------------------
; Function setVisible
; ---------------------------------
_setVisible::
	add	sp, #-9
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;..\sprite.c:50: if(visible == this->visible) return; // no op;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, a
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, d
	jp	Z,00116$
;..\sprite.c:51: this->visible = visible;
	ldhl	sp,	#6
;..\sprite.c:52: int totalTiles = this->tileDimension.width * this->tileDimension.height;
	ld	a, (hl+)
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;..\sprite.c:53: if(!visible) {
	call	__mulint
	pop	hl
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00123$
;..\sprite.c:55: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
00111$:
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00164$
	bit	7, d
	jr	NZ, 00165$
	cp	a, a
	jr	00165$
00164$:
	bit	7, d
	jr	Z, 00165$
	scf
00165$:
	jr	NC, 00116$
;..\sprite.c:56: set_sprite_tile(i, 0);
	ldhl	sp,	#4
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	(hl), #0x00
;..\sprite.c:55: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
	ldhl	sp,	#4
	inc	(hl)
	jr	NZ, 00111$
	inc	hl
	inc	(hl)
	jr	00111$
;..\sprite.c:60: for(int i = 0; i < totalTiles; i++)
00123$:
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	bc, #0x0000
00114$:
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00167$
	bit	7, d
	jr	NZ, 00168$
	cp	a, a
	jr	00168$
00167$:
	bit	7, d
	jr	Z, 00168$
	scf
00168$:
	jr	NC, 00116$
;..\sprite.c:62: set_sprite_tile(this->spriteIndex + i, this->tileIndex + i);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), c
	add	a, (hl)
	inc	hl
	ld	(hl), a
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	add	a, (hl)
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1804: shadow_OAM[nb].tile=tile;
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;..\sprite.c:60: for(int i = 0; i < totalTiles; i++)
	inc	bc
	jr	00114$
00116$:
;..\sprite.c:65: }
	add	sp, #9
	ret
;..\sprite.c:67: bool getVisible(struct Sprite* this) {
;	---------------------------------
; Function getVisible
; ---------------------------------
_getVisible::
;..\sprite.c:68: return this->visible;
	ld	hl, #0x0011
	add	hl, de
	ld	a, (hl)
;..\sprite.c:69: }
	ret
;..\sprite.c:71: void move(struct Sprite* this, int screen_x, int screen_y) {
;	---------------------------------
; Function move
; ---------------------------------
_move::
	add	sp, #-17
	ldhl	sp,	#13
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#11
	ld	a, c
	ld	(hl+), a
;..\sprite.c:73: if(this->hidden == false && isOnScreen(this, screen_x, screen_y)) {
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00102$
	ldhl	sp,	#19
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_isOnScreen
	or	a, a
	jr	Z, 00102$
;..\sprite.c:74: setVisible(this, true);
	ld	a, #0x01
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_setVisible
	jr	00103$
00102$:
;..\sprite.c:77: setVisible(this, false);
	xor	a, a
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_setVisible
00103$:
;..\sprite.c:79: if(this->renderMode == RENDER_16X16) {
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;..\sprite.c:80: for(int y = 0; y < this->tileDimension.height; y++)
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
;..\sprite.c:79: if(this->renderMode == RENDER_16X16) {
	bit	0, c
	jp	Z, 00112$
;..\sprite.c:80: for(int y = 0; y < this->tileDimension.height; y++)
	dec	hl
	inc	sp
	inc	sp
	push	de
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), a
00120$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#9
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00218$
	bit	7, d
	jr	NZ, 00219$
	cp	a, a
	jr	00219$
00218$:
	bit	7, d
	jr	Z, 00219$
	scf
00219$:
	jp	NC, 00128$
;..\sprite.c:83: for(int x = 0; x < this->tileDimension.width; x++)
	xor	a, a
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), a
00117$:
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#15
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00220$
	bit	7, d
	jr	NZ, 00221$
	cp	a, a
	jr	00221$
00220$:
	bit	7, d
	jr	Z, 00221$
	scf
00221$:
	jr	NC, 00121$
;..\sprite.c:85: move_sprite(this->spriteIndex + (y + this->tileDimension.width * x), screen_x + x * 8, screen_y + y * 8);
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	a, (hl-)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, (hl)
	dec	hl
	dec	hl
	ld	(hl), a
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#15
	ld	b, (hl)
	ld	a, b
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#4
	ld	d, (hl)
	push	bc
	ld	e, b
	ld	a, d
	call	__mulschar
	ld	a, c
	pop	bc
	add	a, c
	ldhl	sp,	#8
	add	a, (hl)
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:83: for(int x = 0; x < this->tileDimension.width; x++)
	ldhl	sp,	#15
	inc	(hl)
	jr	NZ, 00117$
	inc	hl
	inc	(hl)
	jr	00117$
00121$:
;..\sprite.c:80: for(int y = 0; y < this->tileDimension.height; y++)
	ldhl	sp,	#9
	inc	(hl)
	jp	NZ,00120$
	inc	hl
	inc	(hl)
	jp	00120$
00112$:
;..\sprite.c:89: else if(this->renderMode == RENDER_8X8) {
	bit	0, c
	jp	NZ, 00128$
;..\sprite.c:90: for(int y = 0; y < this->tileDimension.height; y++)
	inc	sp
	inc	sp
	push	de
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	bc, #0x0000
00126$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	inc	de
	ld	a, (de)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00224$
	bit	7, d
	jr	NZ, 00225$
	cp	a, a
	jr	00225$
00224$:
	bit	7, d
	jr	Z, 00225$
	scf
00225$:
	jp	NC, 00128$
;..\sprite.c:93: for(int x = 0; x < this->tileDimension.width; x++)
	xor	a, a
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), a
00123$:
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#15
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00226$
	bit	7, d
	jr	NZ, 00227$
	cp	a, a
	jr	00227$
00226$:
	bit	7, d
	jr	Z, 00227$
	scf
00227$:
	jr	NC, 00127$
;..\sprite.c:95: move_sprite(this->spriteIndex + (x + this->tileDimension.width * y), screen_x + x * 8, screen_y + y * 8);
	ldhl	sp,	#19
	ld	e, (hl)
	ldhl	sp,	#6
	ld	(hl), c
	ld	a, (hl+)
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	(hl), a
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl+)
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	(hl), a
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl+)
	inc	hl
	ld	d, a
	push	bc
	ld	e, (hl)
	ld	a, d
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#8
	add	a, (hl)
	inc	hl
	inc	hl
	add	a, (hl)
	ld	e, a
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1877: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1878: itm->y=y, itm->x=x;
	ldhl	sp,	#7
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\sprite.c:93: for(int x = 0; x < this->tileDimension.width; x++)
	ldhl	sp,	#15
	inc	(hl)
	jr	NZ, 00123$
	inc	hl
	inc	(hl)
	jr	00123$
00127$:
;..\sprite.c:90: for(int y = 0; y < this->tileDimension.height; y++)
	inc	bc
	jp	00126$
00128$:
;..\sprite.c:99: }
	add	sp, #17
	pop	hl
	pop	af
	jp	(hl)
;..\sprite.c:101: byte create_palette(UWORD first, UWORD second, UWORD third, UWORD fourth) {
;	---------------------------------
; Function create_palette
; ---------------------------------
_create_palette::
;..\sprite.c:102: update_palette(palette_index, first, second, third, fourth);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	push	bc
	ld	a, (#_palette_index)
	call	_update_palette
;..\sprite.c:103: byte oldIdex = palette_index;
	ld	hl, #_palette_index
	ld	c, (hl)
;..\sprite.c:104: palette_index++;
	inc	(hl)
;..\sprite.c:105: return oldIdex;
	ld	a, c
;..\sprite.c:106: }
	pop	hl
	add	sp, #4
	jp	(hl)
;..\sprite.c:108: void update_palette(byte hPallet, UWORD first, UWORD second, UWORD third, UWORD fourth) {
;	---------------------------------
; Function update_palette
; ---------------------------------
_update_palette::
	dec	sp
	ldhl	sp,	#0
	ld	(hl), a
;..\sprite.c:110: palette[0] = first;
	ld	bc, #_update_palette_palette_65536_201+0
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;..\sprite.c:111: palette[1] = second;
	ld	de, #(_update_palette_palette_65536_201 + 2)
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	(de), a
	inc	de
;..\sprite.c:112: palette[2] = third;
	ld	a, (hl+)
	ld	(de), a
	ld	de, #(_update_palette_palette_65536_201 + 4)
	ld	a, (hl+)
	ld	(de), a
	inc	de
;..\sprite.c:113: palette[3] = fourth;
	ld	a, (hl+)
	ld	(de), a
	ld	de, #(_update_palette_palette_65536_201 + 6)
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\sprite.c:114: set_sprite_palette(hPallet, 1, palette);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_sprite_palette
;..\sprite.c:115: }
	add	sp, #5
	pop	hl
	add	sp, #6
	jp	(hl)
;..\sprite.c:118: void setPalette(struct Sprite* this, byte paletteIndex) {
;	---------------------------------
; Function setPalette
; ---------------------------------
_setPalette::
	add	sp, #-7
	ldhl	sp,	#3
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
;..\sprite.c:119: int totalTiles = this->tileDimension.width * this->tileDimension.height * this->frames;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#5
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;..\sprite.c:120: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
	call	__mulint
	pop	hl
	push	bc
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
00104$:
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00123$
	bit	7, d
	jr	NZ, 00124$
	cp	a, a
	jr	00124$
00123$:
	bit	7, d
	jr	Z, 00124$
	scf
00124$:
	jr	NC, 00106$
;..\sprite.c:121: set_sprite_prop(i, paletteIndex);
	ldhl	sp,	#5
	ld	c, (hl)
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1850: shadow_OAM[nb].prop=prop;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, c
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:120: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
	ldhl	sp,	#5
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00106$:
;..\sprite.c:122: }
	add	sp, #7
	ret
;..\sprite.c:126: void show(struct Sprite* this) {
;	---------------------------------
; Function show
; ---------------------------------
_show::
;..\sprite.c:127: this->hidden = false;
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x00
;..\sprite.c:128: setVisible(this, true);
	ld	a, #0x01
;..\sprite.c:129: }
	jp	_setVisible
;..\sprite.c:131: void hide(struct Sprite* this){
;	---------------------------------
; Function hide
; ---------------------------------
_hide::
;..\sprite.c:132: this->hidden = true;
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x01
;..\sprite.c:133: setVisible(this, false);
	xor	a, a
;..\sprite.c:134: }
	jp	_setVisible
	.area _CODE
	.area _INITIALIZER
__xinit__spriteIndex:
	.dw #0x0000
__xinit__tileIndex:
	.dw #0x0001
__xinit__palette_index:
	.db #0x00	; 0
	.area _CABS (ABS)
