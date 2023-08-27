include("shared.lua")

local iProgress = 0

function SWEP:PrimaryAttack()

    if self.NextAttack and self.NextAttack > CurTime() then
        return
    end

    self.NextAttack = CurTime() + 5

    if IsValid(self:GetPerson()) then
        return
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

    iProgress = 0

end

function SWEP:DrawHUD()
    surface.DrawCircle(DarkRP.ScrW / 2, DarkRP.ScrH / 2, 10, DarkRP.Config.Colors["Blue"])

    if self:GetIsKidnapping() then

        iProgress = Lerp(FrameTime()*7, iProgress, self:GetProgressKidnap())
        draw.RoundedBox(0, DarkRP.ScrW / 2 - DarkRP.ScrW*0.05, DarkRP.ScrH / 2 + 50, DarkRP.ScrW*0.1, 20, DarkRP.Config.Colors["Main"])
        draw.RoundedBox(0, DarkRP.ScrW / 2 - DarkRP.ScrW*0.05, DarkRP.ScrH / 2 + 50, DarkRP.ScrW*0.1 * iProgress/100, 20, DarkRP.Config.Colors["Blue"])
    
        draw.SimpleTextOutlined("Kidnapping...", DarkRP.Library.Font(7), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 57.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    
    end

    if IsValid(self:GetPerson()) then
        draw.SimpleTextOutlined("Vous avez quelqu'un dans votre filet !", DarkRP.Library.Font(10), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    end
end

function SWEP:SecondaryAttack()

    if not IsValid(self:GetPerson()) then
        return
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

end