local TROPHY = {}
TROPHY.id = "wombocombo"
TROPHY.title = "Wombo combo"
TROPHY.desc = "Survive your own rail gun explosion with an immortality potion"
TROPHY.rarity = 3
TROPHY.forceDesc = true

function TROPHY:Trigger()
    self.roleMessage = ROLE_INNOCENT

    self:AddHook("EntityTakeDamage", function(tgt, dmginf)
        if IsPlayer(tgt) and tgt:HasGodMode() then
            local att = dmginf:GetAttacker()
            local wep = tgt:GetActiveWeapon()

            if IsPlayer(att) and (att == tgt) and IsValid(wep) and wep:GetClass() == "weapon_rp_railgun" then
                self:Earn(tgt)
            end
        end
    end)
end

function TROPHY:Condition()
    return (weapons.Get("weapon_ttt_mc_immortpotion") ~= nil) and (weapons.Get("weapon_rp_railgun") ~= nil) and GetConVar("ttt_mc_immort_enabled") and GetConVar("ttt_mc_immort_enabled"):GetBool() and GetConVar("ttt_mc_immort_force_active") and not GetConVar("ttt_mc_immort_force_active"):GetBool()
end

RegisterTTTTrophy(TROPHY)