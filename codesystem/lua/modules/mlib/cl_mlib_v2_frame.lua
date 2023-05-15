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


local FRAME = {}

function FRAME:Init()
	self.topbar = vgui.Create("Panel", self)
    self.topbar:Dock(TOP)
	self.topbar.Paint = function(pnl, w, h)
	end

	self.title = vgui.Create("DLabel", self.topbar)
	self.title:Dock(LEFT)
	self.title:DockMargin(15, 5, 0, 0)
	self.title:SetFont("MLIB.Head")
	self.title:SetTextColor(Color(255,255,255))

	self.closeBtn = vgui.Create("DButton", self.topbar)
	self.closeBtn:Dock(RIGHT)
	self.closeBtn:DockMargin(0, 0, 0, 0)
	self.closeBtn:SetText("")
	self.closeBtn.CloseButton = Color(195, 195, 195)
	self.closeBtn.Alpha = 0
	self.closeBtn.DoClick = function(pnl)
		self:Remove()
	end
	self.closeBtn.Paint = function(pnl, w, h)

               draw.DrawText("✖", "MLIB.CloseBtn", 25, 10, Color(255,255,255), TEXT_ALIGN_LEFT)
              if self.closeBtn:IsHovered() then
                draw.DrawText("✖", "MLIB.CloseBtn", 25, 10, Color(194, 194, 194), TEXT_ALIGN_LEFT)
              end
	end
end

function FRAME:SetTitle(str)
	self.title:SetText(str)
	self.title:SizeToContents()
end

function FRAME:PerformLayout(w, h)
	self.topbar:SetTall(60)

	if IsValid(self.branding) then
		self.branding:SetWide(self.topbar:GetTall())
	end

	self.closeBtn:SetWide(self.topbar:GetTall())
end

function FRAME:Paint(w, h)
		surface.SetDrawColor(Color(50,50,50,200))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(Color(255,255,255,50))
		surface.DrawOutlinedRect(0,0,w,h)

		surface.SetDrawColor(Color(255,255,255,120))
		WSG.DrawEdges(0,0,w,h,  8, 2)

end

function FRAME:ShowCloseButton(show)
	self.closeBtn:SetVisible(show)
end

vgui.Register("MLIB.FrameV2", FRAME, "EditablePanel")


function MLIB:TestFramev2()
     
	self = vgui.Create("MLIB.FrameV2")
	self:SetSize(ScrW()/ 3 , ScrH() / 3)
	self:Center()
	self:SetTitle("Code System")
	self:MakePopup()
	

	self.button = vgui.Create("MLIB.Button", self)
	self.button:SetSize(200,60)
	self.button:SetPos(40,100)
	self.button:SetText("Code System")

	self.textentry = vgui.Create("MLIB.TextEntry", self)
	self.textentry:SetSize(200,60)
	self.textentry:SetPos(40,180)
	self.textentry:SetText("test")
	

end

concommand.Add("test_framev2", function()
   
   MLIB:TestFramev2()

end)