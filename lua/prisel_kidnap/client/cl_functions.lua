function Prisel.Kidnapping:ShowKidnappedPanel()
    local vFrame = vgui.Create("DFrame")
    vFrame:SetSize(DarkRP.ScrW, DarkRP.ScrH)
    vFrame:SetTitle("")
    -- vFrame:ShowCloseButton(false)
    vFrame:SetDraggable(false)
    vFrame:Center()
    vFrame:MakePopup()

    function vFrame:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, color_black)

        surface.SetDrawColor(color_white)
        surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_kidnap/prisonnier"))
        surface.DrawTexturedRect(w / 2 - 128, h / 2 - 256, 256, 256)

        draw.SimpleText("Vous avez été kidnappé !", DarkRP.Library.Font(12), w / 2, h / 2 + 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Vous ne pouvez plus rien faire, vous devrez attendre d'être relaché.", DarkRP.Library.Font(12), w / 2, h / 2 + 85, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    timer.Simple(5, function()
        local vButtonStaff = vgui.Create("Prisel.Button", vFrame)
        vButtonStaff:SetSize(vFrame:GetWide()*0.2, vFrame:GetTall()*0.05)
        vButtonStaff:SetPos(vFrame:GetWide()*0.4, vFrame:GetTall()*0.9)
        vButtonStaff:SetText("Appeler un membre du staff")
        vButtonStaff:SetBackgroundColor(Color(255, 0, 0))

    end)
end

local PLAYER = FindMetaTable("Player")

function PLAYER:IsKidnapped()
    return self:GetNWBool("Prisel_Kidnapped", false)
end

Prisel.Kidnapping:ShowKidnappedPanel()