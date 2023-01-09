local TROPHY = {}
TROPHY.id = "whywontyoudie"
TROPHY.title = "Why won\'t you die!"
TROPHY.desc = "Lose 120 or more points of health in a single round"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_DETECTIVE
	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.damcount = 0
        end
	end)
	
	self:AddHook( "TTTEndRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.damcount = nil
        end
	end)
	
    self:AddHook("PostEntityTakeDamage", function(tgt,dinfo,took)
		if not took then return end

		if IsPlayer(tgt) and (tgt.damcount ~= nil) then
			local dam = dinfo:GetDamage()
			if dam and dam > 0 and self:IsAlive(tgt) then
				tgt.damcount = tgt.damcount + dam
			end
			if tgt.damcount >= 120 then
				self:Earn(tgt)
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)
