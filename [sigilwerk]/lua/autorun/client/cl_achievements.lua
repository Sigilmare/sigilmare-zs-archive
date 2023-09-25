function MakepAchievements()
    local s = BetterScreenScale()
    local lp = LocalPlayer()

    PlayMenuOpenSound()

    local frame = vgui.Create("DFrame")
    frame:SetSize(800 * s, 800 * s)
    frame:SetTitle("Achievements")
    frame:SetDraggable(false)
    frame:Center()
    frame:MakePopup()
    frame.OnClose = function()
        PlayMenuCloseSound()
    end

    local sheet = vgui.Create("DPropertySheet", frame)
    sheet:Dock(FILL)

    for catid, catname in ipairs(ACH.ItemCategories) do
        local maintab = vgui.Create("DPanel", sheet)
        sheet:AddSheet(catname.Name, maintab, catname.Icon)
        maintab.Paint = function() end

        local mainsheet = vgui.Create("DPropertySheet", maintab)
        mainsheet:Dock(FILL)

        for subcatid, subcatname in ipairs(ACH.ItemSubCategories[catid]) do
            if ACH.ItemSubCategories[catid][subcatid] then
                local tab = vgui.Create("DScrollPanel", mainsheet)
                mainsheet:AddSheet(subcatname.Name, tab, subcatname.Icon)

                local sbar = tab:GetVBar()
                sbar:SetHideButtons(true)
                sbar.Paint = function(self, w, h)
                    surface.SetDrawColor(0, 0, 0, 180)
                    surface.DrawRect(0, 0, w, h)
            
                    surface.SetDrawColor(color_black)
                    surface.DrawOutlinedRect(0, 0, w, h)
                end
                sbar.btnGrip.Paint = function(self, w, h)
                    surface.SetDrawColor(Color(0, 100, 0))
                    surface.DrawRect(0, 0, w, h)
            
                    surface.SetDrawColor(color_black)
                    surface.DrawOutlinedRect(0, 0, w, h)
                end

                for id, item in ipairs(ACH.Achievements) do
                    if item.Category == catid and item.SubCategory == subcatid then
                        local panel = tab:Add("DPanel")
                        panel:SetSize(frame:GetWide() - 73 * s, 72 * s)
                        panel:Dock(TOP)
                        panel:DockMargin(0, 0, 16 * s, 16 * s)
                        panel.Paint = function(panel, w, h)
                            surface.SetDrawColor(55, 55, 55)
                            surface.DrawRect(0, 0, w, h)
                        end

                        local title = panel:Add("DLabel")
                        title:SetText(item.Name)
                        title:SetTextColor(SIGILCOLOR_YELLOW)
                        title:SetFont("ZSHUDFontSmaller")
                        title:SizeToContents()
                        title:SetPos(4 * s, 4 * s)

                        local desc = panel:Add("DLabel")
                        desc:SetText(item.Description)
                        desc:SetFont("ZSHUDFontSmallest")
                        desc:SizeToContents()
                        desc:AlignBottom()
                        desc:SetX(4 * s)

                        local desc2 = panel:Add("DLabel")
                        desc2:SetText((MySelf:GetNWInt(item.NWInt) >= item.Goal and "COMPLETED" or math.floor(MySelf:GetNWInt(item.NWInt)).." / "..item.Goal))
                        desc2:SetFont("ZSHUDFontSmaller")
                        desc2:SetTextColor(Color(0, 150, 0))
                        desc2:SizeToContents()
                        desc2:AlignRight(4 * s)
                        desc2:AlignBottom()

                        local exp = panel:Add("DLabel")
                        exp:SetText((item.XP or "?").." XP")
                        exp:SetFont("ZSHUDFontSmallest")
                        exp:SetTextColor(SIGILCOLOR_ZSXP)
                        exp:SizeToContents()
                        exp:AlignRight(6 * s)
                        exp:AlignTop(4 * s)

                        local aether = panel:Add("DLabel")
                        aether:SetText((item.Aether or "?").." Aether")
                        aether:SetFont("ZSHUDFontSmallest")
                        aether:SetTextColor(SIGILCOLOR_AETHER)
                        aether:SizeToContents()
                        aether:MoveLeftOf(exp, 12 * s)
                        aether:AlignTop(4 * s)

                        local wid = panel:GetWide() - 8 * s

                        local base = panel:Add("DPanel")
                        base:SetWide(wid)
                        base:SetTall(10 * s)
                        base:SetX(4 * s)
                        base:CenterVertical(0.53)
                        base.Paint = function(panel, w, h)
                            surface.SetDrawColor(20, 20, 20)
                            surface.DrawRect(0, 0, w, h)
                        end
                    
                        local progress = math.Clamp(MySelf:GetNWInt(item.NWInt) / item.Goal, 0, 1)

                        local panel = base:Add("DPanel")
                        panel:SetWide(base:GetWide() * progress)
                        panel:SetTall(base:GetTall())
                        panel.Paint = function(panel, w, h)
                            surface.SetDrawColor(Color(0, 150, 0))
                            surface.DrawRect(0, 0, w, h)
                        end
                    end
                end
            end
        end
    end
end