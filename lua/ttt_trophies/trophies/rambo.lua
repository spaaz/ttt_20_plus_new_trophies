local TROPHY = {}
TROPHY.id = "rambo"
TROPHY.title = "Rambo"
TROPHY.desc = "On the traitor team, kill an enemy with a HUGE"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and att:IsPlayer() and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and ((!CR_VERSION and !tgt:IsActiveTraitor()) or (CR_VERSION and (tgt:IsInnocentTeam() or tgt:IsMonsterTeam() or tgt:IsIndependentTeam() or ((tgt:GetRole() == ROLE_CLOWN) and tgt:GetNWBool("KillerClownActive", false))))) then
			local wep = att:GetActiveWeapon()
			if wep and wep:IsValid() and (wep:GetClass() == "weapon_zm_sledge") then
				self:Earn(att)
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)