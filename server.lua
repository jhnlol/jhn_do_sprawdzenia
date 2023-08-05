local Main = {
    webhook = "https://canary.discord.com/api/webhooks/1133305328906280960/5qXI1RB2_ekAKVAi0j-Dv2iL6OsrnHNnI_gvglE132xwMuaa8WVCmsDDkqJAx9ZS7EIF",
    hounds_role = "xx"
}
ESX = exports["es_extended"]:getSharedObject()
Main.dodawanie = function(dcid, xPlayer) 
    MySQL.insert('INSERT INTO do_sprawdzanie (dcid) VALUES (?)',
    {dcid})
    if xPlayer then 
        xPlayer.showNotification('Pomyslnie wpisano go na liste do sprawdzenia!')
    else 
        print('Pomyslnie wpisano go na liste do sprawdzenia!')
    end
end
Main.usuwanie = function(dcid, xPlayer) 
    MySQL.execute('DELETE FROM `do_sprawdzanie` WHERE `dcid` = ?', { dcid }, function(response)
        if response then
            for i = 1, #response do
                local row = response[i]
            end
        else 
        end
    end)
    xPlayer.showNotification('Usunieto z listy do sprawdzenia')
end
Main.sprawdzanie = function(dcid, id)
    MySQL.query('SELECT * FROM `do_sprawdzanie` WHERE `dcid` = ?', {
        dcid
    }, function(response)
        if response then
            for i = 1, #response do
                local row = response[i]
                local ping = "<@"..Main.hounds_role..">"
                local embed = {
                    {
                        ["color"] = "00000000",
                        ["title"] = "Osoba wzywana **ONLINE!**",
                        ["description"] = "Osoba wzywana wbila na serwer i dcid jej to <@"..dcid.."> ("..dcid..")",
                        ["footer"] = {
                            ["text"] = "Hounds System By JHN",
                        },
                    }
                }
                PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST', json.encode({content = ping, username = 'Hounds System', embeds = embed}), { ['Content-Type'] = 'application/json' })
            end
        else 
        end
    end)
end
ESX.RegisterCommand('do_sprawdzenia', {'best', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.dcid then 
        Main.dodawanie(args.dcid, xPlayer)
    end
end, true, {help = "Wezwij na sprawdzanie", validate = true, arguments = {
    {name = 'dcid', help = "ID gracza", type = 'string'},
}})
ESX.RegisterCommand('sprawdzony', {'best', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.dcid then 
        Main.usuwanie(args.dcid, xPlayer)
    end
end, true, {help = "Wezwij na sprawdzanie", validate = true, arguments = {
    {name = 'dcid', help = "ID gracza", type = 'string'},
}})

AddEventHandler('playerConnecting', function()
    local dcid = "unknown" 

    if source then
        local identifiers = GetPlayerIdentifiers(source)

        for _, identifier in ipairs(identifiers) do
            if string.sub(identifier, 1, string.len("discord:")) == "discord:" then
                dcid = string.sub(identifier, string.len("discord:") + 1)
                break
            end
        end
    end
    Main.sprawdzanie(dcid, source)
end)