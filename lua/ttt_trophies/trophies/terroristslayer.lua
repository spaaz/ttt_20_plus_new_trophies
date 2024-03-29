local TROPHY = {}
TROPHY.id = "terroristslayer"
TROPHY.title = "Terrorist slayer"
TROPHY.desc = "On the traitor team, kill 3 enemies in a single round"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("TTTBeginRound", function()
        for _, ply in ipairs(player.GetAll()) do
            ply.terrslay = 0
        end
    end)

    self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
        if IsPlayer(att) and (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and ((not CR_VERSION and not tgt:IsActiveTraitor()) or (CR_VERSION and (tgt:IsInnocentTeam() or tgt:IsMonsterTeam() or tgt:IsIndependentTeam() or ((tgt:GetRole() == ROLE_CLOWN) and tgt:GetNWBool("KillerClownActive", false))))) then
            if not att.terrslay then
                att.terrslay = 0
            end

            if att.terrslay < 2 then
                att.terrslay = att.terrslay + 1
            else
                self:Earn(att)
            end
        end
    end)
end

RegisterTTTTrophy(TROPHY)