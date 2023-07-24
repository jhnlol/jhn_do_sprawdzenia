local Main = {

}
Main.dodawanie = function(dcid, xPlayer) 
    MySQL.insert('INSERT INTO do_sprawdzanie (dcid) VALUES (?)',
    {dcid})
    xPlayer.showNotification('Pomyslnie wpisano go na liste do sprawdzenia!')
end
Main.usuwanie = function(dcid) 
    MySQL.query('DELETE FROM `sprawdzanie` WHERE `dcid` = ?', { dcid }, function(response)
        if response then
            for i = 1, #response do
                local row = response[i]
                print("usunieto")
            end
        else 
            print("Error occurred while deleting rows.")
        end
    end)
end
Main.sprawdzanie = function(dcid)
    MySQL.query('SELECT * FROM `sprawdzanie` WHERE `dcid` = ?', {
        dcid
    }, function(response)
        if response then
            for i = 1, #response do
                local row = response[i]
                -- wezwanie
            end
        else 
        end
    end)
end
ESX = exports["es_extended"]:getSharedObject()
ESX.RegisterCommand('do_sprawdzenia', {'best', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.dcid then 
        Main.dodawanie(args.dcid, xPlayer)
    end
end, true, {help = "Wezwij na sprawdzanie", validate = true, arguments = {
    {name = 'dcid', help = "ID gracza", type = 'string'},
}})
ESX.RegisterCommand('sprawdzony', {'best', 'mod', 'admin', 'superadmin'}, function(xPlayer, args, showError)
    if args.dcid then 
        Main.usuwanie(args.dcid)
    end
end, true, {help = "Wezwij na sprawdzanie", validate = true, arguments = {
    {name = 'dcid', help = "ID gracza", type = 'string'},
}})