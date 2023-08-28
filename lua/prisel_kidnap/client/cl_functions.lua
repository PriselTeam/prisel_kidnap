function Prisel.Kidnapping:ShowKidnappedPanel()

    local beginTime = CurTime()

    if IsValid(Prisel.Kidnapping.KidnapedFrame) then
        Prisel.Kidnapping.KidnapedFrame:Remove()
    end

    Prisel.Kidnapping.KidnapedFrame = vgui.Create("DFrame")
    Prisel.Kidnapping.KidnapedFrame:SetSize(DarkRP.ScrW, DarkRP.ScrH)
    Prisel.Kidnapping.KidnapedFrame:SetTitle("")
    Prisel.Kidnapping.KidnapedFrame:ShowCloseButton(false)
    Prisel.Kidnapping.KidnapedFrame:SetDraggable(false)
    Prisel.Kidnapping.KidnapedFrame:Center()
    Prisel.Kidnapping.KidnapedFrame:MakePopup()

    function Prisel.Kidnapping.KidnapedFrame:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, color_black)

        surface.SetDrawColor(color_white)
        surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_kidnap/prisonnier"))
        surface.DrawTexturedRect(w / 2 - 128, h / 2 - 256, 256, 256)

        draw.SimpleText("Vous avez été kidnappé !", DarkRP.Library.Font(12), w / 2, h / 2 + 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Vous ne pouvez plus rien faire, vous devrez attendre d'être relaché.", DarkRP.Library.Font(12), w / 2, h / 2 + 85, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        draw.SimpleText("Kidnappé depuis " .. DarkRP.Library.FormatSeconds(CurTime() - beginTime), DarkRP.Library.Font(12), w / 2, h / 2 + 120, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    
    end

    timer.Simple(180, function()

        if not IsValid(Prisel.Kidnapping.KidnapedFrame) then
            return
        end

        local vButtonStaff = vgui.Create("Prisel.Button", Prisel.Kidnapping.KidnapedFrame)
        vButtonStaff:SetSize(Prisel.Kidnapping.KidnapedFrame:GetWide()*0.2, Prisel.Kidnapping.KidnapedFrame:GetTall()*0.05)
        vButtonStaff:SetPos(Prisel.Kidnapping.KidnapedFrame:GetWide()*0.4, Prisel.Kidnapping.KidnapedFrame:GetTall()*0.9)
        vButtonStaff:SetText("Appeler un membre du staff")
        vButtonStaff:SetBackgroundColor(DarkRP.Config.Colors["Red"])

        local hasRequested = false

        function vButtonStaff:DoClick()
            if hasRequested then
                return
            end
            LocalPlayer():ConCommand("say \"/// [MESSAGE ENVOYÉ DEPUIS LE MENU] Je suis kidnappé depuis plus de 3 minutes.\"")
            vButtonStaff:SetText("Message envoyé !")
            vButtonStaff:SetBackgroundColor(DarkRP.Config.Colors["Green"])
            hasRequested = true
        end

    end)

end

function Prisel.Kidnapping:CloseKidnappedPanel()
    if IsValid(Prisel.Kidnapping.KidnapedFrame) then
        Prisel.Kidnapping.KidnapedFrame:Remove()
    end
end

local PLAYER = FindMetaTable("Player")

function PLAYER:IsKidnapped()
    return self:GetNWBool("Prisel_Kidnapped", false)
end