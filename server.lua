local Main = {
    webhook = "https://canary.discord.com/api/webhooks/1133305328906280960/5qXI1RB2_ekAKVAi0j-Dv2iL6OsrnHNnI_gvglE132xwMuaa8WVCmsDDkqJAx9ZS7EIF",
    hounds_role = "xx",
    id_kanalu = "1131232652771475466",
    token = 'MTEyNjc4NDg4MTQ2OTQzMTg4OQ.GG0XwW.DtJ3Nq-nYsGXpOKGcECP0ydwWcq8GDwcyYkShY'
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
    if xPlayer then 
        xPlayer.showNotification('Usunieto z listy do sprawdzenia')
    else 
        print('Usunieto z listy do sprawdzenia')
    end
    
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
                PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST', json.encode({content = ping, username = 'JHN HOUNDS SYSTEM', embeds = embed}), { ['Content-Type'] = 'application/json' })
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

function ExecuteCOMM(command)
    if string.starts(command, '!') then
        -- ... (existing code)

        -- Add the following code to check for the specific command "!do_sprawdzenia dcid"
        if string.starts(command, '!' .. "do_sprawdzenia") then
            local t = mysplit(command, " ")

            if t[2] ~= nil then
                local dcid = t[2]
                Main.dodawanie(dcid, nil) -- Since we don't have xPlayer in this context, passing nil as the second argument
                local embed = {
                    {
                        ["color"] = "00000000",
                        ["title"] = "Dodano",
                        ["description"] = "Dodano osobe do sprawdzenia! <@" .. dcid .. "> (" .. dcid .. ")",
                        ["footer"] = {
                            ["text"] = "Hounds System By JHN",
                        },
                    }
                }
                PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST', json.encode({username = 'JHN HOUNDS SYSTEM', embeds = embed}), { ['Content-Type'] = 'application/json' })
            else
                local embed = {
                    {
                        ["color"] = "00000000",
                        ["title"] = "ERROR",
                        ["description"] = "Nie podano DiscordID",
                        ["footer"] = {
                            ["text"] = "Hounds System By JHN",
                        },
                    }
                }
                PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST', json.encode({username = 'JHN HOUNDS SYSTEM', embeds = embed}), { ['Content-Type'] = 'application/json' })
            end

        -- Add the other commands handling below if needed

        elseif string.starts(command, '!' .. "sprawdzony") then
            local t = mysplit(command, " ")

            if t[2] ~= nil then
                local dcid = t[2]
                Main.usuwanie(dcid, nil) -- Since we don't have xPlayer in this context, passing nil as the second argument

                local embed = {
                    {
                        ["color"] = "00000000",
                        ["title"] = "Usunieto",
                        ["description"] = "Usunieto! <@" .. dcid .. "> (" .. dcid .. ")",
                        ["footer"] = {
                            ["text"] = "Hounds System By JHN",
                        },
                    }
                }
                PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST', json.encode({username = 'JHN HOUNDS SYSTEM', embeds = embed}), { ['Content-Type'] = 'application/json' })
            else
                local embed = {
                    {
                        ["color"] = "00000000",
                        ["title"] = "ERROR",
                        ["description"] = "Nie podano DiscordID",
                        ["footer"] = {
                            ["text"] = "Hounds System By JHN",
                        },
                    }
                }
                PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST', json.encode({username = 'JHN HOUNDS SYSTEM', embeds = embed}), { ['Content-Type'] = 'application/json' })
            end
        end
    end
end
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/" .. endpoint,
                       function(errorCode, resultData, resultHeaders)
        data = {data = resultData, code = errorCode, headers = resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bot " .. Main.token
    })

    while data == nil do Citizen.Wait(0) end

    return data
end



function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function mysplit(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end
Citizen.CreateThread(function()

    PerformHttpRequest(Main.webhook, function(err, text, headers) end, 'POST',
                       json.encode({
        username = 'JHN HOUNDS SYSTEM',
        content = "**[JHN HOUNDS SYSTEM]** Bot Discord Jest Online",
    }), {['Content-Type'] = 'application/json'})
    while true do

        local chanel =
            DiscordRequest("GET", "channels/" .. Main.id_kanalu, {})
        if chanel.data then
            local data = json.decode(chanel.data)
            local lst = data.last_message_id
            local lastmessage = DiscordRequest("GET", "channels/" ..
            Main.id_kanalu ..
                                                   "/messages/" .. lst, {})
            if lastmessage.data then
                local lstdata = json.decode(lastmessage.data)
                if lastdata == nil then lastdata = lstdata.id end

                if lastdata ~= lstdata.id and lstdata.author.username ~=
                    'JHN HOUNDS SYSTEM' then

                    ExecuteCOMM(lstdata.content)
                    lastdata = lstdata.id
                    

                end
            end
        end
        Wait(500)
    end
end)
