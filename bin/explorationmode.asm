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
	.globl _do_explosion
	.globl _gameobjects
	.globl _sprites_reset
	.globl _hide
	.globl _show
	.globl _setPalette
	.globl _isOnScreen
	.globl _createPalette
	.globl _move
	.globl _setFrame
	.globl _ctor
	.globl _set_bkg_palette
	.globl _abs
	.globl _rand
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _mid_screen
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
	.ds 20
_explosion::
	.ds 9
_photonGraphic::
	.ds 20
_shipGraphic::
	.ds 20
_asteroidGraphic::
	.ds 20
_explosionGraphic::
	.ds 20
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
;..\modes\explorationmode.c:34: void do_explosion(int world_x, int world_y) {
;	---------------------------------
; Function do_explosion
; ---------------------------------
_do_explosion::
	push	de
;..\modes\explorationmode.c:35: explosion.isAlive = true;
	ld	hl, #(_explosion + 4)
	ld	(hl), #0x01
;..\modes\explorationmode.c:36: explosion.world.x = world_x;
	ld	de, #_explosion
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\modes\explorationmode.c:37: explosion.world.y = world_y;
	ld	hl, #(_explosion + 2)
	ld	(hl), c
	inc	hl
	ld	(hl), b
;..\modes\explorationmode.c:38: show(&explosionGraphic);
	ld	de, #_explosionGraphic
	inc	sp
	inc	sp
	jp	_show
;..\modes\explorationmode.c:39: }
	inc	sp
	inc	sp
	ret
_space_pallette:
	.dw #0x2108
	.dw #0x20c0
	.dw #0x0024
	.dw #0x0000
;..\modes\explorationmode.c:41: struct Vector to_screen(struct Vector* ship, struct Vector* object) {
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
;..\modes\explorationmode.c:43: result.x = object->x - ship->x + mid_screen.width;
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
;..\modes\explorationmode.c:44: result.y = object->y - ship->y + mid_screen.height;
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
;..\modes\explorationmode.c:45: return result;
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
;..\modes\explorationmode.c:46: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
;..\modes\explorationmode.c:48: void manage_asteroid(struct GameObject* ship) {
;	---------------------------------
; Function manage_asteroid
; ---------------------------------
_manage_asteroid::
	add	sp, #-8
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;..\modes\explorationmode.c:49: if(asteroid.isAlive == false){
	ld	hl, #(_asteroid + 4)
	ld	c, (hl)
;..\modes\explorationmode.c:60: asteroid.world.y = ship->world.y - randy;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;..\modes\explorationmode.c:61: if(asteroid.world.x < ship->world.x)asteroid.vector.x = 1;
;..\modes\explorationmode.c:63: if(asteroid.world.y < ship->world.y)asteroid.vector.y = 1;
;..\modes\explorationmode.c:49: if(asteroid.isAlive == false){
	ld	a, c
	or	a, a
	jp	NZ, 00125$
;..\modes\explorationmode.c:50: byte rando = rand();
	call	_rand
;..\modes\explorationmode.c:51: if(rando > 254) {
	ld	a, #0xfe
	sub	a, e
	jp	NC, 00127$
;..\modes\explorationmode.c:52: asteroid.isAlive = true;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x01
;..\modes\explorationmode.c:53: int randx = (int)rand();
	call	_rand
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\explorationmode.c:54: int randy = (int)rand();
	call	_rand
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
;..\modes\explorationmode.c:55: if(randx < 100)randx += 100; //make sure the asteroid is position at least 100 away
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, #0x64
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00245$
	bit	7, d
	jr	NZ, 00246$
	cp	a, a
	jr	00246$
00245$:
	bit	7, d
	jr	Z, 00246$
	scf
00246$:
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
;..\modes\explorationmode.c:56: if(randy < 100)randy += 100;
	ldhl	sp,	#6
	ld	a, (hl+)
	sub	a, #0x64
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00247$
	bit	7, d
	jr	NZ, 00248$
	cp	a, a
	jr	00248$
00247$:
	bit	7, d
	jr	Z, 00248$
	scf
00248$:
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
;..\modes\explorationmode.c:57: if(randx % 2 == 0)randx = -randx; //50% of the time switch the sign so it comes from both sides
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
;..\modes\explorationmode.c:58: if(randy % 2 == 0)randy = -randy;
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
;..\modes\explorationmode.c:59: asteroid.world.x = ship->world.x - randx;
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
;..\modes\explorationmode.c:60: asteroid.world.y = ship->world.y - randy;
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
;..\modes\explorationmode.c:61: if(asteroid.world.x < ship->world.x)asteroid.vector.x = 1;
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
	jr	Z, 00249$
	bit	7, d
	jr	NZ, 00250$
	cp	a, a
	jr	00250$
00249$:
	bit	7, d
	jr	Z, 00250$
	scf
00250$:
	jr	NC, 00110$
	ld	hl, #(_asteroid + 5)
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00111$
00110$:
;..\modes\explorationmode.c:62: else asteroid.vector.x = -1;
	ld	hl, #(_asteroid + 5)
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
00111$:
;..\modes\explorationmode.c:63: if(asteroid.world.y < ship->world.y)asteroid.vector.y = 1;
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
	jr	Z, 00251$
	bit	7, d
	jr	NZ, 00252$
	cp	a, a
	jr	00252$
00251$:
	bit	7, d
	jr	Z, 00252$
	scf
00252$:
	jr	NC, 00113$
	ld	hl, #(_asteroid + 7)
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x00
	jr	00114$
00113$:
;..\modes\explorationmode.c:64: else asteroid.vector.y = -1;
	ld	hl, #(_asteroid + 7)
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0xff
00114$:
;..\modes\explorationmode.c:65: int screen_x = asteroid.world.x - ship->world.x + mid_screen.width;
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
;..\modes\explorationmode.c:66: int screen_y = asteroid.world.y - ship->world.y + mid_screen.height;
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
;..\modes\explorationmode.c:67: show(&asteroidGraphic);
	push	hl
	ld	de, #_asteroidGraphic
	call	_show
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_asteroidGraphic
	call	_move
	jp	00127$
00125$:
;..\modes\explorationmode.c:71: asteroid.world.x += asteroid.vector.x;
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
;..\modes\explorationmode.c:72: asteroid.world.y += asteroid.vector.y;
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
;..\modes\explorationmode.c:73: if(photon.isAlive == true && asteroid.world.x/8 == photon.world.x/8 && asteroid.world.y/8 == photon.world.y/8) {
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
	jr	Z, 00129$
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
00129$:
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
	jr	Z, 00130$
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
00130$:
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
	jr	Z, 00131$
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
00131$:
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
	jr	Z, 00132$
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
00132$:
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
;..\modes\explorationmode.c:74: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:75: photon.isAlive = false;
	ld	hl, #(_photon + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:76: hide(&asteroidGraphic);
	ld	de, #_asteroidGraphic
	call	_hide
;..\modes\explorationmode.c:77: hide(&photonGraphic);
	ld	de, #_photonGraphic
	call	_hide
;..\modes\explorationmode.c:78: do_explosion(photon.world.x, photon.world.y);
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
;..\modes\explorationmode.c:80: if(abs(asteroid.world.x - ship->world.x) > 255) { //we're so far away, kill the asteroid
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
	jr	Z, 00259$
	bit	7, d
	jr	NZ, 00260$
	cp	a, a
	jr	00260$
00259$:
	bit	7, d
	jr	Z, 00260$
	scf
00260$:
	jr	NC, 00122$
;..\modes\explorationmode.c:81: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
	ld	(hl), #0x00
	jr	00127$
00122$:
;..\modes\explorationmode.c:85: int screen_x = asteroid.world.x - ship->world.x + mid_screen.width;
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
;..\modes\explorationmode.c:86: int screen_y = asteroid.world.y - ship->world.y + mid_screen.height;
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
;..\modes\explorationmode.c:89: move(&asteroidGraphic, screen_x, screen_y);
	push	hl
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_asteroidGraphic
	call	_move
00127$:
;..\modes\explorationmode.c:92: }
	add	sp, #8
	ret
;..\modes\explorationmode.c:94: void ExplorationMode_init(struct ExplorationMode* this) {
;	---------------------------------
; Function ExplorationMode_init
; ---------------------------------
_ExplorationMode_init::
	dec	sp
	ld	c, e
	ld	b, d
;..\modes\explorationmode.c:95: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;..\modes\explorationmode.c:96: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;..\modes\explorationmode.c:97: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;..\modes\explorationmode.c:98: sprites_reset();
	push	bc
	call	_sprites_reset
	pop	bc
;..\modes\explorationmode.c:99: set_bkg_data(0, 12, space1_tile);
	ld	de, #_space1_tile
	push	de
	ld	hl, #0xc00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;..\modes\explorationmode.c:100: set_bkg_tiles(0, 0, bckground_mapWidth, bckground_mapHeight, bckground_map);
	ld	de, #_bckground_map
	push	de
	ld	hl, #0x2020
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;..\modes\explorationmode.c:101: set_bkg_palette(0,1, space_pallette);
	push	bc
	ld	de, #_space_pallette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
	pop	bc
;..\modes\explorationmode.c:102: this->counter = 0;
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;..\modes\explorationmode.c:103: byte ship_pal = createPalette(0xFFFFFF,RGB8(200,200,200),RGB8(127, 127, 127),RGB8(255, 255, 255));
	ld	de, #0x7fff
	push	de
	ld	de, #0x3def
	push	de
	ld	bc, #0x6739
	ld	de, #0xffff
	call	_createPalette
;..\modes\explorationmode.c:107: ctor(&shipGraphic, enterprise_tiles, 2, 2, 8);
	ld	de, #0x0008
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	bc, #_enterprise_tiles
	ld	de, #_shipGraphic
	call	_ctor
;..\modes\explorationmode.c:109: setFrame(&shipGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_shipGraphic
	call	_setFrame
;..\modes\explorationmode.c:110: move(&shipGraphic, mid_screen.width, mid_screen.height);
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
;..\modes\explorationmode.c:112: ctor(&saturnGraphic, saturn_tiles, 2, 2, 1);
	ld	de, #0x0001
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	bc, #_saturn_tiles
	ld	de, #_saturnGraphic
	call	_ctor
;..\modes\explorationmode.c:113: setFrame(&saturnGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_saturnGraphic
	call	_setFrame
;..\modes\explorationmode.c:114: setPalette(&saturnGraphic, createPalette(0, RGB8(255, 200, 200), RGB8(200, 50, 50), RGB8(255, 160, 68)));
	ld	de, #0x229f
	push	de
	ld	de, #0x18d9
	push	de
	ld	bc, #0x673f
	ld	de, #0x0000
	call	_createPalette
	ld	de, #_saturnGraphic
	call	_setPalette
;..\modes\explorationmode.c:116: byte fire_pallet = createPalette(0, RGB_WHITE, RGB8(255, 160, 68), RGB_RED);
	ld	de, #0x001f
	push	de
	ld	de, #0x229f
	push	de
	ld	bc, #0x7fff
	ld	de, #0x0000
	call	_createPalette
	ldhl	sp,	#0
	ld	(hl), a
;..\modes\explorationmode.c:117: photon.isAlive = false;
	ld	hl, #(_photon + 4)
;..\modes\explorationmode.c:118: ctor(&photonGraphic, photon_tiles, 1, 1, 2);
	ld	de, #0x0002
	ld	(hl), d
	push	de
	ld	de, #0x0001
	push	de
	push	de
	ld	bc, #_photon_tiles
	ld	de, #_photonGraphic
	call	_ctor
;..\modes\explorationmode.c:119: setFrame(&photonGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_photonGraphic
	call	_setFrame
;..\modes\explorationmode.c:120: setPalette(&photonGraphic, fire_pallet);
	ldhl	sp,	#0
	ld	a, (hl)
	ld	de, #_photonGraphic
	call	_setPalette
;..\modes\explorationmode.c:121: hide(&photonGraphic);
	ld	de, #_photonGraphic
	call	_hide
;..\modes\explorationmode.c:123: ctor(&asteroidGraphic, asteroid_tiles, 1, 1, 4);
	ld	de, #0x0004
	push	de
	ld	de, #0x0001
	push	de
	push	de
	ld	bc, #_asteroid_tiles
	ld	de, #_asteroidGraphic
	call	_ctor
;..\modes\explorationmode.c:124: setFrame(&asteroidGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_asteroidGraphic
	call	_setFrame
;..\modes\explorationmode.c:125: hide(&asteroidGraphic);
	ld	de, #_asteroidGraphic
	call	_hide
;..\modes\explorationmode.c:127: setPalette(&asteroidGraphic, createPalette(0, RGB8(223, 223, 223), RGB8(128, 128, 128), RGB8(64, 64, 64)));
	ld	de, #0x2108
	push	de
	ld	de, #0x4210
	push	de
	ld	bc, #0x6f7b
	ld	de, #0x0000
	call	_createPalette
	ld	de, #_asteroidGraphic
	call	_setPalette
;..\modes\explorationmode.c:128: asteroid.isAlive = false;
	ld	hl, #(_asteroid + 4)
;..\modes\explorationmode.c:130: ctor(&explosionGraphic, explosion_tiles, 2, 2, 4);
	ld	de, #0x0004
	ld	(hl), d
	push	de
	ld	de, #0x0002
	push	de
	push	de
	ld	bc, #_explosion_tiles
	ld	de, #_explosionGraphic
	call	_ctor
;..\modes\explorationmode.c:131: setFrame(&explosionGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_explosionGraphic
	call	_setFrame
;..\modes\explorationmode.c:132: hide(&explosionGraphic);
	ld	de, #_explosionGraphic
	call	_hide
;..\modes\explorationmode.c:133: setPalette(&explosionGraphic, fire_pallet);
	ldhl	sp,	#0
	ld	a, (hl)
	ld	de, #_explosionGraphic
	call	_setPalette
;..\modes\explorationmode.c:134: explosion.isAlive = false;
	ld	hl, #(_explosion + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:135: }
	inc	sp
	ret
;..\modes\explorationmode.c:137: void ExplorationMode_update(struct ExplorationMode* this) {
;	---------------------------------
; Function ExplorationMode_update
; ---------------------------------
_ExplorationMode_update::
	add	sp, #-12
	ldhl	sp,	#10
	ld	a, e
	ld	(hl+), a
;..\modes\explorationmode.c:138: this->counter++;
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
;..\modes\explorationmode.c:139: if(this->counter > 10) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x0a
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00185$
	bit	7, d
	jr	NZ, 00186$
	cp	a, a
	jr	00186$
00185$:
	bit	7, d
	jr	Z, 00186$
	scf
00186$:
	jp	NC, 00115$
;..\modes\explorationmode.c:140: this->counter = 0;
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\modes\explorationmode.c:142: if(photon.isAlive){
	ld	a, (#(_photon + 4) + 0)
	ldhl	sp,#9
	ld	(hl), a
	or	a, a
	jr	Z, 00104$
;..\modes\explorationmode.c:143: photonGraphic.frame++;
	dec	hl
	ld	de, #(_photonGraphic + 14)
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_photonGraphic + 14)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:144: if(photonGraphic.frame > 1)photonGraphic.frame = 0;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x01
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00187$
	bit	7, d
	jr	NZ, 00188$
	cp	a, a
	jr	00188$
00187$:
	bit	7, d
	jr	Z, 00188$
	scf
00188$:
	jr	NC, 00102$
	ld	hl, #(_photonGraphic + 14)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00102$:
;..\modes\explorationmode.c:145: setFrame(&photonGraphic, photonGraphic.frame);
	ld	hl, #(_photonGraphic + 14)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_photonGraphic
	call	_setFrame
00104$:
;..\modes\explorationmode.c:147: if(asteroid.isAlive == true){
	ld	a, (#(_asteroid + 4) + 0)
	dec	a
	jr	NZ, 00108$
;..\modes\explorationmode.c:148: asteroidGraphic.frame++;
	ld	de, #(_asteroidGraphic + 14)
	ld	a, (de)
	ldhl	sp,	#8
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_asteroidGraphic + 14)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:149: if(asteroidGraphic.frame > 3) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x03
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00191$
	bit	7, d
	jr	NZ, 00192$
	cp	a, a
	jr	00192$
00191$:
	bit	7, d
	jr	Z, 00192$
	scf
00192$:
	jr	NC, 00106$
;..\modes\explorationmode.c:150: asteroidGraphic.frame = 0;
	ld	hl, #(_asteroidGraphic + 14)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00106$:
;..\modes\explorationmode.c:152: setFrame(&asteroidGraphic, asteroidGraphic.frame);
	ld	hl, #(_asteroidGraphic + 14)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_asteroidGraphic
	call	_setFrame
00108$:
;..\modes\explorationmode.c:154: if(explosion.isAlive == true) {
	ld	a, (#(_explosion + 4) + 0)
	dec	a
	jr	NZ, 00115$
;..\modes\explorationmode.c:155: explosionGraphic.frame++;
	ld	hl, #(_explosionGraphic + 14)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_explosionGraphic + 14)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;..\modes\explorationmode.c:156: if(explosionGraphic.frame > 3) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x03
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00195$
	bit	7, d
	jr	NZ, 00196$
	cp	a, a
	jr	00196$
00195$:
	bit	7, d
	jr	Z, 00196$
	scf
00196$:
	jr	NC, 00110$
;..\modes\explorationmode.c:157: explosion.isAlive = false;
	ld	hl, #(_explosion + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:158: hide(&explosionGraphic);
	ld	de, #_explosionGraphic
	call	_hide
;..\modes\explorationmode.c:159: setFrame(&explosionGraphic, 0);
	ld	bc, #0x0000
	ld	de, #_explosionGraphic
	call	_setFrame
	jr	00115$
00110$:
;..\modes\explorationmode.c:162: setFrame(&explosionGraphic, explosionGraphic.frame);
	ld	hl, #(_explosionGraphic + 14)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_explosionGraphic
	call	_setFrame
00115$:
;..\modes\explorationmode.c:168: if(photon.isAlive) {
	ld	a, (#(_photon + 4) + 0)
	or	a, a
	jr	Z, 00117$
;..\modes\explorationmode.c:169: photon.world.x += photon.vector.x;
	ld	hl, #_photon
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_photon + 5
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
;..\modes\explorationmode.c:170: photon.world.y += photon.vector.y;
	ld	hl, #(_photon + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_photon + 7
	ld	a,	(hl+)
	ld	h, (hl)
;	spillPairReg hl
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #(_photon + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00117$:
;..\modes\explorationmode.c:173: struct GameObject* ship = gameobjects(GO_SHIP);
	ld	de, #0x0000
	call	_gameobjects
	ld	e, c
	ld	d, b
;..\modes\explorationmode.c:174: manage_asteroid(ship);
	push	de
	call	_manage_asteroid
	pop	de
;..\modes\explorationmode.c:176: if(explosion.isAlive == true){
	ld	bc, #_explosion + 4
	ld	a, (bc)
	dec	a
	jr	NZ, 00120$
;..\modes\explorationmode.c:178: screen = to_screen(&ship->world, &explosion.world);
	ld	bc, #_explosion
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
;..\modes\explorationmode.c:179: move(&explosionGraphic, screen.x, screen.y);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl-), a
	push	bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_explosionGraphic
	call	_move
00120$:
;..\modes\explorationmode.c:182: }
	add	sp, #12
	ret
;..\modes\explorationmode.c:185: void ExplorationMode_processInput(struct ExplorationMode* this, byte joypad) {
;	---------------------------------
; Function ExplorationMode_processInput
; ---------------------------------
_ExplorationMode_processInput::
	add	sp, #-19
	ld	c, a
;..\modes\explorationmode.c:186: int x = 0; int y = 0;
	xor	a, a
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\modes\explorationmode.c:187: struct GameObject* ship = gameobjects(GO_SHIP);
	push	bc
	ld	de, #0x0000
	call	_gameobjects
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	de, #0x0001
	call	_gameobjects
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
;..\modes\explorationmode.c:192: if (joypad & J_RIGHT)
	bit	0, c
	jr	Z, 00102$
;..\modes\explorationmode.c:194: x++;
	ldhl	sp,	#15
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00102$:
;..\modes\explorationmode.c:198: if (joypad & J_LEFT)
	bit	1, c
	jr	Z, 00104$
;..\modes\explorationmode.c:200: x--;
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00104$:
;..\modes\explorationmode.c:204: if (joypad & J_DOWN)
	bit	3, c
	jr	Z, 00106$
;..\modes\explorationmode.c:206: y++;
	ldhl	sp,	#17
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00106$:
;..\modes\explorationmode.c:210: if (joypad & J_UP)
	bit	2, c
	jr	Z, 00108$
;..\modes\explorationmode.c:212: y--;
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00108$:
;..\modes\explorationmode.c:218: photon.world.y = ship->world.y + 4;
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
;..\modes\explorationmode.c:221: photon.vector.x = ship->vector.x * 2;
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
;..\modes\explorationmode.c:222: photon.vector.y = ship->vector.y * 2;
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
;..\modes\explorationmode.c:215: if(joypad & J_A) {
	bit	4, c
	jr	Z, 00112$
;..\modes\explorationmode.c:216: if(photon.isAlive == false){
	ld	a, (#(_photon + 4) + 0)
	or	a, a
	jr	NZ, 00112$
;..\modes\explorationmode.c:217: photon.world.x = ship->world.x + 8;
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
;..\modes\explorationmode.c:218: photon.world.y = ship->world.y + 4;
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
;..\modes\explorationmode.c:219: show(&photonGraphic);
	ld	de, #_photonGraphic
	call	_show
;..\modes\explorationmode.c:220: photon.isAlive = true;
	ld	hl, #(_photon + 4)
	ld	(hl), #0x01
;..\modes\explorationmode.c:221: photon.vector.x = ship->vector.x * 2;
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
;..\modes\explorationmode.c:222: photon.vector.y = ship->vector.y * 2;
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
00112$:
;..\modes\explorationmode.c:225: if(x == 0 & y < 0)setFrame(&shipGraphic, 0);
	ldhl	sp,	#15
	ld	a, (hl+)
	or	a, a
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00256$
	xor	a, a
00256$:
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	rlca
	and	a,#0x01
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#10
	and	a,(hl)
	jr	Z, 00114$
	ld	bc, #0x0000
	ld	de, #_shipGraphic
	call	_setFrame
00114$:
;..\modes\explorationmode.c:226: if(x > 0 & y == 0)setFrame(&shipGraphic, 1);
	ldhl	sp,	#15
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00257$
	bit	7, d
	jr	NZ, 00258$
	cp	a, a
	jr	00258$
00257$:
	bit	7, d
	jr	Z, 00258$
	scf
00258$:
	ld	a, #0x00
	rla
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl+)
	or	a, a
	or	a, (hl)
	ld	a, #0x01
	jr	Z, 00260$
	xor	a, a
00260$:
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	and	a, (hl)
	inc	hl
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00116$
	ld	bc, #0x0001
	ld	de, #_shipGraphic
	call	_setFrame
00116$:
;..\modes\explorationmode.c:227: if(x == 0 & y > 0)setFrame(&shipGraphic, 2);
	ldhl	sp,	#17
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00261$
	bit	7, d
	jr	NZ, 00262$
	cp	a, a
	jr	00262$
00261$:
	bit	7, d
	jr	Z, 00262$
	scf
00262$:
	ld	a, #0x00
	rla
	ldhl	sp,	#13
	ld	(hl+), a
	ld	a, (hl-)
	and	a,(hl)
	jr	Z, 00118$
	ld	bc, #0x0002
	ld	de, #_shipGraphic
	call	_setFrame
00118$:
;..\modes\explorationmode.c:228: if(x < 0 & y == 0)setFrame(&shipGraphic, 3);
	ldhl	sp,	#16
	ld	a, (hl-)
	dec	hl
	rlca
	and	a,#0x01
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	and	a,(hl)
	jr	Z, 00120$
	ld	bc, #0x0003
	ld	de, #_shipGraphic
	call	_setFrame
00120$:
;..\modes\explorationmode.c:229: if(x < 0 & y < 0)setFrame(&shipGraphic, 4);
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#10
	and	a,(hl)
	jr	Z, 00122$
	ld	bc, #0x0004
	ld	de, #_shipGraphic
	call	_setFrame
00122$:
;..\modes\explorationmode.c:230: if(x > 0 & y < 0)setFrame(&shipGraphic, 5);
	ldhl	sp,	#11
	ld	a, (hl-)
	and	a,(hl)
	jr	Z, 00124$
	ld	bc, #0x0005
	ld	de, #_shipGraphic
	call	_setFrame
00124$:
;..\modes\explorationmode.c:231: if(x > 0 & y > 0)setFrame(&shipGraphic, 6);
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	and	a,(hl)
	jr	Z, 00126$
	ld	bc, #0x0006
	ld	de, #_shipGraphic
	call	_setFrame
00126$:
;..\modes\explorationmode.c:232: if(x < 0 & y > 0)setFrame(&shipGraphic, 7);
	ldhl	sp,	#14
	ld	a, (hl-)
	and	a,(hl)
	jr	Z, 00128$
	ld	bc, #0x0007
	ld	de, #_shipGraphic
	call	_setFrame
00128$:
;..\modes\explorationmode.c:234: ship->world.x += x;
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#15
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
;..\modes\explorationmode.c:235: ship->world.y += y;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#17
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
;..\modes\explorationmode.c:236: if(x != 0 || y != 0) { //if we pushed something store it as the new vector.
	ldhl	sp,	#16
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00129$
	ldhl	sp,	#18
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00130$
00129$:
;..\modes\explorationmode.c:237: ship->vector.x = x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;..\modes\explorationmode.c:238: ship->vector.y = y;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00130$:
;..\modes\explorationmode.c:241: int screen_x = planet1->world.x - ship->world.x + mid_screen.width;
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
;..\modes\explorationmode.c:242: int screen_y = planet1->world.y - ship->world.y + mid_screen.height;
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
;..\modes\explorationmode.c:243: move(&saturnGraphic, screen_x, screen_y);
	push	hl
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_saturnGraphic
	call	_move
;..\modes\explorationmode.c:245: screen_x = photon.world.x - ship->world.x + mid_screen.width;
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
;..\modes\explorationmode.c:246: screen_y = photon.world.y - ship->world.y + mid_screen.height;
	ld	hl, #_photon + 2
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
	ld	e, l
	ld	d, h
;..\modes\explorationmode.c:247: if(!isOnScreen(&photonGraphic, screen_x, screen_y)) {
	push	de
	push	de
	ldhl	sp,	#17
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	de, #_photonGraphic
	call	_isOnScreen
	pop	de
	or	a, a
	jr	NZ, 00133$
;..\modes\explorationmode.c:248: photon.isAlive = false;
	ld	hl, #(_photon + 4)
	ld	(hl), #0x00
;..\modes\explorationmode.c:249: hide(&photonGraphic);
	ld	de, #_photonGraphic
	call	_hide
	jr	00134$
00133$:
;..\modes\explorationmode.c:250: } else 	move(&photonGraphic, screen_x, screen_y);
	push	de
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_photonGraphic
	call	_move
00134$:
;..\modes\explorationmode.c:251: scroll_bkg(x, y);
	ldhl	sp,	#17
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
;..\modes\explorationmode.c:251: scroll_bkg(x, y);
;..\modes\explorationmode.c:252: }
	add	sp, #19
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__mid_screen:
	.dw #0x0054
	.dw #0x0054
	.area _CABS (ABS)
