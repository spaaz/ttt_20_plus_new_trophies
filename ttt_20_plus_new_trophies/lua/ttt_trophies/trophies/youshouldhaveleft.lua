local TROPHY = {}
TROPHY.id = "youshouldhaveleft"
TROPHY.title = "You should have left me dead"
TROPHY.desc = "On the traitor team, revive the glitch (earned at end)"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

	
    self:AddHook("KeyPress", function( ply, key )
		if (key == IN_ATTACK) and ply:GetActiveWeapon():IsValid() and (ply:GetActiveWeapon():GetClass() == "weapon_vadim_defib") then
			local tr  = ply:GetEyeTrace( MASK_SHOT_HULL )
			local ent = tr.Entity
			if ent and IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
				for _, p in ipairs(player.GetAll()) do
					if p:GetRole() == ROLE_GLITCH and !p:Alive() then
						local delay = 5
						if GetConVar("ttt_defib_chargetime") then
							delay = 1 + GetConVar("ttt_defib_chargetime"):GetInt()
						end
						timer.Simple(delay, function()			
							if p and p:Alive() then
								ply.yshlmdtrophtearn = true
							end
						end)
					end	
				end
			end
		end
    end)
	self:AddHook( "TTTEndRound", function()
		for _, ply in ipairs(player.GetAll()) do
			if ply.yshlmdtrophtearn then
				self:Earn(ply)
			end
        end
	end)
end

function TROPHY:Condition()

	if ConVarExists("ttt_defib_traitor") then
		return GetConVar("ttt_defib_traitor"):GetBool() and GetConVar("ttt_glitch_enabled"):GetBool()
	end	
	return ConVarExists("ttt_glitch_enabled") and (weapons.Get("weapon_vadim_defib") ~= nil) and GetConVar("ttt_glitch_enabled"):GetBool()

end

RegisterTTTTrophy(TROPHY)