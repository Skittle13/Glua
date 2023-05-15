////////////////////////////////////////
//         Maax´s Libary (MLIB)       //
//          Coded by: Maax            //
//                                    //
//      Version: v1.0 (Workshop)      //
//                                    //
//      You are not permitted to      //
//        reupload this Script!       //
//                                    //
////////////////////////////////////////

function MLIB:CreateFont( name , size )
   
    surface.CreateFont( name, {
        font = "Roboto",
        size = size or "20",
    })
    
end



--[[

  Some old fonts I from MLIB v1.0

]]--

surface.CreateFont( "mlib.basicsmall", {
    font = "Arial",
    size = 16,
    weight = 800
} )
surface.CreateFont( "mlib.basicmedium", {
    font = "Arial",
    size = 32,
    weight = 800
} )

surface.CreateFont( "mlib.basicbig", {
    font = "Arial",
    size = 40,
    weight = 800
} )

surface.CreateFont( "mlib.basicbig_x", {
    font = "Arial",
    size = 64,
    weight = 800
} )

surface.CreateFont( "mlib.advancedsmall", {
    font = "Thahoma",
    size = 16,
    weight = 800
} )

surface.CreateFont( "mlib.advancedmedium", {
    font = "Thahoma",
    size = 32,
    weight = 800
} )

surface.CreateFont( "mlib.advancedbig", {
    font = "Thahoma",
    size = 64,
    weight = 800
} )

surface.CreateFont( "mlib.headmedium", {
    font = "Arial",
    size = 64,
    weight = 800
} )

surface.CreateFont( "mlib.headbig", {
    font = "Thahoma",
    size = 64,
    weight = 800
} )

surface.CreateFont( "mlib.toolhead", {
    font = "Arial",
    size = 32,
    weight = 800
} )

surface.CreateFont( "mlib.hud_text", {
    font = "Arial",
    size = 20,
    weight = 800
} )


surface.CreateFont( "mlib.tooltext", {
    font = "Thahoma",
    size = 16,
    weight = 800
} )

surface.CreateFont( "mlib.hudtext:small", {
    font = "Thahoma",
    size = 10,
    weight = 800
} )

surface.CreateFont( "mlib.hudtext:medium", {
    font = "Thahoma",
    size = 16,
    weight = 800
} )

surface.CreateFont( "mlib.hudtext:big", {
    font = "Thahoma",
    size = 16,
    weight = 800
} )

surface.CreateFont( "mlib.hudelement:small", {
    font = "Arial",
    size = 16,
    weight = 800
} )

surface.CreateFont( "mlib.hudelement:medium", {
    font = "Arial",
    size = 16,
    weight = 800
} )

surface.CreateFont( "mlib.hudelement:big", {
    font = "Arial",
    size = 34,
    weight = 800
} )

surface.CreateFont( "mlib.npc:msmall", {
    font = "Arial",
    size = 28,
    weight = 800
} )

surface.CreateFont("mlib.npc_small", {
    font = "Roboto",
    size = 32,
})
surface.CreateFont("mlib.npc_small01", {
    font = "Roboto",
    size = ScrH() * 0.025,
})

surface.CreateFont("mlib.npc_cardealer_small", {
    font = "Roboto",
    size = 32,
})

surface.CreateFont("mlib.npc_medium", {
    font = "Roboto",
    size = ScrH() * 0.016,
})

surface.CreateFont("mlib.npc_medium01", {
    font = "Roboto",
    size = ScrH() * 0.023,
})

surface.CreateFont("mlib.npc_big", {
    font = "Roboto",
    size = ScrH() * 0.019,
})

surface.CreateFont("mlib.npc_big", {
    font = "Roboto",
    size = 64,
})

surface.CreateFont("mlib.npc_big_x", {
    font = "Roboto",
    size = 32,
})

surface.CreateFont("mlib.notification", {
    font = "Roboto",
    size = 28,
})

surface.CreateFont("mlib.topbar", {
    font = "Roboto",
    size = 30,
})

surface.CreateFont("mlib.notification_small", {
    font = "Roboto",
    size = 20,
})

surface.CreateFont("mlib.default_x", {
    font = "Tahoma",
    size = 36,
})

surface.CreateFont("mlib.default_npc_head", {
    font = "Default",
    size = 80,
})

surface.CreateFont("mlib.default", {
    font = "Tahoma",
    size = 26,
})

surface.CreateFont("mlib.default_timer", {
    font = "Default",
    size = 28,
})

surface.CreateFont("mlib.default", {
    font = "Default",
    size = 26,
})


surface.CreateFont("mlib.default_xxl", {
    font = "Default",
    size = 36,
})


surface.CreateFont( "mlib.door_header", {
    font = "Default",
    size = 50,
})

surface.CreateFont("mlib.hud_default_text", {
    font = "Default",
    size = 26,
})

surface.CreateFont("mlib.textentry", {
    font = "Default",
    size = 20,
})

surface.CreateFont("mlib.promo_head", {
    font = "Default",
    size = 25,
})

surface.CreateFont("mlib.score_text", {
    font = "Default",
    size = 30,
})

surface.CreateFont("mlib.promo_btn", {
    font = "Default",
    size = 30,
})


surface.CreateFont("mlib.btn_text", {
    font = "Default",
    size = 20,
})

surface.CreateFont("DEFCON_HudHeader2", {
    font = "Default",
    size = 30,
})

surface.CreateFont("mlib.scoreboard_small", {
    font = "Default",
    size = 30,
})

surface.CreateFont("mlib.scoreboard_bar", {
    font = "Default",
    size = 30,
    weight = 550
})

surface.CreateFont("mlib.scoreboard", {
    font = "Default",
    size = 36,
})

surface.CreateFont("mlib.terminal", {
    font = "Default",
    size = 40,
})

surface.CreateFont("mlib.hud_prp", {
    font = "Default",
    size = 22,
})

surface.CreateFont("mlib.hud_notfiy_head", {
    font = "Default",
    size = 40,
})

surface.CreateFont("mlib.escape_header", {
    font = "Default",
    size = 90,
})

surface.CreateFont("mlib.escape_btn", {
    font = "Roboto",
    size = 32,
})

surface.CreateFont("mlib.close_btn", {
    font = "Tahoma",
    size = 70,
})

surface.CreateFont("mlib.close_small", {
    font = "Tahoma",
    size = 56,
})

surface.CreateFont("mlib.help_system", {
    font = "Tahoma",
    size = 36,
})

surface.CreateFont("mlib.ticket_small", {
    font = "Tahoma",
    size = 20,
})

surface.CreateFont("mlib.broadcastentry", {
    font = "Roboto",
    size = 30,
})

surface.CreateFont("MLIB.Button", {
    font = "Roboto",
    size = ScreenScale(11.4),
    width = 150
})

surface.CreateFont("MLIB.ListPanel", {
	font = "Roboto",
	size = ScreenScale(11.4),
	width = 150
})

surface.CreateFont("MLIB.Head", {
	font = "Roboto",
	size = ScreenScale(12.4),
	width = 150
})

surface.CreateFont("MLIB.CloseBtn", {
	font = "Roboto",
	size = ScreenScale(7.4),
	width = 40
})

surface.CreateFont("MLIB.PopUPHead", {
	font = "Roboto",
	size = ScreenScale(15.4),
	width = 150
})