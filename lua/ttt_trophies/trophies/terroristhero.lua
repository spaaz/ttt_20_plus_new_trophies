local TROPHY = {}
TROPHY.id = "terroristhero"
TROPHY.title = "Terrorist hero"
TROPHY.desc = "On the innocent team, kill 2 traitors in a single round (earned at end)"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT
	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.terrhero = 0
        end
	end)

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att:IsPlayer() and ((!CR_VERSION and !att:IsActiveTraitor()) or (CR_VERSION and (att:IsInnocentTeam()))) and (tgt:IsActiveTraitor() or (CR_VERSION and tgt:IsTraitorTeam())) then	
			att.terrhero =att.terrhero + 1
		end
    end)
	self:AddHook( "TTTEndRound", function()
		for _, ply in ipairs(player.GetAll()) do
			if ply.terrhero >= 2 then
				self:Earn(ply)
			end
        end
	end)
end

RegisterTTTTrophy(TROPHY)