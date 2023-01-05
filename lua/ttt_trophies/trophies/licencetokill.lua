local TROPHY = {}
TROPHY.id = "licencetokill"
TROPHY.title = "Licence to kill"
TROPHY.desc = "Kill someone with a silenced pistol"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and att:IsPlayer() then
			local wep = att:GetActiveWeapon()
			if wep and wep:IsValid() and (wep:GetClass() == "weapon_ttt_sipistol") then
				self:Earn(att)
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)