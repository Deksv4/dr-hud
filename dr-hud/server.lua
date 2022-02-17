local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local types = {
    "health",
    "armor",
    "hunger",
    "thirst",
}

RegisterServerCallback('dr-hud:CheckInformation', function(source, cb)
    local user_id = vRP.getUserId({source})

    local hunger = vRP.getHunger({user_id})
    local thirst = vRP.getThirst({user_id})

    cb(hunger, thirst)
end)

RegisterCommand("togglehud", function(source, args)
    if args ~= nil then
        local type = args[1]

        for k,v in pairs(types) do
            if v == string.lower(type) then
                TriggerClientEvent("dr-hud:ToggleItem", source, v)
                break
            end
        end
    end
end)