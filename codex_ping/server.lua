local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('ping', function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not args[1] then
        TriggerClientEvent('QBCore:Notify', src, 'Usage: /ping [id]', 'error')
        return
    end

    local targetId = tonumber(args[1])
    if not targetId or targetId == src then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid ID or you cannot ping yourself.', 'error')
        return
    end

    local Target = QBCore.Functions.GetPlayer(targetId)
    if not Target then
        TriggerClientEvent('QBCore:Notify', src, 'Target player not found.', 'error')
        return
    end

    -- Get source player's coordinates
    TriggerClientEvent('qb-ping:sendLocation', src, targetId)
end)

RegisterNetEvent('qb-ping:sendCoordsToTarget', function(targetId, coords)
    local src = source
    TriggerClientEvent('qb-ping:createBlip', targetId, coords, src)
end)

