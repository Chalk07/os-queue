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

-- Returns the players priority level if in the database; otherwise, return priority 0
function GetPlayerPriority(source)
    local playerLicense = GetIdentifier(source, 'license')
    local result = MySQL.single.await('SELECT priority_level FROM priority WHERE license = ?', { playerLicense })
    if not result then return 0 end

    return result.priority_level
end
