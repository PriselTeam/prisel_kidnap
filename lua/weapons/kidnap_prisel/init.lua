AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

Prisel.Kidnapping.PlayersCached = {}

function SWEP:Deploy()
    self:SetHoldType('melee2')
end

function SWEP:Reset()
    self:GetPerson():Release()
    self:SetProgressKidnap(0)
    self:SetIsKidnapping(false)
    self:SetPerson(nil)

    self:GetOwner():SetNWEntity("Prisel_HasKidnapped", nil)
    self:GetOwner():SetWalkSpeed(120)
    self:GetOwner():SetRunSpeed(180)

end

function SWEP:CapturePlayer(pPlayer)
    
    if not IsValid(pPlayer) then
        return
    end

    if not pPlayer:IsPlayer() then
        return
    end

    if pPlayer:GetNoDraw() then
        DarkRP.notify(self:GetOwner(), 1, 4, "Vous ne pouvez pas capturer cette personne.")
        return
    end

    self:SetProgressKidnap(0)

    self:SetIsKidnapping(true)

    timer.Create(self:EntIndex().."_P_Kidnapping", 0.05, 100, function()
        self:SetProgressKidnap(self:GetProgressKidnap() + 2)

        if self:GetProgressKidnap() >= 100 then
            self:SetProgressKidnap(0)
            self:SetIsKidnapping(false)
            timer.Remove(self:EntIndex().."_P_Kidnapping")

            if not IsValid(pPlayer) then
                return
            end

            local tTrace = self:GetOwner():GetEyeTrace()
            local pEnt = tTrace.Entity

            if not IsValid(pEnt) then
                return
            end

            local iDist = self:GetOwner():GetPos():Distance(pEnt:GetPos())

            if iDist > Prisel.Kidnapping.Config.MaxDistance then
                DarkRP.notify(self:GetOwner(), 1, 4, "Vous êtes trop loin de la personne.")
                return
            end

            if pEnt ~= pPlayer then
                return
            end
            
            self:SetPerson(pPlayer)

            pPlayer:GetCaptured(self)

            self:GetOwner():SetNWEntity("Prisel_HasKidnapped", pPlayer)

            self:GetOwner():SetWalkSpeed(80)
            self:GetOwner():SetRunSpeed(80)
        end
    end)

end

function SWEP:PrimaryAttack()

    if self.NextAttack and self.NextAttack > CurTime() then
        return
    end

    self.NextAttack = CurTime() + 5

    if self:GetIsKidnapping() then
        return
    end


    if IsValid(self:GetPerson()) then
        DarkRP.notify(self:GetOwner(), 1, 4, "Vous avez déjà une personne dans votre filet.")
        return
    end

    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

    if not IsValid(self:GetPerson()) then
        self:SetPerson(nil)
    end

    local tTrace = self:GetOwner():GetEyeTrace()
    local pEnt = tTrace.Entity

    if not IsValid(pEnt) then
        return
    end

    if not pEnt:IsPlayer() then
        return
    end

    if IsValid(Prisel.Kidnapping.PlayersCached[sId64]) then
        DarkRP.notify(self:GetOwner(), 1, 4, "Veuillez attendre avant de rekidnapper cette personne.")
        return
    end

    local iDist = self:GetOwner():GetPos():Distance(pEnt:GetPos())

    if iDist > Prisel.Kidnapping.Config.MaxDistance then
        DarkRP.notify(self:GetOwner(), 1, 4, "Vous êtes trop loin de la personne.")
        return
    end

    self:CapturePlayer(pEnt)

end

function SWEP:SecondaryAttack()

    if not IsValid(self:GetPerson()) then
        DarkRP.notify(self:GetOwner(), 1, 4, "Vous n'avez personne dans votre filet.")
        return
    end

    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

    local pPerson = self:GetPerson()

    if not IsValid(pPerson) then
        return
    end

    pPerson:Release(self)

    self:GetOwner():SetWalkSpeed(120)
    self:GetOwner():SetRunSpeed(180)


    self:SetPerson(nil)

end