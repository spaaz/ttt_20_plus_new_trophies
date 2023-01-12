local TROPHY = {}
TROPHY.id = "getpoooooned"
TROPHY.title = "Get poooooned"
TROPHY.desc = "Kill someone with a harpoon"
TROPHY.rarity = 1
TROPHY.hidden = true

function TROPHY:Trigger()
    self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
        if IsPlayer(att) and IsValid(dmginf:GetInflictor()) and dmginf:GetInflictor():GetClass() == "hwapoon_arrow" then
            self:Earn(att)
        end
    end)
end

function TROPHY:Condition()
    return scripted_ents.Get("hwapoon_arrow") ~= nil
end

RegisterTTTTrophy(TROPHY)