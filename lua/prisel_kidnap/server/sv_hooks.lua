hook.Add("PlayerDeath", "P_KidnapSystem_KidnapperDied", function(eVictim)
    if not IsValid(eVictim) then return end

    if IsValid(eVictim:GetNWEntity("Prisel_HasKidnapped")) then
        print("Kidnapper died, freeing hostage")
        eVictim:GetNWEntity("Prisel_HasKidnapped"):Release()
    end
end)

hook.Add("PlayerDisconnected", "P_KidnapSystem_KidnapperDisconnected", function(ePlayer)
    if not IsValid(ePlayer) then return end

    if IsValid(ePlayer:GetNWEntity("Prisel_HasKidnapped")) then
        print("Kidnapper disconnected, freeing hostage")
        ePlayer:GetNWEntity("Prisel_HasKidnapped"):Release()
    end
end)

hook.Add("PlayerSpawn", "P_KidnapSystem_KidnapperSpawned", function(ePlayer)
    if not IsValid(ePlayer) then return end

    if ePlayer:GetNWBool("Prisel_Kidnapped") then
        ePlayer:Release()
    end
end)