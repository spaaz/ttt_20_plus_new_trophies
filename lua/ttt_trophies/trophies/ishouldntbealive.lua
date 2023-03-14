local TROPHY = {}
TROPHY.id = "ishouldntbealive"
TROPHY.title = "I shouldn\'t be alive"
TROPHY.desc = "Survive a shark trap with an uno reverse"
TROPHY.rarity = 3
TROPHY.forceDesc = true

function TROPHY:Trigger()
    self.roleMessage = ROLE_DETECTIVE

    self:AddHook("EntityTakeDamage", function(tgt, dmginf)
        if IsPlayer(tgt) and tgt:GetNWBool("HasUNOReverse") then
            local wep = dmginf:GetInflictor()

            if IsValid(wep) and wep:GetClass() == "ttt_shark_trap" then
                self:Earn(tgt)
            end
        end
    end)
end

function TROPHY:Condition()
    for _, addon in ipairs(engine.GetAddons()) do
        if addon.mounted then
            if addon.wsid == "2329721936" then return scripted_ents.Get("ttt_shark_trap") ~= nil end
        end
    end

    return false
end

RegisterTTTTrophy(TROPHY)