if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
    if file.Exists("autorun/ttt_trophies_load.lua", "lsv") then return end
    util.AddNetworkString("TTTTrophiesBaseModLink")
    local roundCount = 0

    hook.Add("TTTBeginRound", "TTTTrophiesBaseModInstallMessage", function()
        roundCount = roundCount + 1

        timer.Simple(4, function()
            PrintMessage(HUD_PRINTTALK, "[20 Plus More TTT Achievements]\nServer doesn't have the addon this mod needs to work!\nPRESS 'Y', TYPE /achievements20+ AND SUBSCRIBE TO THE ADDON \nor see this mod's workshop page to install it.")
        end)

        if roundCount == 2 then
            hook.Remove("TTTBeginRound", "TTTTrophiesBaseModInstallMessage")
        end
    end)

    hook.Add("PlayerSay", "TTTTrophiesBaseModLink", function(ply, text)
        if string.lower(text) == "/achievements20+" then
            net.Start("TTTTrophiesBaseModLink")
            net.Send(ply)

            return ""
        end
    end)
end

if CLIENT then
    net.Receive("TTTTrophiesBaseModLink", function()
        steamworks.ViewFile("2902853445")
    end)
end