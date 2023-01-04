local TROPHY = {}
TROPHY.id = "terroristslayer"
TROPHY.title = "Terrorist slayer"
TROPHY.desc = "On the traitor team, kill 3 enemies in a single round"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR
	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.terrslay = 0
        end
	end)

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att:IsPlayer() and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and ((!CR_VERSION and !tgt:IsActiveTraitor()) or (CR_VERSION and (tgt:IsInnocentTeam() or tgt:IsMonsterTeam() or tgt:IsIndependentTeam() or ((tgt:GetRole() == ROLE_CLOWN) and tgt:GetNWBool("KillerClownActive", false))))) then	
			if att.terrslay < 2 then
				att.terrslay = att.terrslay + 1
			else
				self:Earn(att)
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)