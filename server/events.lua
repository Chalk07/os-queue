local function onPlayerConnecting(name, setKickReason, deferrals)
    local source = source
    local licenseIdentifier = getIdentifier(source, 'license')

    deferrals.defer()

    if isServerFull() then
        enqueue(licenseIdentifier, 0)

        CreateThread(function()
            while true do
                -- check if the player has cancelled the connection
                if not GetPlayerEndpoint(source) then
                    dequeue(licenseIdentifier)
                    deferrals.done()
                    break
                end

                -- check if the player is at the front of the queue and the server has space
                local position = getQueuePosition(licenseIdentifier)
                if position == 1 and not isServerFull() then
                    deferrals.done()
                    break
                elseif position then
                    local queueSize = getQueueSize()
                    deferrals.update(string.format("You are %d out of %d players in queue.", position, queueSize))
                end
                Wait(3000)
            end
        end)
    else
        deferrals.done()
    end
end

AddEventHandler('playerConnecting', onPlayerConnecting)


RegisterServerEvent('removeFromQueue')
AddEventHandler('removeFromQueue', function()
    dequeue(licenseIdentifier)
end)
