local TROPHY = {}
TROPHY.id = "thetomstrategy"
TROPHY.title = "The Tom strategy"
TROPHY.desc = "On the traitor team, kill a teammate and resurrect them with a defib"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.traitorbuddyvict = nil
        end
	end)
	
    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and att:IsPlayer() and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and (tgt:IsActiveTraitor() or (CR_VERSION and tgt:IsTraitorTeam())) then
			if att.traitorbuddyvict == nil then
				att.traitorbuddyvict = {}
			end
			table.insert(att.traitorbuddyvict, tgt)
		end
    end)
	
    self:AddHook("KeyPress", function( ply, key )
		if ply.traitorbuddyvict and (key == IN_ATTACK) and ply:GetActiveWeapon():IsValid() and (ply:GetActiveWeapon():GetClass() == "weapon_vadim_defib") then
			local tr  = ply:GetEyeTrace( MASK_SHOT_HULL )
			local ent = tr.Entity
			for i = 1, #ply.traitorbuddyvict do
				local deadtraitor = ply.traitorbuddyvict[ i ]
				if ent and IsValid(ent) and ent:GetClass() == "prop_ragdoll" and !deadtraitor:Alive() then
					local delay = 4
					if GetConVar("ttt_defib_chargetime") then
						delay = 1 + GetConVar("ttt_defib_chargetime"):GetInt()
					end
					timer.Simple(delay, function()			
						if deadtraitor and deadtraitor:Alive() then
							self:Earn(ply)
						end
					end)
				end	
			end
		end
    end)	
end

function TROPHY:Condition()
	
	if ConVarExists("ttt_defib_traitor") then
		return GetConVar("ttt_defib_traitor"):GetBool()
	end
	return weapons.Get("weapon_vadim_defib") ~= nil

end

RegisterTTTTrophy(TROPHY)