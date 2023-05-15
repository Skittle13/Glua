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
	self.title:SetTextColor(Color(255,0,0))

	self.closeBtn = vgui.Create("DButton", self.topbar)
	self.closeBtn:Dock(RIGHT)
	self.closeBtn:DockMargin(10, 17, 0, 0)
	self.closeBtn:SetText("")
	self.closeBtn.CloseButton = Color(195, 195, 195)
	self.closeBtn.Alpha = 0
	self.closeBtn.DoClick = function(pnl)
		self:Remove()
	end
	self.closeBtn.Paint = function(pnl, w, h)

                draw.RoundedBox(5, 0, 0, 40, 40, Color(30,30,30))
              if self.closeBtn:IsHovered() then
                draw.RoundedBox(5, 0, 0, 40, 40, Color(18,18,18))
              end

        draw.DrawText("X", "MLIB.CloseBtn", 11, 0, Color(245,0,0), TEXT_ALIGN_LEFT)
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
	draw.RoundedBox(3, 0, 0, w, h, Color(20, 20, 20))
end

function FRAME:ShowCloseButton(show)
	self.closeBtn:SetVisible(show)
end

vgui.Register("MLIB.Frame", FRAME, "EditablePanel")


function MLIB:TestFrame()
     
	self = vgui.Create("MLIB.Frame")
	self:SetSize(ScrW()/ 2 , ScrH() / 2)
	self:Center()
	self:SetTitle("test")
	self:MakePopup()
	

	self.button = vgui.Create("MLIB.Button", self)
	self.button:SetSize(200,60)
	self.button:SetPos(40,100)
	self.button:SetText("test")

	self.textentry = vgui.Create("MLIB.TextEntry", self)
	self.textentry:SetSize(200,60)
	self.textentry:SetPos(40,180)
	self.textentry:SetText("test")
	

end

concommand.Add("test_frame", function()
   
   MLIB:TestFrame()

end)