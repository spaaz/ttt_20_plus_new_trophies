local TROPHY = {}
TROPHY.id = "getpoooooned"
TROPHY.title = "Get poooooned"
TROPHY.desc = "Kill someone with a harpoon"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt,att,dmginf)
		if IsValid(dmginf:GetInflictor()) and dmginf:GetInflictor():GetClass() == "hwapoon_arrow" then
			if att:IsPlayer() then
				self:Earn(att)
			end
		end
    end)
end

function TROPHY:Condition()
    return scripted_ents.Get("hwapoon_arrow") ~= nil
end

RegisterTTTTrophy(TROPHY)