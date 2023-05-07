local TROPHY = {}
TROPHY.id = "ishouldntbealive"
TROPHY.title = "I shouldn\'t be alive"
TROPHY.desc = "Survive a shark trap with an uno reverse"
TROPHY.rarity = 3
TROPHY.forceDesc = true

function TROPHY:Trigger()
    self.roleMessage = ROLE_DETECTIVE
    -- Override shark trap to trigger trophy as shark trap has a weird bug with passing its inflictor
    -- and we will have to hack the shark trap like this to fix that anyway
    local ENT = scripted_ents.GetStored("ttt_shark_trap").t
    local oldTouch = ENT.Touch

    function ENT:Touch(toucher)
        if not IsValid(toucher) or not toucher:IsPlayer() then return end

        -- 1.6 seconds is how long the shark trap waits to kill the player after they step on it
        timer.Simple(1.6, function()
            if not IsValid(toucher) then return end
            local wep = toucher:GetActiveWeapon()

            if IsValid(wep) and wep:GetClass() == "weapon_unoreverse" then
                -- Don't earn the trophy right away in case the uno reverse didn't work for whatever reason and the player is dead
                timer.Simple(0.1, function()
                    if IsValid(toucher) and toucher:Alive() and not toucher:IsSpec() then
                        TROPHY:Earn(toucher)
                    end
                end)
            end
        end)

        return oldTouch(self, toucher)
    end
end

function TROPHY:Condition()
    local unoSWEP = weapons.Get("weapon_unoreverse")
    -- Uno reverse can be installed, but only is a functioning TTT weapon if it has a weapon kind

    return weapons.Get("weapon_shark_trap") ~= nil and unoSWEP ~= nil and unoSWEP.Kind
end

RegisterTTTTrophy(TROPHY)