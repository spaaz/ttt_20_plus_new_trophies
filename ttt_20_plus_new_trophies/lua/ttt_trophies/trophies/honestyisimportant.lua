local TROPHY = {}
TROPHY.id = "honestyisimportant"
TROPHY.title = "Honesty is a virtue"
TROPHY.desc = "On the traitor team, type \"I'm a traitor\" in chat"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("PlayerSay", function(sender, text, teamChat)
        if text == "I'm a traitor" then
            self:Earn(sender)
        end
    end)
end

RegisterTTTTrophy(TROPHY)