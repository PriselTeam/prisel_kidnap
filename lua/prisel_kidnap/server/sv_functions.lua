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

    if not IsValid(eParent) then return end

    self:SetParent(eParent)
    self:SetPos(eParent:GetPos())
    self:SetAngles(eParent:GetAngles())
    self:SetNWInt("Prisel_KidnappedID", eParent:EntIndex())

end

function PLAYER:Release(eParent)
    self:SetRenderMode(RENDERMODE_NORMAL)
    self:DrawWorldModel(true)
    self:SetParent(nil)
    self:SetMoveType(MOVETYPE_WALK)
    self:Unstuck()
    self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
    self:Freeze(false)
    self:SetNWBool("Prisel_Kidnapped", false)

    timer.Simple(10, function()
        if IsValid(self) then
            net.Start("Prisel_KidnapSystem:UnKidnapPlayer")
            net.Send(self)
        end
    end)


    if not IsValid(eParent) then return end
    
    self:SetAngles(eParent:GetAngles())
    self:SetPos(eParent:GetPos() + eParent:GetForward() * 50)
    eParent:Reset()
    self:SetNWInt("Prisel_KidnappedID", 0)
end