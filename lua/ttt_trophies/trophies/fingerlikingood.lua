local TROPHY = {}
TROPHY.id = "fingerlikingood"
TROPHY.title = "Finger lickin\' good"
TROPHY.desc = "Kill 3 chickens in a single round"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT
	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.chickcount = 0
        end
	end)
	
    self:AddHook("PostEntityTakeDamage", function(tgt,dinfo)
		if tgt:GetClass() == "ttt_chickent" then
			local wep = dinfo:GetInflictor()
			local att = dinfo:GetAttacker()
			if wep and wep:IsPlayer() then
				att = wep
			end
			if att and att:IsPlayer() then
				tgt.eply = att
				local health = tgt.CurHealth
				if health <= 0 then
				
					if att.chickcount < 2 then
						att.chickcount = att.chickcount + 1
					else
						self:Earn(att)
					end
				end
			elseif tgt.eply then
				att = tgt.eply
				local health = tgt.CurHealth
				if health <= 0 then
				
					if att.chickcount < 2 then
						att.chickcount = att.chickcount + 1
					else
						self:Earn(att)
					end
				end
			end
		end
    end)
end

function TROPHY:Condition()
    return scripted_ents.Get("ttt_chickent") ~= nil
end

RegisterTTTTrophy(TROPHY)