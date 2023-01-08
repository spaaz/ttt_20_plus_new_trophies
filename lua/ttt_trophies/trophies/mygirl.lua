local TROPHY = {}
TROPHY.id = "mygirl"
TROPHY.title = "My girl"
TROPHY.desc = "Get killed by a bee"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsValid(att) and att:GetClass() == "npc_manhack" then
			local tbl = att:GetChildren()
			for i,v in pairs(tbl) do
				if v:GetModel() == "models/lucian/props/stupid_bee.mdl" then
					self:Earn(tgt)
				end
			end	
		end
    end)
end

function TROPHY:Condition()
    return scripted_ents.Get("ttt_beenade_proj") ~= nil
end

RegisterTTTTrophy(TROPHY)