local PLAYER = FindMetaTable("Player")

function PLAYER:GetCaptured(eParent)

    self:SetRenderMode(RENDERMODE_NONE)
    self:DrawWorldModel(false)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
    self:Freeze(true)
    self:SetNWBool("Prisel_Kidnapped", true)

    net.Start("Prisel_KidnapSystem:KidnapPlayer")
    net.Send(self)

    Prisel.Kidnapping.PlayersCached[self:SteamID64()] = self

    if not IsValid(eParent) then return end

    self:SetParent(eParent)
    self:SetPos(eParent:GetPos())
    self:SetAngles(eParent:GetAngles())
    self:SetNWInt("Prisel_KidnappedID", eParent:EntIndex())

end

function PLAYER:Release(eParent, bDelay)
    self:SetRenderMode(RENDERMODE_NORMAL)
    self:DrawWorldModel(true)
    self:SetParent(nil)
    self:SetMoveType(MOVETYPE_WALK)
    self:Unstuck()
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
    self:Freeze(false)
    self:SetNWBool("Prisel_Kidnapped", false)

    local sId64 = self:SteamID64()

    timer.Simple(600, function()
        Prisel.Kidnapping.PlayersCached[sId64] = nil
    end)

    if bDelay then

        timer.Simple(5, function()
            if IsValid(self) then
                net.Start("Prisel_KidnapSystem:UnKidnapPlayer")
                net.Send(self)

                self:Respawn()
            end
        end)

    else
        net.Start("Prisel_KidnapSystem:UnKidnapPlayer")
        net.Send(self)
    end


    if not IsValid(eParent) then return end
    
    self:SetAngles(eParent:GetAngles())
    self:SetPos(eParent:GetPos() + eParent:GetForward() * 50)
    eParent:Reset()
    self:SetNWInt("Prisel_KidnappedID", 0)
end