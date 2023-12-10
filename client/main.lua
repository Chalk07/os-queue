CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            TriggerServerEvent('removeFromQueue')
            break
        end
    end
end)
