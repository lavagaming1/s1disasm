; ---------------------------------------------------------------------------
; Object 17 - helix of spikes on a pole	(GHZ)
; ---------------------------------------------------------------------------

		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Hel_Index(pc,d0.w),d1
		jmp	Hel_Index(pc,d1.w)
; ===========================================================================
Hel_Index:	index *,,2
		ptr Hel_Main
		ptr Hel_Action
		ptr Hel_Action
		ptr Hel_Delete
		ptr Hel_Display

hel_frame:	equ $3E		; start frame (different for each spike)

;		$29-38 are used for child object addresses
; ===========================================================================

Hel_Main:	; Routine 0
		addq.b	#2,ost_routine(a0)
		move.l	#Map_Hel,ost_mappings(a0)
		move.w	#tile_Nem_SpikePole+tile_pal3,ost_tile(a0)
		move.b	#7,ost_status(a0)
		move.b	#render_rel,ost_render(a0)
		move.b	#3,ost_priority(a0)
		move.b	#8,ost_actwidth(a0)
		move.w	ost_y_pos(a0),d2
		move.w	ost_x_pos(a0),d3
		move.b	0(a0),d4
		lea	ost_subtype(a0),a2 ; move helix length to a2
		moveq	#0,d1
		move.b	(a2),d1		; move helix length to d1
		move.b	#0,(a2)+	; clear subtype
		move.w	d1,d0
		lsr.w	#1,d0
		lsl.w	#4,d0
		sub.w	d0,d3		; d3 is x-axis position of leftmost spike
		subq.b	#2,d1
		bcs.s	Hel_Action	; skip to action if length is only 1
		moveq	#0,d6

Hel_Build:
		bsr.w	FindFreeObj
		bne.s	Hel_Action
		addq.b	#1,ost_subtype(a0)
		move.w	a1,d5
		subi.w	#$D000,d5
		lsr.w	#6,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+	; copy child address to parent RAM
		move.b	#id_Hel_Display,ost_routine(a1)
		move.b	d4,0(a1)
		move.w	d2,ost_y_pos(a1)
		move.w	d3,ost_x_pos(a1)
		move.l	ost_mappings(a0),ost_mappings(a1)
		move.w	#tile_Nem_SpikePole+tile_pal3,ost_tile(a1)
		move.b	#render_rel,ost_render(a1)
		move.b	#3,ost_priority(a1)
		move.b	#8,ost_actwidth(a1)
		move.b	d6,hel_frame(a1)
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3
		cmp.w	ost_x_pos(a0),d3	; is this spike in the centre?
		bne.s	Hel_NotCentre	; if not, branch

		move.b	d6,hel_frame(a0) ; set parent spike frame
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3		; skip to next spike
		addq.b	#1,ost_subtype(a0)

	Hel_NotCentre:
		dbf	d1,Hel_Build ; repeat d1 times (helix length)

Hel_Action:	; Routine 2, 4
		bsr.w	Hel_RotateSpikes
		bsr.w	DisplaySprite
		bra.w	Hel_ChkDel

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Hel_RotateSpikes:
		move.b	(v_ani0_frame).w,d0
		move.b	#0,ost_col_type(a0) ; make object harmless
		add.b	hel_frame(a0),d0
		andi.b	#7,d0
		move.b	d0,ost_frame(a0)	; change current frame
		bne.s	locret_7DA6
		move.b	#$84,ost_col_type(a0) ; make object harmful

locret_7DA6:
		rts	
; End of function Hel_RotateSpikes

; ===========================================================================

Hel_ChkDel:
		out_of_range	Hel_DelAll
		rts	
; ===========================================================================

Hel_DelAll:
		moveq	#0,d2
		lea	ost_subtype(a0),a2 ; move helix length to a2
		move.b	(a2)+,d2	; move helix length to d2
		subq.b	#2,d2
		bcs.s	Hel_Delete

	Hel_DelLoop:
		moveq	#0,d0
		move.b	(a2)+,d0
		lsl.w	#6,d0
		addi.l	#v_objspace&$FFFFFF,d0
		movea.l	d0,a1		; get child address
		bsr.w	DeleteChild	; delete object
		dbf	d2,Hel_DelLoop ; repeat d2 times (helix length)

Hel_Delete:	; Routine 6
		bsr.w	DeleteObject
		rts	
; ===========================================================================

Hel_Display:	; Routine 8
		bsr.w	Hel_RotateSpikes
		bra.w	DisplaySprite
