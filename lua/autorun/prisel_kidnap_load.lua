Prisel = Prisel or {}

Prisel.Kidnapping = Prisel.Kidnapping or {}

local function Include(f) return include("prisel_kidnap/"..f) end
local function AddLuaFile(f) return AddCSLuaFile("prisel_kidnap/"..f) end
local function IncludeAdd(f) return Include(f), AddLuaFile(f) end

IncludeAdd("config.lua")

if SERVER then

    Include("server/sv_functions.lua")
    Include("server/sv_hooks.lua")
    Include("server/sv_network.lua")

    AddLuaFile("client/cl_functions.lua")
    AddLuaFile("client/cl_network.lua")

else

    Include("client/cl_functions.lua")
    Include("client/cl_network.lua")

end
