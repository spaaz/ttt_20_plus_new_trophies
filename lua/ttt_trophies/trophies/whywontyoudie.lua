local TROPHY = {}
TROPHY.id = "whywontyoudie"
TROPHY.title = "Why won\'t you die!"
TROPHY.desc = "Receive 120 or more points of damage in a single round before dying"
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
	
    self:AddHook("PostEntityTakeDamage", function(tgt,dinfo)
		if tgt:IsPlayer() and (tgt.damcount ~= nil) then
			local dam = dinfo:GetDamage()
			if (dam > 0) and (dam < tgt:Health()) then
				tgt.damcount = tgt.damcount + dam
			end
			if tgt.damcount >= 120 then
				self:Earn(tgt)
			end
		end
    end)
end

RegisterTTTTrophy(TROPHY)