local queue = createPriorityQueue()

local function onPlayerConnecting(name, setKickReason, deferrals)
    local source = source
    local licenseIdentifier = getIdentifier(source, 'license')

    deferrals.defer()

    if isServerFull() then
        deferrals.update("Connecting...")
        enqueue(queue, licenseIdentifier, 0)

        CreateThread(function()
            while true do
                -- check if the player has cancelled the connection
                if not GetPlayerEndpoint(source) then
                    dequeue(queue, licenseIdentifier)
                    deferrals.done()
                    break
                end

                -- check if the player is at the front of the queue and the server has space
                local position = getQueuePosition(queue, licenseIdentifier)
                if position == 1 and not isServerFull() then
                    deferrals.done()
                    break
                elseif position then
                    local total = #queue.heap
                    deferrals.update(string.format("You are %d out of %d players in queue.", position, total))
                end
                Wait(5000)
            end
        end)
    else
        deferrals.done()
    end
end

AddEventHandler('playerConnecting', onPlayerConnecting)


RegisterServerEvent('removeFromQueue')
AddEventHandler('removeFromQueue', function()
    local source = source
    local licenseIdentifier = getIdentifier(source, 'license')
    dequeue(queue, licenseIdentifier)
end)
