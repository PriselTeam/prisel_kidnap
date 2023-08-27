AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Deploy()
    self:SetHoldType('melee2')
end

function SWEP:CapturePlayer(pPlayer)
    
    if not IsValid(pPlayer) then
        return
    end

    if pPlayer:GetNoDraw() then
        DarkRP.notify(self.Owner, 1, 4, "Vous ne pouvez pas capturer cette personne.")
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

            if pEnt ~= pPlayer then
                return
            end
            
            pPlayer:SetRenderMode(RENDERMODE_NONE)
            pPlayer:DrawWorldModel(false)
            self:SetPerson(pPlayer)

            pPlayer:SetParent(self)
            pPlayer:SetMoveType(MOVETYPE_NONE)
            pPlayer:SetPos(self:GetPos())
            pPlayer:SetAngles(self:GetAngles())
            pPlayer:SetNotSolid(true)
            pPlayer:SetNWBool("Prisel_Kidnapped", true)
            self.Owner:SetNWEntity("Prisel_HasKidnapped", pPlayer)

            self.Owner:SetWalkSpeed(80)
            self.Owner:SetRunSpeed(80)
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
        DarkRP.notify(self.Owner, 1, 4, "Vous avez déjà une personne dans votre filet.")
        return
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

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

function SWEP:SecondaryAttack()

    if not IsValid(self:GetPerson()) then
        DarkRP.notify(self.Owner, 1, 4, "Vous n'avez personne dans votre filet.")
        return
    end

    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_MISSCENTER)

    local pPerson = self:GetPerson()

    if not IsValid(pPerson) then
        return
    end

    pPerson:SetRenderMode(RENDERMODE_NORMAL)
    pPerson:DrawWorldModel(true)

    pPerson:SetParent(nil)
    pPerson:SetMoveType(MOVETYPE_WALK)
    pPerson:SetPos(self.Owner:GetPos() + self.Owner:GetForward() * 50)    
    pPerson:Unstuck()
    pPerson:SetAngles(self:GetAngles())
    pPerson:SetNotSolid(false)
    pPerson:SetNWBool("Prisel_Kidnapped", false)

    self.Owner:SetWalkSpeed(120)
    self.Owner:SetRunSpeed(180)


    self:SetPerson(nil)

end