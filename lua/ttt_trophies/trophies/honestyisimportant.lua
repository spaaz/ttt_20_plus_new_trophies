local TROPHY = {}
TROPHY.id = "honestyisimportant"
TROPHY.title = "Honesty is a virtue"
TROPHY.desc = "On the traitor team, type \"I'm a traitor\" in chat"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("PlayerSay", function(sender, text, teamChat)
        text = string.lower(text)
        if text == "i'm a traitor" or text == "im a traitor" then
            self:Earn(sender)
        end
    end)
end

RegisterTTTTrophy(TROPHY)