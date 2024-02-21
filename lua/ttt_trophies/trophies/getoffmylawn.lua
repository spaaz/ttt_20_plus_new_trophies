local TROPHY = {}
TROPHY.id = "getoffmylawn"
TROPHY.title = "Get off my lawn"
TROPHY.desc = "Kill someone as the old man after adrenaline rush"
TROPHY.rarity = 3

function TROPHY:Trigger()
	self.roleMessage = ROLE_OLDMAN

	self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
		if IsPlayer(att) and (att:GetRole() == ROLE_OLDMAN) and att:GetNWBool("AdrenalineRush") then
			self:Earn(att)
		end
	end)
end

function TROPHY:Condition()
	return TTTTrophies:CanRoleSpawn(ROLE_OLDMAN) and (GetConVar("ttt_oldman_adrenaline_rush"):GetInt() > 0)
end

RegisterTTTTrophy(TROPHY)