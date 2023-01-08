local TROPHY = {}
TROPHY.id = "barnaclemaster"
TROPHY.title = "Barnacle master"
TROPHY.desc = "On the traitor team, kill 2 enemies with barnacles in a single round"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR
    self:AddHook( "TTTBeginRound", function()
        for _, ply in ipairs(player.GetAll()) do
            ply.barnaclekill = false
        end
    end)

    self:AddHook("DoPlayerDeath", function(tgt, att, dmginf)
        if IsPlayer(att) and IsValid(dmginf:GetInflictor()) and dmginf:GetInflictor():GetClass() == "npc_barnacle" then
            if (att:IsActiveTraitor() or (CR_VERSION and att:IsTraitorTeam())) and ((not CR_VERSION and not tgt:IsActiveTraitor()) or (CR_VERSION and (tgt:IsInnocentTeam() or tgt:IsMonsterTeam() or tgt:IsIndependentTeam() or ((tgt:GetRole() == ROLE_CLOWN) and tgt:GetNWBool("KillerClownActive", false))))) then
                if att.barnaclekill then
                    self:Earn(att)
                else
                    att.barnaclekill = true
                end
            end
        end
    end)
end

function TROPHY:Condition()
    return weapons.Get("weapon_ttt_barnacle") ~= nil
end

RegisterTTTTrophy(TROPHY)