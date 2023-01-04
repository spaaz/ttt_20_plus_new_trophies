local TROPHY = {}
TROPHY.id = "leathalinjection"
TROPHY.title = "Leathal injection"
TROPHY.desc = "on the traitor team, kill an enemy with a parasite cure"
TROPHY.rarity = 3

function TROPHY:Trigger()
	self.roleMessage = ROLE_IMPERSONATOR
	
	self:AddHook( "TTTBeginRound", function()
		self:AddHook("OnEntityCreated", function(ent)
			if ent and IsValid(ent) then
				if (ent:GetClass() == "weapon_par_cure") then
					timer.Simple(1, function()			
						if ent and ent:GetOwner() then
							ent.originator = ent:GetOwner()
						end
					end)
				end
			end
		end)
	end)
	
	self:AddHook( "TTTEndRound", function()
		self:RemoveHook("OnEntityCreated")
	end)
	
	-- If given to victim and used:
    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and att:IsPlayer() and (att:GetActiveWeapon():GetClass() == "weapon_par_cure") then
			if (!CR_VERSION and !tgt:IsActiveTraitor()) or (CR_VERSION and (tgt:IsInnocentTeam() or tgt:IsMonsterTeam() or tgt:IsIndependentTeam() or ((tgt:GetRole() == ROLE_CLOWN) and tgt:GetNWBool("KillerClownActive", false)))) then	
					if tgt == att then
					local wep = att:GetActiveWeapon()
					if wep.originator and wep.originator:IsActiveTraitor() or (CR_VERSION and wep.originator:IsTraitorTeam()) then
						self:Earn(wep.originator)
					end
				end
			end
		elseif tgt.lethalinjection then
			print("dead leathal")
			if tgt == att then
				self:Earn(tgt.lethalinjection)
			end
		end
    end)

	-- If used on someone else:
	self:AddHook("KeyPress", function( ply, key )
		local wep = ply:GetActiveWeapon()
		if wep and IsValid(wep) then
			local wepclass = wep:GetClass()
			if (key == IN_ATTACK) and (wepclass == "weapon_par_cure") and (ply:IsActiveTraitor() or (CR_VERSION and ply:IsTraitorTeam())) then
				local tr  = ply:GetEyeTrace( MASK_SHOT_HULL )
				local ent = tr.Entity
				if ent and ent:IsPlayer() then
					if (!CR_VERSION and !ent:IsActiveTraitor()) or (CR_VERSION and (ent:IsInnocentTeam() or ent:IsMonsterTeam() or ent:IsIndependentTeam() or ((ent:GetRole() == ROLE_CLOWN) and ent:GetNWBool("KillerClownActive", false)))) then
						local delay = GetConVar("ttt_parasite_cure_time"):GetInt()
						timer.Remove("leathalinjectionstart"..ent:SteamID())
						timer.Remove("leathalinjectionstop"..ent:SteamID())
						print("start")
						timer.Create("leathalinjectionstart"..ent:SteamID(),delay - 0.5,1, function()			
							if ent and ent:Alive() then
								print("leathal")
								ent.lethalinjection = ply
							end
						end)
						timer.Create("leathalinjectionstop"..ent:SteamID(),delay + 0.5,1, function()			
							if ent and ent:Alive() then
								ent.lethalinjection = false
							end
						end)
					end	
				end
			end
		end
    end)
	
end

function TROPHY:Condition()
	return ConVarExists("ttt_parasite_enabled") and ConVarExists("ttt_impersonator_enabled") and GetConVar("ttt_parasite_enabled"):GetBool() and GetConVar("ttt_impersonator_enabled"):GetBool()
end

RegisterTTTTrophy(TROPHY)