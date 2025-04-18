RegisterNetEvent('qb-ping:sendLocation', function(targetId)
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('qb-ping:sendCoordsToTarget', targetId, coords)
    TriggerEvent('QBCore:Notify', 'Ping sent!', 'success')
end)

RegisterNetEvent('qb-ping:createBlip', function(coords, senderId)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 280)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Ping from [" .. senderId .. "]")
    EndTextCommandSetBlipName(blip)

    -- Optional: Remove blip after 60 seconds
    Citizen.SetTimeout(60000, function()
        RemoveBlip(blip)
    end)

    TriggerEvent('QBCore:Notify', 'You received a ping from [' .. senderId .. ']', 'primary')
end)

RegisterNetEvent('QBCore:Notify', function(message, type)
    if lib then
        lib.notify({ description = message, type = type or 'inform' })
    else
        QBCore.Functions.Notify(message, type)
    end
end)
