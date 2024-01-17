;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module gameobject
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gameobjects
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_gameobjects_objects_65536_135:
	.ds 18
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;..\model\gameobject.c:5: struct GameObject* gameobjects(int index) {
;	---------------------------------
; Function gameobjects
; ---------------------------------
_gameobjects::
	ld	c, e
	ld	b, d
;..\model\gameobject.c:7: return &objects[index];
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_gameobjects_objects_65536_135
	add	hl, de
	ld	c, l
	ld	b, h
;..\model\gameobject.c:8: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
