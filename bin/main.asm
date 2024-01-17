;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init_game
	.globl _gameobjects
	.globl _ExplorationMode_processInput
	.globl _ExplorationMode_update
	.globl _ExplorationMode_init
	.globl _Hud_processInput
	.globl _Hud_drawScreen
	.globl _Hud_init
	.globl _initrand
	.globl _wait_vbl_done
	.globl _joypad
	.globl _joypadCurrent
	.globl _gameState
	.globl _explorationMode
	.globl _hud
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_hud::
	.ds 6
_explorationMode::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_gameState::
	.ds 2
_joypadCurrent::
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
;..\main.c:18: void init_game() {
;	---------------------------------
; Function init_game
; ---------------------------------
_init_game::
;..\main.c:19: initrand(DIV_REG);
	ldh	a, (_DIV_REG + 0)
	ld	b, #0x00
	ld	c, a
	push	bc
	call	_initrand
	pop	hl
;..\main.c:20: struct GameObject* ship = gameobjects(GO_SHIP);
	ld	de, #0x0000
	call	_gameobjects
;..\main.c:21: ship->world.x = 0;
	ld	l, c
	ld	h, b
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\main.c:22: ship->world.y = 0;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	xor	a, a
	ld	(de), a
	inc	de
	ld	(de), a
;..\main.c:23: ship->vector.x = 0;
	ld	hl, #0x0005
	add	hl, bc
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;..\main.c:24: ship->vector.y = 1;
	ld	hl, #0x0007
	add	hl, bc
	ld	a, #0x01
	ld	(hl+), a
;..\main.c:26: struct GameObject* planet1 = gameobjects(GO_PLANET1);
	ld	de, #0x0001
	ld	(hl), d
	call	_gameobjects
;..\main.c:27: planet1->world.x = -64;
	ld	l, c
	ld	h, b
	ld	a, #0xc0
	ld	(hl+), a
	ld	(hl), #0xff
;..\main.c:28: planet1->world.y = -64;
	inc	bc
	inc	bc
	ld	a, #0xc0
	ld	(bc), a
	inc	bc
	ld	a, #0xff
	ld	(bc), a
;..\main.c:30: }
	ret
;..\main.c:32: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;..\main.c:34: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;..\main.c:35: init_game();
	call	_init_game
;..\main.c:37: ExplorationMode_init(&explorationMode);
	ld	de, #_explorationMode
	call	_ExplorationMode_init
;..\main.c:38: int wait = 0;
	ld	bc, #0x0000
;..\main.c:40: while(1) {
00117$:
;..\main.c:41: if(wait > 0)wait++;
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00184$
	bit	7, d
	jr	NZ, 00185$
	cp	a, a
	jr	00185$
00184$:
	bit	7, d
	jr	Z, 00185$
	scf
00185$:
	jr	NC, 00102$
	inc	bc
00102$:
;..\main.c:42: if(wait > 50)wait = 0;
	ld	e, b
	ld	d, #0x00
	ld	a, #0x32
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00186$
	bit	7, d
	jr	NZ, 00187$
	cp	a, a
	jr	00187$
00186$:
	bit	7, d
	jr	Z, 00187$
	scf
00187$:
	jr	NC, 00104$
	ld	bc, #0x0000
00104$:
;..\main.c:43: joypadCurrent=joypad();
	call	_joypad
	ld	hl, #_joypadCurrent
	ld	(hl), a
;..\main.c:44: if (joypadCurrent & J_START && wait == 0)
	ld	a, (hl)
	rlca
	jr	NC, 00110$
	ld	a, b
	or	a, c
	jr	NZ, 00110$
;..\main.c:46: switch (gameState)
	ld	hl, #_gameState
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	Z, 00105$
	ld	hl, #_gameState
	ld	a, (hl+)
	sub	a, #0x03
	or	a, (hl)
	jr	Z, 00106$
	jr	00110$
;..\main.c:48: case EXPLORATION_MODE:
00105$:
;..\main.c:49: gameState = HUD_MODE;
	ld	hl, #_gameState
	ld	a, #0x03
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;..\main.c:50: Hud_init(&hud);
	ld	de, #_hud
	call	_Hud_init
;..\main.c:51: wait = 1;
	ld	bc, #0x0001
;..\main.c:52: break;
	jr	00110$
;..\main.c:53: case HUD_MODE:
00106$:
;..\main.c:54: gameState = EXPLORATION_MODE;
	ld	hl, #_gameState
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;..\main.c:55: ExplorationMode_init(&explorationMode);
	ld	de, #_explorationMode
	call	_ExplorationMode_init
;..\main.c:56: wait = 1;
	ld	bc, #0x0001
;..\main.c:60: }
00110$:
;..\main.c:63: switch (gameState)
	ld	hl, #_gameState
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	Z, 00112$
	ld	hl, #_gameState
	ld	a, (hl+)
	sub	a, #0x03
	or	a, (hl)
	jr	Z, 00113$
	jr	00115$
;..\main.c:65: case EXPLORATION_MODE:
00112$:
;..\main.c:66: ExplorationMode_update(&explorationMode);
	push	bc
	ld	de, #_explorationMode
	call	_ExplorationMode_update
	ld	a, (#_joypadCurrent)
	ld	de, #_explorationMode
	call	_ExplorationMode_processInput
	pop	bc
;..\main.c:68: break;
	jr	00115$
;..\main.c:69: case HUD_MODE:
00113$:
;..\main.c:70: Hud_processInput(&hud, joypadCurrent);
	push	bc
	ld	a, (#_joypadCurrent)
	ld	de, #_hud
	call	_Hud_processInput
	ld	de, #_hud
	call	_Hud_drawScreen
	pop	bc
;..\main.c:75: }
00115$:
;..\main.c:87: wait_vbl_done();
	call	_wait_vbl_done
;..\main.c:89: }
	jp	00117$
	.area _CODE
	.area _INITIALIZER
__xinit__gameState:
	.dw #0x0001
__xinit__joypadCurrent:
	.db #0x00	; 0
	.area _CABS (ABS)
