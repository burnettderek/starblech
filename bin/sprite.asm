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
	.globl _ctor
	.globl _sprites_reset
	.globl _isOnScreen
	.globl _setFrame
	.globl _move
	.globl _createPalette
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
_createPalette_palette_65536_186:
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
;..\sprite.c:7: void ctor(struct Sprite* this, byte* data, int tileWidth, int tileHeight, int frames) {
;	---------------------------------
; Function ctor
; ---------------------------------
_ctor::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\sprite.c:8: int totalTiles = tileWidth * tileHeight;
	push	de
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
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
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	push	de
	ld	e, c
	ld	d, b
	ldhl	sp,	#8
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
;..\sprite.c:13: this->frames = frames;
	ld	hl, #0x000c
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:14: this->data = data;
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\sprite.c:15: spriteIndex += totalTiles;
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
;..\sprite.c:16: tileIndex += totalTiles;
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
;..\sprite.c:17: this->visible = true;
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x01
;..\sprite.c:18: this->hidden = false;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x00
;..\sprite.c:19: }
	add	sp, #4
	pop	hl
	add	sp, #6
	jp	(hl)
;..\sprite.c:21: void sprites_reset() {
;	---------------------------------
; Function sprites_reset
; ---------------------------------
_sprites_reset::
;..\sprite.c:22: spriteIndex = 0;
	xor	a, a
	ld	hl, #_spriteIndex
	ld	(hl+), a
	ld	(hl), a
;..\sprite.c:23: tileIndex = 1;
	ld	hl, #_tileIndex
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;..\sprite.c:24: palette_index = 0;
	ld	hl, #_palette_index
	ld	(hl), #0x00
;..\sprite.c:25: for(int i = 0; i < MAX_HARDWARE_SPRITES; i++)
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x28
	ret	NC
;..\sprite.c:26: set_sprite_tile(i, 0);
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
;..\sprite.c:25: for(int i = 0; i < MAX_HARDWARE_SPRITES; i++)
	inc	c
;..\sprite.c:27: }
	jr	00104$
;..\sprite.c:30: bool isOnScreen(struct Sprite* this, int screen_x, int screen_y) {
;	---------------------------------
; Function isOnScreen
; ---------------------------------
_isOnScreen::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\sprite.c:31: if(screen_x < -(this->tileDimension.width * 8)  || screen_x > SCREENWIDTH + (this->tileDimension.width * 8))return false;
	ld	hl, #0x0008
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
;..\sprite.c:32: if(screen_y < -(this->tileDimension.height * 8) || screen_y > SCREENHEIGHT + (this->tileDimension.height * 8))return false;
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
;..\sprite.c:33: return true;
	ld	a, #0x01
00107$:
;..\sprite.c:34: }
	add	sp, #6
	pop	hl
	pop	bc
	jp	(hl)
;..\sprite.c:36: void setFrame(struct Sprite* this, int frame) {
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
;..\sprite.c:37: this->frame = frame;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
;..\sprite.c:38: if(this->hidden || !this->visible)return;
	ld	a, (hl+)
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
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
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z,00109$
;..\sprite.c:39: int frameOffset = frame * this->tileDimension.width * this->tileDimension.height;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
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
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
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
;..\sprite.c:40: int totalTiles = this->tileDimension.height * this->tileDimension.height;
	call	__mulint
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	hl
	ld	c, l
	ld	b, h
	ld	e, l
	ld	d, h
;..\sprite.c:41: set_sprite_data(this->tileIndex, totalTiles, this->data + (frameOffset * 16));
	call	__mulint
	pop	hl
	push	bc
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
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
;..\sprite.c:42: for(int i = 0; i < totalTiles; i++)
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
;..\sprite.c:44: set_sprite_tile(this->spriteIndex + i, this->tileIndex + i);
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
;..\sprite.c:42: for(int i = 0; i < totalTiles; i++)
	inc	bc
	jr	00107$
00109$:
;..\sprite.c:46: }
	add	sp, #10
	ret
;..\sprite.c:48: void setVisible(struct Sprite* this, bool visible) {
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
;..\sprite.c:49: if(visible == this->visible) return; // no op;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, a
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, d
	jp	Z,00116$
;..\sprite.c:50: this->visible = visible;
	ldhl	sp,	#6
;..\sprite.c:51: int totalTiles = this->tileDimension.width * this->tileDimension.height;
	ld	a, (hl+)
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
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
;..\sprite.c:52: if(!visible) {
	call	__mulint
	pop	hl
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00123$
;..\sprite.c:54: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
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
;..\sprite.c:55: set_sprite_tile(i, 0);
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
;..\sprite.c:54: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
	ldhl	sp,	#4
	inc	(hl)
	jr	NZ, 00111$
	inc	hl
	inc	(hl)
	jr	00111$
;..\sprite.c:59: for(int i = 0; i < totalTiles; i++)
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
;..\sprite.c:61: set_sprite_tile(this->spriteIndex + i, this->tileIndex + i);
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
;..\sprite.c:59: for(int i = 0; i < totalTiles; i++)
	inc	bc
	jr	00114$
00116$:
;..\sprite.c:64: }
	add	sp, #9
	ret
;..\sprite.c:66: bool getVisible(struct Sprite* this) {
;	---------------------------------
; Function getVisible
; ---------------------------------
_getVisible::
;..\sprite.c:67: return this->visible;
	ld	hl, #0x0010
	add	hl, de
	ld	a, (hl)
;..\sprite.c:68: }
	ret
;..\sprite.c:70: void move(struct Sprite* this, int screen_x, int screen_y) {
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
;..\sprite.c:72: if(this->hidden == false && isOnScreen(this, screen_x, screen_y)) {
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
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
;..\sprite.c:73: setVisible(this, true);
	ld	a, #0x01
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_setVisible
	jr	00121$
00102$:
;..\sprite.c:76: setVisible(this, false);
	xor	a, a
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_setVisible
;..\sprite.c:78: for(int x = 0; x < this->tileDimension.width; x++)
00121$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	push	bc
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	bc, #0x0000
00112$:
	ldhl	sp,#4
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
	jr	Z, 00160$
	bit	7, d
	jr	NZ, 00161$
	cp	a, a
	jr	00161$
00160$:
	bit	7, d
	jr	Z, 00161$
	scf
00161$:
	jp	NC, 00114$
;..\sprite.c:80: for(int y = 0; y < this->tileDimension.height; y++)
	xor	a, a
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), a
00109$:
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#15
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00162$
	bit	7, d
	jr	NZ, 00163$
	cp	a, a
	jr	00163$
00162$:
	bit	7, d
	jr	Z, 00163$
	scf
00163$:
	jr	NC, 00113$
;..\sprite.c:82: move_sprite(this->spriteIndex + (y + this->tileDimension.width * x), screen_x + x * 8, screen_y + y * 8);
	ldhl	sp,	#19
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl+)
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	(hl), a
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl), c
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
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	push	hl
	ldhl	sp,	#12
	ld	e, (hl)
	pop	hl
	ld	a, l
	call	__mulschar
	ld	a, c
	pop	bc
	ldhl	sp,	#6
	add	a, (hl)
	ldhl	sp,	#10
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
;..\sprite.c:80: for(int y = 0; y < this->tileDimension.height; y++)
	ldhl	sp,	#15
	inc	(hl)
	jp	NZ,00109$
	inc	hl
	inc	(hl)
	jp	00109$
00113$:
;..\sprite.c:78: for(int x = 0; x < this->tileDimension.width; x++)
	inc	bc
	jp	00112$
00114$:
;..\sprite.c:85: }
	add	sp, #17
	pop	hl
	pop	af
	jp	(hl)
;..\sprite.c:87: byte createPalette(UWORD first, UWORD second, UWORD third, UWORD fourth) {
;	---------------------------------
; Function createPalette
; ---------------------------------
_createPalette::
	push	bc
;..\sprite.c:89: palette[0] = first;
	ld	bc, #_createPalette_palette_65536_186+0
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;..\sprite.c:90: palette[1] = second;
	ld	de, #(_createPalette_palette_65536_186 + 2)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\sprite.c:91: palette[2] = third;
	ld	de, #(_createPalette_palette_65536_186 + 4)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	(de), a
	inc	de
;..\sprite.c:92: palette[3] = fourth;
	ld	a, (hl+)
	ld	(de), a
	ld	de, #(_createPalette_palette_65536_186 + 6)
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\sprite.c:93: set_sprite_palette(palette_index, 1, palette);
	push	bc
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, (#_palette_index)
	push	af
	inc	sp
	call	_set_sprite_palette
	add	sp, #4
;..\sprite.c:94: byte oldIdex = palette_index;
	ld	hl, #_palette_index
	ld	c, (hl)
;..\sprite.c:95: palette_index++;
	inc	(hl)
;..\sprite.c:96: return oldIdex;
	ld	a, c
;..\sprite.c:97: }
	inc	sp
	inc	sp
	pop	hl
	add	sp, #4
	jp	(hl)
;..\sprite.c:99: void setPalette(struct Sprite* this, byte paletteIndex) {
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
;..\sprite.c:100: int totalTiles = this->tileDimension.width * this->tileDimension.height * this->frames;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
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
	ld	hl, #0x000c
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;..\sprite.c:101: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
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
;..\sprite.c:102: set_sprite_prop(i, paletteIndex);
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
;..\sprite.c:101: for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
	ldhl	sp,	#5
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00106$:
;..\sprite.c:103: }
	add	sp, #7
	ret
;..\sprite.c:107: void show(struct Sprite* this) {
;	---------------------------------
; Function show
; ---------------------------------
_show::
;..\sprite.c:108: this->hidden = false;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x00
;..\sprite.c:109: setVisible(this, true);
	ld	a, #0x01
;..\sprite.c:110: }
	jp	_setVisible
;..\sprite.c:112: void hide(struct Sprite* this){
;	---------------------------------
; Function hide
; ---------------------------------
_hide::
;..\sprite.c:113: this->hidden = true;
	ld	hl, #0x0011
	add	hl, de
	ld	(hl), #0x01
;..\sprite.c:114: setVisible(this, false);
	xor	a, a
;..\sprite.c:115: }
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
