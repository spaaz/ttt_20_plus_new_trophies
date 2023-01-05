local TROPHY = {}
TROPHY.id = "ilovestabbin"
TROPHY.title = "I love stabbin\'"
TROPHY.desc = "Kill someone with a knife"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and att:IsPlayer() then
			local wep = att:GetActiveWeapon()
			if wep and wep:IsValid() and (wep:GetClass() == "weapon_ttt_knife") then
				self:Earn(att)
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)