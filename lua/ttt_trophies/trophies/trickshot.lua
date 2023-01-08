local TROPHY = {}
TROPHY.id = "trickshot"
TROPHY.title = "Trick shot"
TROPHY.desc = "Shoot a bee with a scout rifle"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self:AddHook("EntityTakeDamage", function(tgt, dinfo)
		if tgt:GetClass() == "npc_manhack" then
			local att = dinfo:GetAttacker()
			local wep = dinfo:GetInflictor()
			
			if IsPlayer(att) then
				wep = att:GetActiveWeapon()
			elseif IsPlayer(wep) then
				att = wep
				wep = wep:GetActiveWeapon()
			end
			if IsValid(wep) and IsPlayer(att) then
				if wep:GetClass() == "weapon_zm_rifle" then
					local tbl = tgt:GetChildren()
					for i,v in pairs(tbl) do
						if v:GetModel() == "models/lucian/props/stupid_bee.mdl" then
							self:Earn(att)
						end
					end		
				end
			end	
		end
    end)
end

function TROPHY:Condition()
    return scripted_ents.Get("ttt_beenade_proj") ~= nil
end

RegisterTTTTrophy(TROPHY)