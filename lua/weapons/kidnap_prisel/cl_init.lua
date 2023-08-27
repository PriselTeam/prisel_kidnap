include("shared.lua")

local iProgress = 0

function SWEP:PrimaryAttack()

    if IsValid(self:GetPerson()) then
        return
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

end

function SWEP:DrawHUD()
    surface.DrawCircle(DarkRP.ScrW / 2, DarkRP.ScrH / 2, 10, DarkRP.Config.Colors["Blue"])

    if IsValid(self:GetPerson()) then
        draw.SimpleTextOutlined("Vous avez quelqu'un dans votre filet !", DarkRP.Library.Font(10), DarkRP.ScrW / 2, DarkRP.ScrH / 2 + 50, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    end
end