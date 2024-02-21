local TROPHY = {}
TROPHY.id = "youshouldhaveleft"
TROPHY.title = "Should have left me dead"
TROPHY.desc = "On the traitor team, revive the glitch with a bought defib (earned at end)"
TROPHY.rarity = 2

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("KeyPress", function(ply, key)
        if (key == IN_ATTACK) and IsValid(ply:GetActiveWeapon()) and (ply:GetActiveWeapon():GetClass() == "weapon_vadim_defib") then
            local tr = ply:GetEyeTrace(MASK_SHOT_HULL)
            local ent = tr.Entity

            if IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
                for _, p in ipairs(player.GetAll()) do
                    if p:GetRole() == ROLE_GLITCH and not p:Alive() then
                        local delay = 5

                        if GetConVar("ttt_defib_chargetime") then
                            delay = 1 + GetConVar("ttt_defib_chargetime"):GetInt()
                        end

                        timer.Simple(delay, function()
                            if IsPlayer(p) and p:Alive() and IsPlayer(ply) then
                                ply.yshlmdtrophtearn = true
                            end
                        end)
                    end
                end
            end
        end
    end)

    self:AddHook("TTTEndRound", function()
        for _, ply in ipairs(player.GetAll()) do
            if ply.yshlmdtrophtearn then
                self:Earn(ply)
            end
        end
    end)
end

function TROPHY:Condition()
    return TTTTrophies:CanRoleSpawn(ROLE_GLITCH) and TTTTrophies:IsBuyableItem(ROLE_TRAITOR, "weapon_vadim_defib")
end

RegisterTTTTrophy(TROPHY)