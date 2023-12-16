local function OnPlayerConnecting(name, setKickReason, deferrals)
    local source = source
    local licenseIdentifier = GetIdentifier(source, 'license')

    deferrals.defer()

    AddPlayerToQueue(licenseIdentifier, 0)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(3000)

            -- Check if the player has cancelled the connection
            if not GetPlayerEndpoint(source) then
                RemovePlayerFromQueue(licenseIdentifier)
                deferrals.done()
                break
            end

            -- Continuously check the players position in the queue
            local playerPosition = GetPlayerQueuePosition(licenseIdentifier)
            if playerPosition == 1 and not IsServerFull() then
                deferrals.done()
                break
            elseif playerPosition then
                local queueSize = GetQueueSize()
                deferrals.update(string.format("You are %d out of %d players in queue."), playerPosition, queueSize)
            end
        end
    end)
end

AddEventHandler('playerConnecting', OnPlayerConnecting)

AddEventHandler('playerJoining', function()
    RemovePlayerFromQueue()
end)
