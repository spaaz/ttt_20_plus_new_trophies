local TROPHY = {}
TROPHY.id = "thecrowbarismightier"
TROPHY.title = "The crowbar is mightier than the gun"
TROPHY.desc = "On the innocent team, kill a traitor with a crowbar"
TROPHY.rarity = 3

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT
	self:AddHook( "TTTEndBegin", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.crowbismight = false
        end
	end)
    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsPlayer(att) and ((not CR_VERSION and not att:IsActiveTraitor()) or (CR_VERSION and (att:IsInnocentTeam()))) and (tgt:IsActiveTraitor() or (CR_VERSION and tgt:IsTraitorTeam())) then
			local wep = att:GetActiveWeapon()
			if IsValid(wep) and (wep:GetClass() == "weapon_zm_improvised") then
				att.crowbismight = true
			end
		end
    end)
	self:AddHook( "TTTEndRound", function()
		for _, ply in ipairs(player.GetAll()) do
			if ply.crowbismight then
				self:Earn(ply)
			end
        end
	end)
end

RegisterTTTTrophy(TROPHY)