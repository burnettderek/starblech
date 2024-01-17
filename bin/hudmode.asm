;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module hudmode
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gameobjects
	.globl _sprites_reset
	.globl _hide
	.globl _show
	.globl _setPalette
	.globl _createPalette
	.globl _move
	.globl _setFrame
	.globl _ctor
	.globl _set_bkg_palette
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _planetSprite
	.globl _hud_pallette
	.globl _Hud_init
	.globl _Hud_drawScreen
	.globl _Hud_processInput
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_planetSprite::
	.ds 20
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_HUD_SCALE:
	.ds 2
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
;..\modes\hudmode.c:18: void Hud_init(struct Hud* this) {
;	---------------------------------
; Function Hud_init
; ---------------------------------
_Hud_init::
;..\modes\hudmode.c:19: this->sensorLevel = SENSORS_LONG;
	ld	hl, #0x0004
	add	hl, de
	ld	a, #0x64
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\hudmode.c:20: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;..\modes\hudmode.c:21: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;..\modes\hudmode.c:22: sprites_reset();
	push	de
	call	_sprites_reset
	pop	de
;..\modes\hudmode.c:23: this->screen_position.x = 7 + BORDER;
	ld	l, e
	ld	h, d
	ld	a, #0x07
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\hudmode.c:24: this->screen_position.y = 17 * 8;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	ld	l, c
	ld	h, b
	ld	a, #0x88
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\hudmode.c:25: set_win_data(0, 15, sensor_tiles);
	push	de
	ld	hl, #_sensor_tiles
	push	hl
	ld	hl, #0xf00
	push	hl
	call	_set_win_data
	add	sp, #4
	ld	hl, #_sensor_screen
	push	hl
	ld	hl, #0x201f
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
	pop	de
;..\modes\hudmode.c:27: move_win(this->screen_position.x, this->screen_position.y);
	ld	a, (bc)
	push	af
	ld	a, (de)
	ldh	(_WX_REG + 0), a
	pop	af
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1656: WX_REG=x, WY_REG=y;
	ldh	(_WY_REG + 0), a
;..\modes\hudmode.c:28: set_bkg_palette(0,1, hud_pallette);
	ld	de, #_hud_pallette
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;..\modes\hudmode.c:29: ctor(&planetSprite, sensor_sprites, 2, 2, 1);
	ld	de, #0x0001
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	bc, #_sensor_sprites
	ld	de, #_planetSprite
	call	_ctor
;..\modes\hudmode.c:30: setFrame(&planetSprite, 0);
	ld	bc, #0x0000
	ld	de, #_planetSprite
	call	_setFrame
;..\modes\hudmode.c:32: byte planetPalette = createPalette(RGB_BLACK, RGB_YELLOW, RGB_ORANGE, RGB_RED);
	ld	de, #0x001f
	push	de
	ld	de, #0x029e
	push	de
	ld	bc, #0x03ff
	ld	de, #0x0000
	call	_createPalette
;..\modes\hudmode.c:33: setPalette(&planetSprite, planetPalette);    
	ld	c, a
	ld	de, #_planetSprite
;..\modes\hudmode.c:34: }
	jp	_setPalette
_hud_pallette:
	.dw #0x0000
	.dw #0x0007
	.dw #0x03ff
	.dw #0x7f20
;..\modes\hudmode.c:36: void Hud_drawScreen(struct Hud* this) {
;	---------------------------------
; Function Hud_drawScreen
; ---------------------------------
_Hud_drawScreen::
	add	sp, #-6
	ld	c, e
	ld	b, d
;..\modes\hudmode.c:38: if(this->screen_position.y > BORDER) {
	ld	hl, #0x0002
	add	hl, bc
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
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00132$
	bit	7, d
	jr	NZ, 00133$
	cp	a, a
	jr	00133$
00132$:
	bit	7, d
	jr	Z, 00133$
	scf
00133$:
	jr	NC, 00104$
;..\modes\hudmode.c:39: this->screen_position.y -= 12;  
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	(hl), e
	pop	de
	push	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\modes\hudmode.c:40: if(this->screen_position.y < BORDER)this->screen_position.y = BORDER;
	bit	7, (hl)
	jr	Z, 00102$
	pop	hl
	push	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00102$:
;..\modes\hudmode.c:41: move_win(this->screen_position.x, this->screen_position.y);
	pop	de
	push	de
	ld	a, (de)
	push	af
	ld	a, (bc)
	ldh	(_WX_REG + 0), a
	pop	af
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1656: WX_REG=x, WY_REG=y;
	ldh	(_WY_REG + 0), a
;..\modes\hudmode.c:41: move_win(this->screen_position.x, this->screen_position.y);
00104$:
;..\modes\hudmode.c:45: struct GameObject* ship = gameobjects(GO_SHIP);
	ld	de, #0x0000
	call	_gameobjects
	pop	hl
	push	bc
;..\modes\hudmode.c:46: struct GameObject* planet1 = gameobjects(GO_PLANET1);
	ld	de, #0x0001
	call	_gameobjects
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\hudmode.c:47: int screen_x = (planet1->world.x - ship->world.x)/HUD_SCALE + center_offset_x;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	de
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
	ld	a, c
	sub	a, l
	ld	e, a
	ld	a, b
	sbc	a, h
	ld	d, a
	ld	hl, #_HUD_SCALE
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__divsint
	ld	hl, #0x0050
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;..\modes\hudmode.c:48: int screen_y = (planet1->world.y - ship->world.y)/HUD_SCALE + center_offset_y;
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
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	a, c
	sub	a, l
	ld	e, a
	ld	a, b
	sbc	a, h
	ld	d, a
	ld	hl, #_HUD_SCALE
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	__divsint
	ld	hl, #0x0050
	add	hl, bc
	ld	c, l
	ld	b, h
;..\modes\hudmode.c:49: if(screen_y < 20)hide(&planetSprite);
	ld	a, c
	sub	a, #0x14
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00106$
	ld	de, #_planetSprite
	call	_hide
	jr	00109$
00106$:
;..\modes\hudmode.c:51: show(&planetSprite);
	push	bc
	ld	de, #_planetSprite
	call	_show
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_planetSprite
	call	_move
00109$:
;..\modes\hudmode.c:54: }
	add	sp, #6
	ret
;..\modes\hudmode.c:56: void Hud_processInput(struct Hud* this, byte joypad) {
;	---------------------------------
; Function Hud_processInput
; ---------------------------------
_Hud_processInput::
;..\modes\hudmode.c:67: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__HUD_SCALE:
	.dw #0x0014
	.area _CABS (ABS)
