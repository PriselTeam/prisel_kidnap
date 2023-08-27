SWEP.PrintName						= 'Filet de kidnapping'
SWEP.Author							= 'Ekali - Prisel.fr'
SWEP.Purpose						= 'Kidnappe des personnes et revends les !'
SWEP.ViewModel                      = 'models/prisel_kidnap_filet/prisel_kidnap_filet_v.mdl'
SWEP.WorldModel                     = 'models/prisel_kidnap_filet/prisel_kidnap_filet.mdl'
SWEP.Category                       = 'Prisel - Kidnapping'
SWEP.Spawnable						= true
SWEP.AdminSpawnable				    = true
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.UseHands 						= true

SWEP.DrawAmmo						= false
SWEP.Primary.ClipSize			    = -1
SWEP.Primary.DefaultClip	        = -1
SWEP.Primary.Automatic		        = false
SWEP.Primary.Ammo					= 'none'

SWEP.Secondary.ClipSize				= -1
SWEP.Secondary.DefaultClip		    = -1
SWEP.Secondary.Automatic			= false
SWEP.Secondary.Ammo					= 'none'
SWEP.ViewModelFOV = 100
SWEP.NextAttack = 0

function SWEP:SetupDataTables()
    self:NetworkVar("Entity", 0, "Person")
    self:NetworkVar("Bool", 0, "IsKidnapping")
    self:NetworkVar("Float", 0, "ProgressKidnap")

    if SERVER then
        self:SetProgressKidnap(0)
    end
end