include("shared.lua")

function SWEP:PrimaryAttack()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)
end

function SWEP:DrawHUD()
    surface.DrawCircle(DarkRP.ScrW / 2, DarkRP.ScrH / 2, 10, DarkRP.Config.Colors["Blue"])
end