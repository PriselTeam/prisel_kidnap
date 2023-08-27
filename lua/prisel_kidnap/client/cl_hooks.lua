hook.Add("HUDPaint", "P_HUDPaint_KidnappedView", function()
    if not LocalPlayer():Alive() then return end

    if LocalPlayer():IsKidnapped() then

        PriselHUD.HideHUD = true
        
        surface.SetDrawColor(DarkRP.Library.ColorNuance(DarkRP.Config.Colors["Main"], -70))
        surface.DrawRect(0, 0, DarkRP.ScrW, DarkRP.ScrH)

        surface.SetDrawColor(color_white)
        surface.SetMaterial(DarkRP.Library.FetchCDN("prisel_kidnap/prisonnier"))
        surface.DrawTexturedRect(DarkRP.ScrW / 2 - 128, DarkRP.ScrH / 2 - 256, 256, 256)

        draw.SimpleText("Tu as été kidnappé.", DarkRP.Library.Font(10), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) 
        draw.SimpleText("Tu ne peux plus rien faire, tu devra attendre d'être relaché.", DarkRP.Library.Font(10), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 55, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
        PriselHUD.HideHUD = false
    end
end)