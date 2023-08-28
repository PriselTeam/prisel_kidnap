include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
	self:SetBodygroup(1,1)
	self:SetSolid(SOLID_BBOX)

	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()

	self:SetNPCState(NPC_STATE_SCRIPT)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetMoveType(MOVETYPE_NONE)

	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
end

function ENT:Use(pCaller)
	if not IsValid(pCaller) or not pCaller:IsPlayer() then return end

	local eWeapon = pCaller:GetWeapon("kidnap_prisel")

	if not IsValid(eWeapon) then
		DarkRP.notify(pCaller, 1, 4, "Bonjour, on se connait ?")
		return
	else
		pCaller:SelectWeapon("kidnap_prisel")
		if pCaller:GetEyeTrace().Entity == self then
			if IsValid(eWeapon:GetPerson()) then
				local target = eWeapon:GetPerson()
				if target:GetPos():Distance(self:GetPos()) < 1000 then

					DarkRP.notify(pCaller, 1, 4, "Vous avez vendu "..target:Nick().." !")
					target:Release(nil, true)
					eWeapon:Reset()
					local iMoney = math.random(Prisel.Kidnapping.Config.Reward.min, Prisel.Kidnapping.Config.Reward.max)
					pCaller:addMoney(iMoney)

				end
			else

				DarkRP.notify(pCaller, 1, 4, "Vous n'avez personne à vendre.")
				
			end
		end
	end

end