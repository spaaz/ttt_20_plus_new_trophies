local TROPHY = {}
TROPHY.id = "terroristhero"
TROPHY.title = "Terrorist hero"
TROPHY.desc = "On the innocent team, kill 2 traitors in a single round (earned at end)"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT

    self:AddHook("TTTBeginRound", function()
        for _, ply in ipairs(player.GetAll()) do
            ply.terrhero = 0
        end
    end)

    self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
        if not IsPlayer(att) then return end

        if tgt.IsTraitorTeam then
            -- Custom Roles case
            if not tgt:IsTraitorTeam() then return end
        else
            -- Vanilla TTT case
            if tgt:GetRole() ~= ROLE_TRAITOR then return end
        end

        if att.IsInnocentTeam then
            -- Custom Roles case
            if att:IsInnocentTeam() then
                att.terrhero = att.terrhero + 1
            end
        else
            -- Vanilla TTT case
            if att:GetRole() == ROLE_INNOCENT or att:GetRole() == ROLE_DETECTIVE then
                att.terrhero = att.terrhero + 1
            end
        end
    end)

    self:AddHook("TTTEndRound", function()
        for _, ply in ipairs(player.GetAll()) do
            if ply.terrhero and ply.terrhero >= 2 then
                self:Earn(ply)
            end
        end
    end)
end

RegisterTTTTrophy(TROPHY)