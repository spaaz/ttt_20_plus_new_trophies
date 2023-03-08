local TROPHY = {}
TROPHY.id = "wellthatwasstupid"
TROPHY.title = "Well that was stupid"
TROPHY.desc = "Kill yourself with an explosive barrel"
TROPHY.rarity = 1
TROPHY.hidden = true

function TROPHY:Trigger()
    self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
        if IsPlayer(att) and (att == tgt) then
            local prop = dmginf:GetInflictor()

            if IsValid(prop) then
                local mod = prop:GetModel()

                if mod and isstring(mod) and ((mod == "models/props_c17/oildrum001_explosive.mdl") or (mod == "models/props_phx/oildrum001_explosive.mdl")) then
                    self:Earn(att)
                end
            end
        end
    end)
end

RegisterTTTTrophy(TROPHY)