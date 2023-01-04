local TROPHY = {}
TROPHY.id = "wellthatwasstupid"
TROPHY.title = "Well that was stupid"
TROPHY.desc = "Kill yourself with an explosive barrel"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and (att == tgt) then
			local prop = dmginf:GetInflictor()
			if prop then
				local mod = prop:GetModel()
				if mod and mod == "models/props_c17/oildrum001_explosive.mdl" then
					self:Earn(att)
				end
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)