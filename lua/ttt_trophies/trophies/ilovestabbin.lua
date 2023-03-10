local TROPHY = {}
TROPHY.id = "ilovestabbin"
TROPHY.title = "I love stabbin\'"
TROPHY.desc = "Kill someone with a knife"
TROPHY.rarity = 1
TROPHY.hidden = true

function TROPHY:Trigger()
    self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
        if IsPlayer(att) then
            local wep = att:GetActiveWeapon()

            if IsValid(wep) and (wep:GetClass() == "weapon_ttt_knife") then
                self:Earn(att)
            end
        end
    end)
end

function TROPHY:Condition()
    return TTTTrophies:IsBuyableItem(ROLE_TRAITOR, "weapon_ttt_knife")
end

RegisterTTTTrophy(TROPHY)