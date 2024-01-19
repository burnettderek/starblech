;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module explorationmode
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _manage_asteroid
	.globl _to_screen
	.globl _do_gameover
	.globl _do_explosion
	.globl _gameobjects
	.globl _sprites_reset
	.globl _hide
	.globl _show
	.globl _setPalette
	.globl _isOnScreen
	.globl _update_palette
	.globl _create_palette
	.globl _move
	.globl _setFrame
	.globl _sprite_init
	.globl _set_bkg_palette
	.globl _abs
	.globl _rand
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _mid_screen
	.globl _gameoverGraphic
	.globl _explosionGraphic
	.globl _asteroidGraphic
	.globl _shipGraphic
	.globl _photonGraphic
	.globl _explosion
	.globl _saturnGraphic
	.globl _asteroid
	.globl _photon
	.globl _space_pallette
	.globl _ExplorationMode_init
	.globl _ExplorationMode_update
	.globl _ExplorationMode_processInput
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_photon::
	.ds 9
_asteroid::
	.ds 9
_saturnGraphic::
	.ds 21
_explosion::
	.ds 9
_photonGraphic::
	.ds 21
_shipGraphic::
	.ds 21
_asteroidGraphic::
	.ds 21
_explosionGraphic::
	.ds 21
_gameoverGraphic::
	.ds 21
_hGameOverPalette:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_mid_screen::
	.ds 4
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
;..\modes\explorationmode.c:38: void do_explosion(int world_x, int world_y) {
;	---------------------------------
; Function do_explosion
; ---------------------------------
_do_explosion::
	push	de
;..\modes\explorationmode.c:39: explosion.isAlive = true;
	ld	hl, #(_explosion + 4)
	ld	(hl), #0x01
;..\modes\explorationmode.c:40: explosion.world.x = world_x;
	ld	de, #_explosion
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\modes\explorationmode.c:41: explosion.world.y = world_y;
	ld	hl, #(_explosion + 2)
	ld	(hl), c
	inc	hl
	ld	(hl), b
;..\modes\explorationmode.c:42: show(&explosionGraphic);
	ld	de, #_explosionGraphic
	inc	sp
	inc	sp
	jp	_show
;..\modes\explorationmode.c:43: }
	inc	sp
	inc	sp
	ret
_space_pallette:
	.dw #0x0000
	.dw #0x2108
	.dw #0x20c0
	.dw #0x0024
;..\modes\explorationmode.c:45: void do_gameover(struct GameObject* ship) {
;	---------------------------------
; Function do_gameover
; ---------------------------------
_do_gameover::
;..\modes\explorationmode.c:46: move(&gameoverGraphic, 70, 84);
	push	de
	ld	bc, #0x0054
	push	bc
	ld	bc, #0x0046
	ld	de, #_gameoverGraphic
	call	_move
	ld	de, #_gameoverGraphic
	call	_show
	pop	de
;..\modes\explorationmode.c:48: ship->isAlive = false;
	inc	de
	inc	de
	inc	de
	inc	de
	xor	a, a
	ld	(de), a
;..\modes\explorationmode.c:49: hide(&shipGraphic);
	ld	de, #_shipGraphic
;..\modes\explorationmode.c:50: }
	jp	_hide
;..\modes\explorationmode.c:52: struct Vector to_screen(struct Vector* ship, struct Vector* object) {
;	---------------------------------
; Function to_screen
; ---------------------------------
_to_screen::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
;..\modes\explorationmode.c:54: result.x = object->x - ship->x + mid_screen.width;
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #_mid_screen
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	push	bc
;..\modes\explorationmode.c:55: result.y = object->y - ship->y + mid_screen.height;
	ldhl	sp,	#4
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
	ldhl	sp,	#6
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #(_mid_screen + 2)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:56: return result;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;..\modes\explorationmode.c:57: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
;..\modes\explorationmode.c:59: void manage_asteroid(struct GameObject* ship) {
;	---------------------------------
; Function manage_asteroid
; ---------------------------------
_manage_asteroid::
	add	sp, #-8
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;..\modes\explorationmode.c:60: if(asteroid.isAlive == false){
	ld	hl, #(_asteroid + 4)
	ld	c, (hl)
;..\modes\explorationmode.c:71: asteroid.world.y = ship->world.y - randy;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;..\modes\explorationmode.c:72: if(asteroid.world.x < ship->world.x)asteroid.vector.x = 1;
;..\modes\explorationmode.c:74: if(asteroid.world.y < ship->world.y)asteroid.vector.y = 1;
;..\modes\explorationmode.c:60: if(asteroid.isAlive == false){
	ld	a, c
	or	a, a
	jp	NZ, 00130$
;..\modes\explorationmode.c:61: byte rando = rand();
	call	_rand
;..\modes\explorationmode.c:62: if(rando > 254) {
	ld	a, #0xfe
	sub	a, e
	jp	NC, 00132$
;..\modes\explorationmode.c:63: asteroid.isAlive = true;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x01
;..\modes\explorationmode.c:64: int randx = (int)rand();
	call	_rand
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\explorationmode.c:65: int randy = (int)rand();
	call	_rand
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\explorationmode.c:66: if(randx < 100)randx += 100; //make sure the asteroid is position at least 100 away
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, #0x64
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00303$
	bit	7, d
	jr	NZ, 00304$
	cp	a, a
	jr	00304$
00303$:
	bit	7, d
	jr	Z, 00304$
	scf
00304$:
	jr	NC, 00102$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0064
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
00102$:
;..\modes\explorationmode.c:67: if(randy < 100)randy += 100;
	ldhl	sp,	#6
	ld	a, (hl+)
	sub	a, #0x64
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00305$
	bit	7, d
	jr	NZ, 00306$
	cp	a, a
	jr	00306$
00305$:
	bit	7, d
	jr	Z, 00306$
	scf
00306$:
	jr	NC, 00104$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0064
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00104$:
;..\modes\explorationmode.c:68: if(randx % 2 == 0)randx = -randx; //50% of the time switch the sign so it comes from both sides
	ld	bc, #0x0002
	ldhl	sp,	#4
	ld	e, (hl)
	ld	d, #0x00
	call	__modsint
	ld	a, b
	or	a, c
	jr	NZ, 00106$
	ld	de, #0x0000
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	(hl), e
00106$:
;..\modes\explorationmode.c:69: if(randy % 2 == 0)randy = -randy;
	ld	bc, #0x0002
	ldhl	sp,	#6
	ld	e, (hl)
	ld	d, #0x00
	call	__modsint
	ld	a, b
	or	a, c
	jr	NZ, 00108$
	ld	de, #0x0000
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
00108$:
;..\modes\explorationmode.c:70: asteroid.world.x = ship->world.x - randx;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	a, e
	ld	hl, #_asteroid
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:71: asteroid.world.y = ship->world.y - randy;
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	a, e
	ld	hl, #(_asteroid + 2)
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:72: if(asteroid.world.x < ship->world.x)asteroid.vector.x = 1;
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	jr	Z, 00307$
	bit	7, d
	jr	NZ, 00308$
	cp	a, a
	jr	00308$
00307$:
	bit	7, d
	jr	Z, 00308$
	scf
00308$:
	jr	NC, 00110$
	ld	hl, #(_asteroid + 5)
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00111$
00110$:
;..\modes\explorationmode.c:73: else asteroid.vector.x = -1;
	ld	hl, #(_asteroid + 5)
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
00111$:
;..\modes\explorationmode.c:74: if(asteroid.world.y < ship->world.y)asteroid.vector.y = 1;
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00309$
	bit	7, d
	jr	NZ, 00310$
	cp	a, a
	jr	00310$
00309$:
	bit	7, d
	jr	Z, 00310$
	scf
00310$:
	jr	NC, 00113$
	ld	hl, #(_asteroid + 7)
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00114$
00113$:
;..\modes\explorationmode.c:75: else asteroid.vector.y = -1;
	ld	hl, #(_asteroid + 7)
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
00114$:
;..\modes\explorationmode.c:76: int screen_x = asteroid.world.x - ship->world.x + mid_screen.width;
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	de, #_mid_screen
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;..\modes\explorationmode.c:77: int screen_y = asteroid.world.y - ship->world.y + mid_screen.height;
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #(_mid_screen + 2)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
;..\modes\explorationmode.c:78: show(&asteroidGraphic);
	push	hl
	ld	de, #_asteroidGraphic
	call	_show
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_asteroidGraphic
	call	_move
	jp	00132$
00130$:
;..\modes\explorationmode.c:82: asteroid.world.x += asteroid.vector.x;
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_asteroid + 5)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_asteroid
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:83: asteroid.world.y += asteroid.vector.y;
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_asteroid + 7)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_asteroid + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:84: if(photon.isAlive == true && asteroid.world.x/8 == photon.world.x/8 && asteroid.world.y/8 == photon.world.y/8) {
	ld	a, (#(_photon + 4) + 0)
	dec	a
	jp	NZ,00118$
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00134$
	ld	hl, #0x0007
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00134$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	de, #_photon
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00135$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00135$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	sub	a, c
	jp	NZ,00118$
	ld	a, d
	sub	a, b
	jp	NZ,00118$
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00136$
	ld	hl, #0x0007
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00136$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	de, #(_photon + 2)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00137$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00137$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	sub	a, c
	jr	NZ, 00118$
	ld	a, d
	sub	a, b
	jr	NZ, 00118$
;..\modes\explorationmode.c:85: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:86: photon.isAlive = false;
	ld	hl, #(_photon + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:87: hide(&asteroidGraphic);
	ld	de, #_asteroidGraphic
	call	_hide
;..\modes\explorationmode.c:88: hide(&photonGraphic);
	ld	de, #_photonGraphic
	call	_hide
;..\modes\explorationmode.c:89: do_explosion(photon.world.x, photon.world.y);
	ld	hl, #(_photon + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_photon
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, a
	ld	d, h
	call	_do_explosion
00118$:
;..\modes\explorationmode.c:91: if(ship->isAlive == true && asteroid.world.x/8 == ship->world.x/8 && asteroid.world.y/8 == ship->world.y/8) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jp	NZ,00122$
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00138$
	ld	hl, #0x0007
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00138$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,#2
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
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00139$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00139$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	sub	a, c
	jp	NZ,00122$
	ld	a, d
	sub	a, b
	jp	NZ,00122$
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	bit	7, b
	jr	Z, 00140$
	ld	hl, #0x0007
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00140$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00141$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
00141$:
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	sub	a, c
	jr	NZ, 00122$
	ld	a, d
	sub	a, b
	jr	NZ, 00122$
;..\modes\explorationmode.c:92: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:93: hide(&asteroidGraphic);
	ld	de, #_asteroidGraphic
	call	_hide
;..\modes\explorationmode.c:94: do_explosion(ship->world.x, ship->world.y);
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
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
	ld	e, l
	ld	d, h
	call	_do_explosion
;..\modes\explorationmode.c:95: do_gameover(ship);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_do_gameover
00122$:
;..\modes\explorationmode.c:97: if(abs(asteroid.world.x - ship->world.x) > 255 || abs(asteroid.world.y - ship->world.y) > 255) { //we're so far away, kill the asteroid
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	bc
	call	_abs
	pop	hl
	ld	c, e
	ld	b, d
	ld	e, b
	ld	d, #0x00
	ld	a, #0xff
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00323$
	bit	7, d
	jr	NZ, 00324$
	cp	a, a
	jr	00324$
00323$:
	bit	7, d
	jr	Z, 00324$
	scf
00324$:
	jr	C, 00125$
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	push	bc
	call	_abs
	pop	hl
	ld	c, e
	ld	b, d
	ld	e, b
	ld	d, #0x00
	ld	a, #0xff
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00325$
	bit	7, d
	jr	NZ, 00326$
	cp	a, a
	jr	00326$
00325$:
	bit	7, d
	jr	Z, 00326$
	scf
00326$:
	jr	NC, 00126$
00125$:
;..\modes\explorationmode.c:98: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x00
	jr	00132$
00126$:
;..\modes\explorationmode.c:102: int screen_x = asteroid.world.x - ship->world.x + mid_screen.width;
	ld	hl, #_asteroid
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	de, #_mid_screen
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;..\modes\explorationmode.c:103: int screen_y = asteroid.world.y - ship->world.y + mid_screen.height;
	ld	hl, #(_asteroid + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #(_mid_screen + 2)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
;..\modes\explorationmode.c:106: move(&asteroidGraphic, screen_x, screen_y);
	push	hl
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_asteroidGraphic
	call	_move
00132$:
;..\modes\explorationmode.c:109: }
	add	sp, #8
	ret
;..\modes\explorationmode.c:111: void ExplorationMode_init(struct ExplorationMode* this) {
;	---------------------------------
; Function ExplorationMode_init
; ---------------------------------
_ExplorationMode_init::
	dec	sp
	ld	c, e
	ld	b, d
;..\modes\explorationmode.c:112: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;..\modes\explorationmode.c:113: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;..\modes\explorationmode.c:114: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;..\modes\explorationmode.c:115: sprites_reset();
	push	bc
	call	_sprites_reset
	pop	bc
;..\modes\explorationmode.c:116: set_bkg_data(0, 48, space1_tile);
	ld	de, #_space1_tile
	push	de
	ld	hl, #0x3000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;..\modes\explorationmode.c:117: set_bkg_tiles(0, 0, bckground_mapWidth, bckground_mapHeight, bckground_map);
	ld	de, #_bckground_map
	push	de
	ld	hl, #0x2020
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;..\modes\explorationmode.c:118: set_bkg_palette(0,1, space_pallette);
	push	bc
	ld	de, #_space_pallette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
	pop	bc
;..\modes\explorationmode.c:119: this->counter = 0;
	ld	l, c
	ld	h, b
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\modes\explorationmode.c:120: byte ship_pal = create_palette(0xFFFFFF,RGB8(200,200,200),RGB8(127, 127, 127),RGB8(255, 255, 255));
	push	bc
	ld	de, #0x7fff
	push	de
	ld	de, #0x3def
	push	de
	ld	bc, #0x6739
	ld	de, #0xffff
	call	_create_palette
	ld	de, #0x001f
	push	de
	ld	de, #0x229f
	push	de
	ld	bc, #0x7fff
	ld	de, #0x0000
	call	_create_palette
	ldhl	sp,	#2
	ld	(hl), a
	ld	de, #0x0320
	push	de
	ld	de, #0x4180
	push	de
	ld	bc, #0x20c0
	ld	de, #0x0000
	call	_create_palette
	pop	bc
	ld	(#_hGameOverPalette),a
;..\modes\explorationmode.c:125: this->exploration_objects = gameobjects(0);
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	push	hl
	ld	de, #0x0000
	call	_gameobjects
	pop	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:127: sprite_init(&gameoverGraphic, gameover_tiles, RENDER_8X8, 6, 1, 1);
	ld	de, #0x0001
	push	de
	push	de
	ld	de, #0x0006
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	bc, #_gameover_tiles
	ld	de, #_gameoverGraphic
	call	_sprite_init
;..\modes\explorationmode.c:128: setFrame(&gameoverGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_gameoverGraphic
	call	_setFrame
;..\modes\explorationmode.c:129: setPalette(&gameoverGraphic, hGameOverPalette);
	ld	a, (#_hGameOverPalette)
	ld	de, #_gameoverGraphic
	call	_setPalette
;..\modes\explorationmode.c:130: move(&gameoverGraphic, 300, 300);
	ld	de, #0x012c
	push	de
	ld	bc, #0x012c
	ld	de, #_gameoverGraphic
	call	_move
;..\modes\explorationmode.c:131: hide(&gameoverGraphic);
	ld	de, #_gameoverGraphic
	call	_hide
;..\modes\explorationmode.c:133: sprite_init(&shipGraphic, enterprise_tiles, RENDER_16X16, 2, 2, 8);
	ld	de, #0x0008
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	bc, #_enterprise_tiles
	ld	de, #_shipGraphic
	call	_sprite_init
;..\modes\explorationmode.c:134: setFrame(&shipGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_shipGraphic
	call	_setFrame
;..\modes\explorationmode.c:135: move(&shipGraphic, mid_screen.width, mid_screen.height);
	ld	hl, #_mid_screen + 2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_mid_screen
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	ld	c, l
	ld	b, h
	ld	de, #_shipGraphic
	call	_move
;..\modes\explorationmode.c:137: sprite_init(&saturnGraphic, saturn_tiles, RENDER_16X16, 2, 2, 1);
	ld	de, #0x0001
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	bc, #_saturn_tiles
	ld	de, #_saturnGraphic
	call	_sprite_init
;..\modes\explorationmode.c:138: setFrame(&saturnGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_saturnGraphic
	call	_setFrame
;..\modes\explorationmode.c:139: setPalette(&saturnGraphic, create_palette(0, RGB8(255, 200, 200), RGB8(200, 50, 50), RGB8(255, 160, 68)));
	ld	de, #0x229f
	push	de
	ld	de, #0x18d9
	push	de
	ld	bc, #0x673f
	ld	de, #0x0000
	call	_create_palette
	ld	de, #_saturnGraphic
	call	_setPalette
;..\modes\explorationmode.c:142: photon.isAlive = false;
	ld	hl, #(_photon + 4)
;..\modes\explorationmode.c:143: sprite_init(&photonGraphic, photon_tiles, RENDER_8X8,  1, 1, 2);
	ld	de, #0x0002
	ld	(hl), d
	push	de
	ld	de, #0x0001
	push	de
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	bc, #_photon_tiles
	ld	de, #_photonGraphic
	call	_sprite_init
;..\modes\explorationmode.c:144: setFrame(&photonGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_photonGraphic
	call	_setFrame
;..\modes\explorationmode.c:145: setPalette(&photonGraphic, fire_pallet);
	ldhl	sp,	#0
	ld	a, (hl)
	ld	de, #_photonGraphic
	call	_setPalette
;..\modes\explorationmode.c:146: hide(&photonGraphic);
	ld	de, #_photonGraphic
	call	_hide
;..\modes\explorationmode.c:148: sprite_init(&asteroidGraphic, asteroid_tiles, RENDER_8X8, 1, 1, 4);
	ld	de, #0x0004
	push	de
	ld	de, #0x0001
	push	de
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	bc, #_asteroid_tiles
	ld	de, #_asteroidGraphic
	call	_sprite_init
;..\modes\explorationmode.c:149: setFrame(&asteroidGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_asteroidGraphic
	call	_setFrame
;..\modes\explorationmode.c:150: hide(&asteroidGraphic);
	ld	de, #_asteroidGraphic
	call	_hide
;..\modes\explorationmode.c:152: setPalette(&asteroidGraphic, create_palette(0, RGB8(223, 223, 223), RGB8(128, 128, 128), RGB8(64, 64, 64)));
	ld	de, #0x2108
	push	de
	ld	de, #0x4210
	push	de
	ld	bc, #0x6f7b
	ld	de, #0x0000
	call	_create_palette
	ld	de, #_asteroidGraphic
	call	_setPalette
;..\modes\explorationmode.c:153: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
;..\modes\explorationmode.c:155: sprite_init(&explosionGraphic, explosion_tiles, RENDER_16X16, 2, 2, 4);
	ld	de, #0x0004
	ld	(hl), d
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	bc, #_explosion_tiles
	ld	de, #_explosionGraphic
	call	_sprite_init
;..\modes\explorationmode.c:156: setFrame(&explosionGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_explosionGraphic
	call	_setFrame
;..\modes\explorationmode.c:157: hide(&explosionGraphic);
	ld	de, #_explosionGraphic
	call	_hide
;..\modes\explorationmode.c:158: setPalette(&explosionGraphic, fire_pallet);
	ldhl	sp,	#0
	ld	a, (hl)
	ld	de, #_explosionGraphic
	call	_setPalette
;..\modes\explorationmode.c:159: explosion.isAlive = false;
	ld	hl, #(_explosion + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:162: }
	inc	sp
	ret
;..\modes\explorationmode.c:164: void ExplorationMode_update(struct ExplorationMode* this) {
;	---------------------------------
; Function ExplorationMode_update
; ---------------------------------
_ExplorationMode_update::
	add	sp, #-14
	ldhl	sp,	#12
	ld	a, e
	ld	(hl+), a
;..\modes\explorationmode.c:165: this->counter++;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:166: if(this->counter > 10) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x0a
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00205$
	bit	7, d
	jr	NZ, 00206$
	cp	a, a
	jr	00206$
00205$:
	bit	7, d
	jr	Z, 00206$
	scf
00206$:
	jp	NC, 00115$
;..\modes\explorationmode.c:167: this->counter = 0;
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\modes\explorationmode.c:169: if(photon.isAlive){
	ld	a, (#(_photon + 4) + 0)
	ldhl	sp,#11
	ld	(hl), a
	or	a, a
	jr	Z, 00104$
;..\modes\explorationmode.c:170: photonGraphic.frame++;
	dec	hl
	ld	de, #(_photonGraphic + 15)
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_photonGraphic + 15)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:171: if(photonGraphic.frame > 1)photonGraphic.frame = 0;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x01
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00207$
	bit	7, d
	jr	NZ, 00208$
	cp	a, a
	jr	00208$
00207$:
	bit	7, d
	jr	Z, 00208$
	scf
00208$:
	jr	NC, 00102$
	ld	hl, #(_photonGraphic + 15)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00102$:
;..\modes\explorationmode.c:172: setFrame(&photonGraphic, photonGraphic.frame);
	ld	hl, #(_photonGraphic + 15)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_photonGraphic
	call	_setFrame
00104$:
;..\modes\explorationmode.c:174: if(asteroid.isAlive == true){
	ld	a, (#(_asteroid + 4) + 0)
	dec	a
	jr	NZ, 00108$
;..\modes\explorationmode.c:175: asteroidGraphic.frame++;
	ld	hl, #(_asteroidGraphic + 15)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_asteroidGraphic + 15)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:176: if(asteroidGraphic.frame > 3) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x03
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00211$
	bit	7, d
	jr	NZ, 00212$
	cp	a, a
	jr	00212$
00211$:
	bit	7, d
	jr	Z, 00212$
	scf
00212$:
	jr	NC, 00106$
;..\modes\explorationmode.c:177: asteroidGraphic.frame = 0;
	ld	hl, #(_asteroidGraphic + 15)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00106$:
;..\modes\explorationmode.c:179: setFrame(&asteroidGraphic, asteroidGraphic.frame);
	ld	hl, #(_asteroidGraphic + 15)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_asteroidGraphic
	call	_setFrame
00108$:
;..\modes\explorationmode.c:181: if(explosion.isAlive == true) {
	ld	a, (#(_explosion + 4) + 0)
	dec	a
	jr	NZ, 00115$
;..\modes\explorationmode.c:182: explosionGraphic.frame++;
	ld	hl, #(_explosionGraphic + 15)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_explosionGraphic + 15)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:183: if(explosionGraphic.frame > 3) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x03
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00215$
	bit	7, d
	jr	NZ, 00216$
	cp	a, a
	jr	00216$
00215$:
	bit	7, d
	jr	Z, 00216$
	scf
00216$:
	jr	NC, 00110$
;..\modes\explorationmode.c:184: explosion.isAlive = false;
	ld	hl, #(_explosion + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:185: hide(&explosionGraphic);
	ld	de, #_explosionGraphic
	call	_hide
;..\modes\explorationmode.c:186: setFrame(&explosionGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_explosionGraphic
	call	_setFrame
	jr	00115$
00110$:
;..\modes\explorationmode.c:189: setFrame(&explosionGraphic, explosionGraphic.frame);
	ld	hl, #(_explosionGraphic + 15)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_explosionGraphic
	call	_setFrame
00115$:
;..\modes\explorationmode.c:195: if(photon.isAlive) {
	ld	a, (#(_photon + 4) + 0)
	or	a, a
	jr	Z, 00117$
;..\modes\explorationmode.c:196: photon.world.x += photon.vector.x;
	ld	hl, #_photon
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_photon + 5)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_photon
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:197: photon.world.y += photon.vector.y;
	ld	de, #(_photon + 2)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #(_photon + 7)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_photon + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00117$:
;..\modes\explorationmode.c:200: struct GameObject* ship = gameobjects(GO_SHIP);
	ld	de, #0x0000
	call	_gameobjects
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:201: manage_asteroid(ship);
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_manage_asteroid
;..\modes\explorationmode.c:203: if(explosion.isAlive == true){
	ld	a, (#(_explosion + 4) + 0)
	dec	a
	jr	NZ, 00119$
;..\modes\explorationmode.c:205: screen = to_screen(&ship->world, &explosion.world);
	ld	bc, #_explosion
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	push	hl
	call	_to_screen
	ldhl	sp,	#4
	ld	c, l
	ld	b, h
	ld	de, #0x0004
	push	de
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	___memcpy
;..\modes\explorationmode.c:206: move(&explosionGraphic, screen.x, screen.y);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl-), a
	ld	de, #_explosionGraphic
	push	bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_move
00119$:
;..\modes\explorationmode.c:209: if(ship->isAlive == false && this->gameover_fader < 255){
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00123$
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0xff
	jr	NC, 00123$
;..\modes\explorationmode.c:210: this->gameover_fader++;
	inc	a
;..\modes\explorationmode.c:211: update_palette(hGameOverPalette, RGB8(0, 0, 0), RGB8(0, 50, 64), RGB8(0, 100, 128), RGB8(0, this->gameover_fader/2, this->gameover_fader));
	ld	e, a
	ld	(bc), a
	swap	a
	rlca
	and	a, #0x1f
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	add	a, a
	add	a, a
	ld	b, a
	ld	c, #0x00
	ld	d, c
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	a, e
	and	a, #0x1f
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, c
	or	a, l
	ld	c, a
	ld	a, b
	or	a, h
	ld	b, a
	push	bc
	ld	de, #0x4180
	push	de
	ld	de, #0x20c0
	push	de
	ld	de, #0x0000
	ld	a, (#_hGameOverPalette)
	call	_update_palette
00123$:
;..\modes\explorationmode.c:214: }
	add	sp, #14
	ret
;..\modes\explorationmode.c:217: void ExplorationMode_processInput(struct ExplorationMode* this, byte joypad) {
;	---------------------------------
; Function ExplorationMode_processInput
; ---------------------------------
_ExplorationMode_processInput::
	add	sp, #-20
	ldhl	sp,	#15
;..\modes\explorationmode.c:218: int x = 0; int y = 0;
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\modes\explorationmode.c:219: struct GameObject* ship = this->exploration_objects + GO_SHIP;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	sp
	inc	sp
	push	bc
;..\modes\explorationmode.c:220: struct GameObject* planet1 = this->exploration_objects + GO_PLANET1;
	ld	hl, #0x0009
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;..\modes\explorationmode.c:221: if(ship->isAlive == false)return;
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	or	a, a
	jp	Z,00138$
;..\modes\explorationmode.c:225: if (joypad & J_RIGHT)
	push	hl
	ldhl	sp,	#17
	bit	0, (hl)
	pop	hl
	jr	Z, 00104$
;..\modes\explorationmode.c:227: x++;
	ldhl	sp,	#16
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00104$:
;..\modes\explorationmode.c:231: if (joypad & J_LEFT)
	push	hl
	ldhl	sp,	#17
	bit	1, (hl)
	pop	hl
	jr	Z, 00106$
;..\modes\explorationmode.c:233: x--;
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00106$:
;..\modes\explorationmode.c:237: if (joypad & J_DOWN)
	push	hl
	ldhl	sp,	#17
	bit	3, (hl)
	pop	hl
	jr	Z, 00108$
;..\modes\explorationmode.c:239: y++;
	ldhl	sp,	#18
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00108$:
;..\modes\explorationmode.c:243: if (joypad & J_UP)
	push	hl
	ldhl	sp,	#17
	bit	2, (hl)
	pop	hl
	jr	Z, 00110$
;..\modes\explorationmode.c:245: y--;
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00110$:
;..\modes\explorationmode.c:251: photon.world.y = ship->world.y + 4;
	pop	de
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;..\modes\explorationmode.c:254: photon.vector.x = ship->vector.x * 2;
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
;..\modes\explorationmode.c:255: photon.vector.y = ship->vector.y * 2;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;..\modes\explorationmode.c:248: if(joypad & J_A) {
	push	hl
	ldhl	sp,	#17
	bit	4, (hl)
	pop	hl
	jr	Z, 00114$
;..\modes\explorationmode.c:249: if(photon.isAlive == false){
	ld	a, (#(_photon + 4) + 0)
	or	a, a
	jr	NZ, 00114$
;..\modes\explorationmode.c:250: photon.world.x = ship->world.x + 8;
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #_photon
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:251: photon.world.y = ship->world.y + 4;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	hl, #(_photon + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:252: show(&photonGraphic);
	ld	de, #_photonGraphic
	call	_show
;..\modes\explorationmode.c:253: photon.isAlive = true;
	ld	hl, #(_photon + 4)
	ld	(hl), #0x01
;..\modes\explorationmode.c:254: photon.vector.x = ship->vector.x * 2;
	ldhl	sp,#6
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
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #(_photon + 5)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:255: photon.vector.y = ship->vector.y * 2;
	ldhl	sp,#8
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
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #(_photon + 7)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00114$:
;..\modes\explorationmode.c:258: if(x == 0 & y < 0)setFrame(&shipGraphic, 0);
	ldhl	sp,	#16
	ld	a, (hl+)
	or	a, a
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00265$
	xor	a, a
00265$:
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#19
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#10
	and	a,(hl)
	jr	Z, 00116$
	ld	bc, #0x0000
	ld	de, #_shipGraphic
	call	_setFrame
00116$:
;..\modes\explorationmode.c:259: if(x > 0 & y == 0)setFrame(&shipGraphic, 1);
	ldhl	sp,	#16
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00266$
	bit	7, d
	jr	NZ, 00267$
	cp	a, a
	jr	00267$
00266$:
	bit	7, d
	jr	Z, 00267$
	scf
00267$:
	ld	a, #0x00
	rla
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl+)
	or	a, a
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00269$
	xor	a, a
00269$:
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	and	a,(hl)
	jr	Z, 00118$
	ld	bc, #0x0001
	ld	de, #_shipGraphic
	call	_setFrame
00118$:
;..\modes\explorationmode.c:260: if(x == 0 & y > 0)setFrame(&shipGraphic, 2);
	ldhl	sp,	#18
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00270$
	bit	7, d
	jr	NZ, 00271$
	cp	a, a
	jr	00271$
00270$:
	bit	7, d
	jr	Z, 00271$
	scf
00271$:
	ld	a, #0x00
	rla
	ldhl	sp,	#13
	ld	(hl+), a
	ld	a, (hl-)
	and	a,(hl)
	jr	Z, 00120$
	ld	bc, #0x0002
	ld	de, #_shipGraphic
	call	_setFrame
00120$:
;..\modes\explorationmode.c:261: if(x < 0 & y == 0)setFrame(&shipGraphic, 3);
	ldhl	sp,	#17
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	and	a,(hl)
	jr	Z, 00122$
	ld	bc, #0x0003
	ld	de, #_shipGraphic
	call	_setFrame
00122$:
;..\modes\explorationmode.c:262: if(x < 0 & y < 0)setFrame(&shipGraphic, 4);
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#10
	and	a,(hl)
	jr	Z, 00124$
	ld	bc, #0x0004
	ld	de, #_shipGraphic
	call	_setFrame
00124$:
;..\modes\explorationmode.c:263: if(x > 0 & y < 0)setFrame(&shipGraphic, 5);
	ldhl	sp,	#11
	ld	a, (hl-)
	and	a,(hl)
	jr	Z, 00126$
	ld	bc, #0x0005
	ld	de, #_shipGraphic
	call	_setFrame
00126$:
;..\modes\explorationmode.c:264: if(x > 0 & y > 0)setFrame(&shipGraphic, 6);
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	and	a,(hl)
	jr	Z, 00128$
	ld	bc, #0x0006
	ld	de, #_shipGraphic
	call	_setFrame
00128$:
;..\modes\explorationmode.c:265: if(x < 0 & y > 0)setFrame(&shipGraphic, 7);
	ldhl	sp,	#14
	ld	a, (hl-)
	and	a,(hl)
	jr	Z, 00130$
	ld	bc, #0x0007
	ld	de, #_shipGraphic
	call	_setFrame
00130$:
;..\modes\explorationmode.c:267: ship->world.x += x;
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:268: ship->world.y += y;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#18
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:269: if(x != 0 || y != 0) { //if we pushed something store it as the new vector.
	ldhl	sp,	#17
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00131$
	ldhl	sp,	#19
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00132$
00131$:
;..\modes\explorationmode.c:270: ship->vector.x = x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\modes\explorationmode.c:271: ship->vector.y = y;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00132$:
;..\modes\explorationmode.c:274: int screen_x = planet1->world.x - ship->world.x + mid_screen.width;
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
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	de, #_mid_screen
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
;..\modes\explorationmode.c:275: int screen_y = planet1->world.y - ship->world.y + mid_screen.height;
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	hl, #(_mid_screen + 2)
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
;..\modes\explorationmode.c:276: move(&saturnGraphic, screen_x, screen_y);
	push	hl
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_saturnGraphic
	call	_move
;..\modes\explorationmode.c:278: screen_x = photon.world.x - ship->world.x + mid_screen.width;
	ld	hl, #_photon
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	de, #_mid_screen
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
;..\modes\explorationmode.c:279: screen_y = photon.world.y - ship->world.y + mid_screen.height;
	ld	hl, #(_photon + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ld	de, #(_mid_screen + 2)
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
;..\modes\explorationmode.c:280: if(!isOnScreen(&photonGraphic, screen_x, screen_y)) {
	ld	(hl-), a
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl
	push	de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	de, #_photonGraphic
	call	_isOnScreen
	or	a, a
	jr	NZ, 00135$
;..\modes\explorationmode.c:281: photon.isAlive = false;
	ld	hl, #(_photon + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:282: hide(&photonGraphic);
	ld	de, #_photonGraphic
	call	_hide
	jr	00136$
00135$:
;..\modes\explorationmode.c:283: } else 	move(&photonGraphic, screen_x, screen_y);
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_photonGraphic
	call	_move
00136$:
;..\modes\explorationmode.c:284: scroll_bkg(x, y);
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	b, (hl)
;c:\source\gameboy\gbdk-win64\gbdk\include\gb\gb.h:1392: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG + 0)
	add	a, b
	ldh	(_SCX_REG + 0), a
	ldh	a, (_SCY_REG + 0)
	add	a, c
	ldh	(_SCY_REG + 0), a
;..\modes\explorationmode.c:284: scroll_bkg(x, y);
00138$:
;..\modes\explorationmode.c:285: }
	add	sp, #20
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__mid_screen:
	.dw #0x0054
	.dw #0x0054
	.area _CABS (ABS)
