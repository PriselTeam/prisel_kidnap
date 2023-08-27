local PLAYER = FindMetaTable("Player")

function PLAYER:IsKidnapped()
    return self:GetNWBool("Prisel_Kidnapped", false)
end