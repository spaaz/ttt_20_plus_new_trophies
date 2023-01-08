local TROPHY = {}
TROPHY.id = "ilovestabbin"
TROPHY.title = "I love stabbin\'"
TROPHY.desc = "Kill someone with a knife"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsPlayer(att) then
			local wep = att:GetActiveWeapon()
			if IsValid(wep) and (wep:GetClass() == "weapon_ttt_knife") then
				self:Earn(att)
			end
		end
    end)
end

function TROPHY:Condition()
	return TTTTrophies:IsBuyableItem(ROLE_TRAITOR, weapons.Get("weapon_ttt_knife"))
end

RegisterTTTTrophy(TROPHY)