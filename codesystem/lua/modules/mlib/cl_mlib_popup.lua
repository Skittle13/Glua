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


function MLIB:PopUP(header,color, colorhoverd, text, confirm_text, denie_text, func_accept, func_deny) 

            self = vgui.Create("DFrame")
            self:SetPos(ScrW() / 2.9, ScrH() / 3)
            self:SetSize(600,280)
            self:SetTitle("")
            self:SetDraggable()
            self:ShowCloseButton(false)
            self:MakePopup()
            self.Paint = function(self,w,h)
               
               draw.RoundedBox(7, 0, 6, w,h, Color(45,45,45))

               draw.RoundedBoxEx(6, 0, 0, w,50, color or Color(255,0,0), true, true,  false,false)

               draw.DrawText(header or "PopUP", "MLIB.PopUPHead", self:GetWide() / 2, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
            end


            self.button_accept = vgui.Create("MLIB.Button", self)
            self.button_accept:SetPos(5,self:GetTall() - 100)
            self.button_accept:SetSize(self:GetWide() - 10,45)
            self.button_accept:SetColor(Color(0,255,0))
            self.button_accept:SetColorHoverd(Color(0,225,0))
            self.button_accept:SetText(confirm_text)
            self.button_accept:SetFont("mlib.default")
            self.button_accept.DoClick = function()
               if ( func_accept ) then
                     func_accept()
               end
               self:Remove()
            end
            
            self.button_deny = vgui.Create("MLIB.Button", self)
            self.button_deny:SetPos(5,self:GetTall() - 50)
            self.button_deny:SetSize(self:GetWide() - 10,45)
            self.button_deny:SetColor(color)
            self.button_deny:SetColorHoverd(colorhoverd)
            self.button_deny:SetText(denie_text)
            self.button_deny:SetFont("mlib.default")
            self.button_deny.DoClick = function()
               if ( func_deny ) then
                     func_deny()
               end
               self:Remove()
            end

            self.text = vgui.Create("RichText", self)
            self.text:SetSize(self:GetWide() - 10,110)
            self.text:SetPos(5,60)
            self.text:AppendText(text)
            self.text:SetVerticalScrollbarEnabled(true)
            function self.text:PerformLayout()
                self:SetFontInternal("mlib.default")
            end


end