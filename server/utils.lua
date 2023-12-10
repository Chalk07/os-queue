function isServerFull()
    local maxClients = GetConvarInt('sv_maxclients', 32)
    local currentPlayerCount = #GetPlayers()

    return currentPlayerCount >= maxClients
end

function getIdentifier(source, identifierType)
    return GetPlayerIdentifierByType(source, identifierType or 'license')
end

function getQueuePosition(queue, itemKey)
    for i, node in ipairs(queue.heap) do
        if node.item == itemKey then
            return i
        end
    end
    return nil
end
