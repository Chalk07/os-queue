-- Determines if the server is currently at full capacity based on the maximum number of clients allowed.
function isServerFull()
    local maxClients = GetConvarInt('sv_maxclients', 32)
    local currentPlayerCount = #GetPlayers()

    return currentPlayerCount >= maxClients
end

-- Retrieves a specific type of identifier for a player, defaulting to 'license' if not specified.
function getIdentifier(source, identifierType)
    return GetPlayerIdentifierByType(source, identifierType or 'license')
end

-- Determines a player's position in the queue based on their unique identifier.
function getQueuePosition(queue, itemKey)
    for i, node in ipairs(queue.heap) do
        if node.item == itemKey then
            return i
        end
    end
    return nil
end
