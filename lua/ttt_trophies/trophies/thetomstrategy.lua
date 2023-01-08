local TROPHY = {}
TROPHY.id = "thetomstrategy"
TROPHY.title = "The Tom strategy"
TROPHY.desc = "On the traitor team, kill or be killed by a teammate, defib the one killed and win"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.traitorbuddyvict = nil
        end
	end)
	
    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsPlayer(att) and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and (tgt:IsActiveTraitor() or (CR_VERSION and tgt:IsTraitorTeam())) then
			if att.traitorbuddyvict == nil then
				att.traitorbuddyvict = {}
			end
			table.insert(att.traitorbuddyvict, tgt)
		end
    end)
	
    self:AddHook("KeyPress", function( ply, key )
		if ply.traitorbuddyvict and (key == IN_ATTACK) and IsValid(ply:GetActiveWeapon()) and (ply:GetActiveWeapon():GetClass() == "weapon_vadim_defib") then
			local tr  = ply:GetEyeTrace( MASK_SHOT_HULL )
			local ent = tr.Entity
			for i = 1, #ply.traitorbuddyvict do
				local deadtraitor = ply.traitorbuddyvict[ i ]
				if ent and IsValid(ent) and ent:GetClass() == "prop_ragdoll" and not deadtraitor:Alive() then
					local delay = 4
					if GetConVar("ttt_defib_chargetime") then
						delay = 1 + GetConVar("ttt_defib_chargetime"):GetInt()
					end
					timer.Simple(delay, function()			
						if deadtraitor and deadtraitor:Alive() then
							ply.gettomstrat = true
							deadtraitor.gettomstrat = true
						end
					end)
				end	
			end
		end
    end)
	
    self:AddHook("TTTEndRound", function(result)
    if result == WIN_TRAITOR then
        for _, ply in ipairs(player.GetAll()) do
            if TTTTrophies:IsTraitorTeam(ply) and ply.gettomstrat then
                self:Earn(ply)
            end
        end
    end
end)

end

function TROPHY:Condition()
	return weapons.Get("weapon_vadim_defib") ~= nil and TTTTrophies:IsBuyableItem(ROLE_TRAITOR, weapons.Get("weapon_vadim_defib"))
end

RegisterTTTTrophy(TROPHY)