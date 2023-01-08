local TROPHY = {}
TROPHY.id = "nocountryforoldmen"
TROPHY.title = "No country for old men"
TROPHY.desc = "On the traitor team, kill an old man"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsPlayer(att) and att:IsTraitorTeam() and (tgt:GetRole() == ROLE_OLDMAN) then
			self:Earn(att)
		end
    end)
end

function TROPHY:Condition()

	return ConVarExists("ttt_oldman_enabled") and GetConVar("ttt_oldman_enabled"):GetBool()

end

RegisterTTTTrophy(TROPHY)