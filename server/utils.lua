-- Checks if the server is full based on the maximum number of clients allowed
function IsServerFull()
    local maxClients = GetConvarInt('sv_maxclients', 32)
    local currentPlayerCount = #GetPlayers()

    return currentPlayerCount >= maxClients
end

-- Returns the specified identifier for a player
function GetIdentifier(source, identifierType)
    return GetPlayerIdentifierByType(source, identifierType or 'license')
end
