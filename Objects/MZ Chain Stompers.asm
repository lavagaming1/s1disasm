; ---------------------------------------------------------------------------
; Object 31 - stomping metal blocks on chains (MZ)
; ---------------------------------------------------------------------------

		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	CStom_Index(pc,d0.w),d1
		jmp	CStom_Index(pc,d1.w)
; ===========================================================================
CStom_Index:	index *,,2
		ptr CStom_Main
		ptr loc_B798
		ptr loc_B7FE
		ptr CStom_Display2
		ptr loc_B7E2

CStom_switch:	equ $3A			; switch number for the current stomper

CStom_SwchNums:	dc.b 0,	0		; switch number, obj number
		dc.b 1,	0

CStom_Var:	dc.b 2,	0, 0		; routine number, y-position, frame number
		dc.b 4,	$1C, 1
		dc.b 8,	$CC, 3
		dc.b 6,	$F0, 2

word_B6A4:	dc.w $7000, $A000
		dc.w $5000, $7800
		dc.w $3800, $5800
		dc.w $B800
; ===========================================================================

CStom_Main:	; Routine 0
		moveq	#0,d0
		move.b	ost_subtype(a0),d0
		bpl.s	loc_B6CE
		andi.w	#$7F,d0
		add.w	d0,d0
		lea	CStom_SwchNums(pc,d0.w),a2
		move.b	(a2)+,CStom_switch(a0)
		move.b	(a2)+,d0
		move.b	d0,ost_subtype(a0)

loc_B6CE:
		andi.b	#$F,d0
		add.w	d0,d0
		move.w	word_B6A4(pc,d0.w),d2
		tst.w	d0
		bne.s	loc_B6E0
		move.w	d2,$32(a0)

loc_B6E0:
		lea	(CStom_Var).l,a2
		movea.l	a0,a1
		moveq	#3,d1
		bra.s	CStom_MakeStomper
; ===========================================================================

CStom_Loop:
		bsr.w	FindNextFreeObj
		bne.w	CStom_SetSize

CStom_MakeStomper:
		move.b	(a2)+,ost_routine(a1)
		move.b	#id_ChainStomp,0(a1)
		move.w	ost_x_pos(a0),ost_x_pos(a1)
		move.b	(a2)+,d0
		ext.w	d0
		add.w	ost_y_pos(a0),d0
		move.w	d0,ost_y_pos(a1)
		move.l	#Map_CStom,ost_mappings(a1)
		move.w	#tile_Nem_MzMetal,ost_tile(a1)
		move.b	#render_rel,ost_render(a1)
		move.w	ost_y_pos(a1),$30(a1)
		move.b	ost_subtype(a0),ost_subtype(a1)
		move.b	#$10,ost_actwidth(a1)
		move.w	d2,$34(a1)
		move.b	#4,ost_priority(a1)
		move.b	(a2)+,ost_frame(a1)
		cmpi.b	#1,ost_frame(a1)
		bne.s	loc_B76A
		subq.w	#1,d1
		move.b	ost_subtype(a0),d0
		andi.w	#$F0,d0
		cmpi.w	#$20,d0
		beq.s	CStom_MakeStomper
		move.b	#$38,ost_actwidth(a1)
		move.b	#$90,ost_col_type(a1)
		addq.w	#1,d1

loc_B76A:
		move.l	a0,$3C(a1)
		dbf	d1,CStom_Loop

		move.b	#3,ost_priority(a1)

CStom_SetSize:
		moveq	#0,d0
		move.b	ost_subtype(a0),d0
		lsr.w	#3,d0
		andi.b	#$E,d0
		lea	CStom_Var2(pc,d0.w),a2
		move.b	(a2)+,ost_actwidth(a0)
		move.b	(a2)+,ost_frame(a0)
		bra.s	loc_B798
; ===========================================================================
CStom_Var2:	dc.b $38, 0		; width, frame number
		dc.b $30, 9
		dc.b $10, $A
; ===========================================================================

loc_B798:	; Routine 2
		bsr.w	CStom_Types
		move.w	ost_y_pos(a0),(v_obj31ypos).w
		moveq	#0,d1
		move.b	ost_actwidth(a0),d1
		addi.w	#$B,d1
		move.w	#$C,d2
		move.w	#$D,d3
		move.w	ost_x_pos(a0),d4
		bsr.w	SolidObject
		btst	#3,ost_status(a0)
		beq.s	CStom_Display
		cmpi.b	#$10,$32(a0)
		bcc.s	CStom_Display
		movea.l	a0,a2
		lea	(v_player).w,a0
		jsr	(KillSonic).l
		movea.l	a2,a0

CStom_Display:
		bsr.w	DisplaySprite
		bra.w	CStom_ChkDel
; ===========================================================================

loc_B7E2:	; Routine 8
		move.b	#$80,ost_height(a0)
		bset	#4,ost_render(a0)
		movea.l	$3C(a0),a1
		move.b	$32(a1),d0
		lsr.b	#5,d0
		addq.b	#3,d0
		move.b	d0,ost_frame(a0)

loc_B7FE:	; Routine 4
		movea.l	$3C(a0),a1
		moveq	#0,d0
		move.b	$32(a1),d0
		add.w	$30(a0),d0
		move.w	d0,ost_y_pos(a0)

CStom_Display2:	; Routine 6
		bsr.w	DisplaySprite

CStom_ChkDel:
		out_of_range	DeleteObject
		rts	
; ===========================================================================

CStom_Types:
		move.b	ost_subtype(a0),d0
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	CStom_TypeIndex(pc,d0.w),d1
		jmp	CStom_TypeIndex(pc,d1.w)
; ===========================================================================
CStom_TypeIndex:index *
		ptr CStom_Type00
		ptr CStom_Type01
		ptr CStom_Type01
		ptr CStom_Type03
		ptr CStom_Type01
		ptr CStom_Type03
		ptr CStom_Type01
; ===========================================================================

CStom_Type00:
		lea	(f_switch).w,a2	; load switch statuses
		moveq	#0,d0
		move.b	CStom_switch(a0),d0 ; move number 0 or 1 to d0
		tst.b	(a2,d0.w)	; has switch (d0) been pressed?
		beq.s	loc_B8A8	; if not, branch
		tst.w	(v_obj31ypos).w
		bpl.s	loc_B872
		cmpi.b	#$10,$32(a0)
		beq.s	loc_B8A0

loc_B872:
		tst.w	$32(a0)
		beq.s	loc_B8A0
		move.b	(v_vbla_byte).w,d0
		andi.b	#$F,d0
		bne.s	loc_B892
		tst.b	1(a0)
		bpl.s	loc_B892
		sfx	sfx_ChainRise,0,0,0	; play rising chain sound

loc_B892:
		subi.w	#$80,$32(a0)
		bcc.s	CStom_Restart
		move.w	#0,$32(a0)

loc_B8A0:
		move.w	#0,ost_y_vel(a0)
		bra.s	CStom_Restart
; ===========================================================================

loc_B8A8:
		move.w	$34(a0),d1
		cmp.w	$32(a0),d1
		beq.s	CStom_Restart
		move.w	ost_y_vel(a0),d0
		addi.w	#$70,ost_y_vel(a0)	; make object fall
		add.w	d0,$32(a0)
		cmp.w	$32(a0),d1
		bhi.s	CStom_Restart
		move.w	d1,$32(a0)
		move.w	#0,ost_y_vel(a0)	; stop object falling
		tst.b	ost_render(a0)
		bpl.s	CStom_Restart
		sfx	sfx_ChainStomp,0,0,0	; play stomping sound

CStom_Restart:
		moveq	#0,d0
		move.b	$32(a0),d0
		add.w	$30(a0),d0
		move.w	d0,ost_y_pos(a0)
		rts	
; ===========================================================================

CStom_Type01:
		tst.w	$36(a0)
		beq.s	loc_B938
		tst.w	$38(a0)
		beq.s	loc_B902
		subq.w	#1,$38(a0)
		bra.s	loc_B97C
; ===========================================================================

loc_B902:
		move.b	(v_vbla_byte).w,d0
		andi.b	#$F,d0
		bne.s	loc_B91C
		tst.b	ost_render(a0)
		bpl.s	loc_B91C
		sfx	sfx_ChainRise,0,0,0	; play rising chain sound

loc_B91C:
		subi.w	#$80,$32(a0)
		bcc.s	loc_B97C
		move.w	#0,$32(a0)
		move.w	#0,ost_y_vel(a0)
		move.w	#0,$36(a0)
		bra.s	loc_B97C
; ===========================================================================

loc_B938:
		move.w	$34(a0),d1
		cmp.w	$32(a0),d1
		beq.s	loc_B97C
		move.w	ost_y_vel(a0),d0
		addi.w	#$70,ost_y_vel(a0)	; make object fall
		add.w	d0,$32(a0)
		cmp.w	$32(a0),d1
		bhi.s	loc_B97C
		move.w	d1,$32(a0)
		move.w	#0,ost_y_vel(a0)	; stop object falling
		move.w	#1,$36(a0)
		move.w	#$3C,$38(a0)
		tst.b	ost_render(a0)
		bpl.s	loc_B97C
		sfx	sfx_ChainStomp,0,0,0	; play stomping sound

loc_B97C:
		bra.w	CStom_Restart
; ===========================================================================

CStom_Type03:
		move.w	(v_player+ost_x_pos).w,d0
		sub.w	ost_x_pos(a0),d0
		bcc.s	loc_B98C
		neg.w	d0

loc_B98C:
		cmpi.w	#$90,d0
		bcc.s	loc_B996
		addq.b	#1,ost_subtype(a0)

loc_B996:
		bra.w	CStom_Restart
