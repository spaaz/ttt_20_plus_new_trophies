local TROPHY = {}
TROPHY.id = "licencetokill"
TROPHY.title = "Licence to kill"
TROPHY.desc = "Kill someone with a silenced pistol"
TROPHY.rarity = 1

function TROPHY:Trigger()
    self.roleMessage = ROLE_TRAITOR

    self:AddHook("DoPlayerDeath", function(tgt, attacker, dmginfo)
        local inflictor = dmginfo:GetInflictor()

        if IsValid(inflictor) and inflictor:GetClass() == "weapon_ttt_sipistol" and IsValid(attacker) and attacker:IsPlayer() then
            self:Earn(attacker)
        end
    end)
end

function TROPHY:Condition()
    return TTTTrophies:IsBuyableItem(ROLE_TRAITOR, "weapon_ttt_sipistol")
end

RegisterTTTTrophy(TROPHY)