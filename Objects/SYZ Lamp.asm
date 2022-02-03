; ---------------------------------------------------------------------------
; Object 12 - lamp (SYZ)
; ---------------------------------------------------------------------------

SpinningLight:
		moveq	#0,d0
		move.b	ost_routine(a0),d0
		move.w	Light_Index(pc,d0.w),d1
		jmp	Light_Index(pc,d1.w)
; ===========================================================================
Light_Index:	index *,,2
		ptr Light_Main
		ptr Light_Animate
; ===========================================================================

Light_Main:	; Routine 0
		addq.b	#2,ost_routine(a0)   ;go to Light_Animate
		move.l	#Map_Light,ost_mappings(a0)
		move.w	#0,ost_tile(a0)
		move.b	#render_rel,ost_render(a0)
		move.b	#$10,ost_actwidth(a0)
		move.b	#6,ost_priority(a0)

Light_Animate:	; Routine 2
		subq.b	#1,ost_anim_time(a0)    ; subtract timer by 1
		bpl.s	@chkdel             ; if varable isnt negitive branch  
		move.b	#7,ost_anim_time(a0) ; set timer animation timer
		addq.b	#1,ost_frame(a0)     ; incress frames
		cmpi.b	#id_frame_light_5+1,ost_frame(a0) ; has the lamp reached its final frame ?
		bcs.s	@chkdel         ; branch
		move.b	#id_frame_light_0,ost_frame(a0)     ; reset frames

	@chkdel:
		out_of_range	DeleteObject
		bra.w	DisplaySprite
