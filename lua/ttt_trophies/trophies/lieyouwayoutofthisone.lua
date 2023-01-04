local TROPHY = {}
TROPHY.id = "lieyourwayoutofthisone"
TROPHY.title = "Lie your way out of this one"
TROPHY.desc = "On the traitor team, kill someone then check their body within 5 seconds"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

	self:AddHook( "TTTBeginRound", function()
		for _, ply in ipairs(player.GetAll()) do
			ply.lywootovict = nil
        end
	end)
	
    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if att and att:IsPlayer() and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) then
			if att.lywootovict == nil then
				att.lywootovict = {}
			end
			table.insert(att.lywootovict, tgt)
			local index = #att.lywootovict
			timer.Simple(5, function()			
				table.remove(att.lywootovict,index)
			end)
		end
    end)

    self:AddHook("TTTBodyFound", function( GAMEMODE, ply, deadply, rag )
		if ply.lywootovict and deadply then
			for i = 1, #ply.lywootovict do
				if deadply == ply.lywootovict[ i ] then
					self:Earn(ply)
				end	
			end
		end
    end)	
end

RegisterTTTTrophy(TROPHY)