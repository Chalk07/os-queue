local function onPlayerConnecting(name, setKickReason, deferrals)
    local source = source
    local licenseIdentifier = getIdentifier(source, 'license')

    deferrals.defer()

    enqueue(licenseIdentifier, 0)

    CreateThread(function()
        while true do
            Wait(3000)

            -- Check if the player has cancelled the connection
            if not GetPlayerEndpoint(source) then
                dequeue(licenseIdentifier)
                deferrals.done()
                break
            end

            -- Continuously check the player's position in the queue
            local position = getQueuePosition(licenseIdentifier)
            if position == 1 and not isServerFull() then
                deferrals.done()
                break
            elseif position then
                local queueSize = getQueueSize()
                deferrals.update(string.format("You are %d out of %d players in queue.", position, queueSize))
            end
        end
    end)
end

AddEventHandler('playerConnecting', onPlayerConnecting)

AddEventHandler('playerJoining', function()
    dequeue()
end)
