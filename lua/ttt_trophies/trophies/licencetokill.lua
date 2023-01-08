local TROPHY = {}
TROPHY.id = "licencetokill"
TROPHY.title = "Licence to kill"
TROPHY.desc = "Kill someone with a silenced pistol"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsPlayer(att) then
			local wep = att:GetActiveWeapon()
			if IsValid(wep) and (wep:GetClass() == "weapon_ttt_sipistol") then
				self:Earn(att)
			end
		end
    end)
end

function TROPHY:Condition()
	return TTTTrophies:IsBuyableItem(ROLE_TRAITOR, weapons.Get("weapon_ttt_sipistol"))
end

RegisterTTTTrophy(TROPHY)