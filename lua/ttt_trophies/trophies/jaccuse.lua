local TROPHY = {}
TROPHY.id = "jaccuse"
TROPHY.title = "J\'accuse!"
TROPHY.desc = "Write \"It\'s \" followed by a player name in chat"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT

    self:AddHook("PlayerSay", function(sender, text, teamChat)
	local _, _, its, name = string.find(text,"^(It\'s )(.+)$")
        if its then
			for _, ply in ipairs(player.GetAll()) do
				if name == ply:Nick() then
					self:Earn(sender)
				end
			end
        end
    end)
end

RegisterTTTTrophy(TROPHY)