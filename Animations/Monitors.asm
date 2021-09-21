; ---------------------------------------------------------------------------
; Animation script - monitors
; ---------------------------------------------------------------------------
Ani_Monitor:	index *
		ptr ani_monitor_static
		ptr ani_monitor_eggman
		ptr ani_monitor_sonic
		ptr ani_monitor_shoes
		ptr ani_monitor_shield
		ptr ani_monitor_invincible
		ptr ani_monitor_rings
		ptr ani_monitor_s
		ptr ani_monitor_goggles
		ptr ani_monitor_breaking
		
ani_monitor_static:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_static1, id_frame_monitor_static2, afEnd
			even
ani_monitor_eggman:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_eggman, id_frame_monitor_eggman, id_frame_monitor_static1, id_frame_monitor_eggman, id_frame_monitor_eggman, id_frame_monitor_static2, id_frame_monitor_eggman, id_frame_monitor_eggman, afEnd
			even
ani_monitor_sonic:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_sonic, id_frame_monitor_sonic, id_frame_monitor_static1, id_frame_monitor_sonic, id_frame_monitor_sonic, id_frame_monitor_static2, id_frame_monitor_sonic, id_frame_monitor_sonic, afEnd
			even
ani_monitor_shoes:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_shoes, id_frame_monitor_shoes, id_frame_monitor_static1, id_frame_monitor_shoes, id_frame_monitor_shoes, id_frame_monitor_static2, id_frame_monitor_shoes, id_frame_monitor_shoes, afEnd
			even
ani_monitor_shield:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_shield, id_frame_monitor_shield, id_frame_monitor_static1, id_frame_monitor_shield, id_frame_monitor_shield, id_frame_monitor_static2, id_frame_monitor_shield, id_frame_monitor_shield, afEnd
			even
ani_monitor_invincible:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_invincible, id_frame_monitor_invincible, id_frame_monitor_static1, id_frame_monitor_invincible, id_frame_monitor_invincible, id_frame_monitor_static2, id_frame_monitor_invincible, id_frame_monitor_invincible, afEnd
			even
ani_monitor_rings:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_rings, id_frame_monitor_rings, id_frame_monitor_static1, id_frame_monitor_rings, id_frame_monitor_rings, id_frame_monitor_static2, id_frame_monitor_rings, id_frame_monitor_rings, afEnd
			even
ani_monitor_s:		dc.b 1,	id_frame_monitor_static0, id_frame_monitor_s, id_frame_monitor_s, id_frame_monitor_static1, id_frame_monitor_s, id_frame_monitor_s, id_frame_monitor_static2, id_frame_monitor_s, id_frame_monitor_s, afEnd
			even
ani_monitor_goggles:	dc.b 1,	id_frame_monitor_static0, id_frame_monitor_goggles, id_frame_monitor_goggles, id_frame_monitor_static1, id_frame_monitor_goggles, id_frame_monitor_goggles, id_frame_monitor_static2, id_frame_monitor_goggles, id_frame_monitor_goggles, afEnd
			even
ani_monitor_breaking:	dc.b 2,	id_frame_monitor_static0, id_frame_monitor_static1, id_frame_monitor_static2, id_frame_monitor_broken, afBack, 1
			even
