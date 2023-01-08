local TROPHY = {}
TROPHY.id = "poonmaster"
TROPHY.title = "Poon master"
TROPHY.desc = "On the traitor team, kill 2 enemies with harpoons in a single round"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR
	self:AddHook( "TTTPrepareRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.poonkill = false
        end
	end)

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsValid(dmginf:GetInflictor()) and dmginf:GetInflictor():GetClass() == "hwapoon_arrow" then
			if IsPlayer(att) and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and ((not CR_VERSION and not tgt:IsActiveTraitor()) or (CR_VERSION and (tgt:IsInnocentTeam() or tgt:IsMonsterTeam() or tgt:IsIndependentTeam() or ((tgt:GetRole() == ROLE_CLOWN) and tgt:GetNWBool("KillerClownActive", false))))) then	
				if att.poonkill then
					self:Earn(att)
				else
					att.poonkill = true
				end
			end
		end
    end)
end

function TROPHY:Condition()
    return scripted_ents.Get("hwapoon_arrow") ~= nil
end

RegisterTTTTrophy(TROPHY)