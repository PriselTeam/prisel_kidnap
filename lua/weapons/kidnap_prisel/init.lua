AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Deploy()
    print("Deploying")
    self:SetHoldType('melee2')
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsCapturing")
    self:NetworkVar("Entity", 0, "Person")

    self:SetIsCapturing(false)
end

function SWEP:CapturePlayer(pPlayer)

    self:SetIsCapturing(true)

    timer.Simple(0.5, function()
        self:SetIsCapturing(false)
    end)

end

function SWEP:PrimaryAttack()

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

    if IsValid(self:GetPerson()) then
        DarkRP.notify(self.Owner, 1, 4, "Vous avez déjà une personne dans votre filet.")
        return
    end

    if not IsValid(self:GetPerson()) then
        self:SetPerson(nil)
    end

    local tTrace = self.Owner:GetEyeTrace()
    local pEnt = tTrace.Entity

    if not IsValid(pEnt) then
        return
    end

    local iDist = self.Owner:GetPos():Distance(pEnt:GetPos())

    if iDist > Prisel.Kidnapping.Config.MaxDistance then
        DarkRP.notify(self.Owner, 1, 4, "Vous êtes trop loin de la personne.")
        return
    end

    self:CapturePlayer(pEnt)


    
end