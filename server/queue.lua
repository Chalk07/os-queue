local playerQueue = { playerHeap = {} }

-- Adds a player to the queue with a given priority
function AddPlayerToQueue(playerId, priority)
    local playerNode = { playerId = playerId, priority = priority, timestamp = os.time() }
    table.insert(playerQueue.playerHeap, playerNode)
    MoveUpInQueue()
    return true, "Player added to queue: " .. tostring(playerId)
end

-- Removes a player from the queue. If playerId is given, remove that specific player; otherwise, remove the highest priority player
function RemovePlayerFromQueue(playerId)
    if #playerQueue.playerHeap == 0 then
        return false, "Queue is empty"
    end

    local indexToRemove = 1
    if playerId then
        indexToRemove = GetPlayerQueueIndex(playerId)
        if not indexToRemove then
            return false, "Player not found in queue"
        end
    end

    local removedPlayer = playerQueue.playerHeap[indexToRemove].playerId
    SwapQueueNodes(indexToRemove, #playerQueue.playerHeap)
    table.remove(playerQueue.playerHeap)

    if #playerQueue.playerHeap > 1 then
        MoveUpInQueue(indexToRemove)
        MoveDownInQueue(indexToRemove)
    end

    return true, "Player removed from queue: " .. tostring(removedPlayer)
end

-- Updates the priority of a specific player both in the queue and optionally in the database.
function UpdatePlayerPriority(playerId, newPriority, saveToDatabase)
    local playerIndex = GetPlayerQueueIndex(playerId)

    if playerIndex then
        playerQueue.playerHeap[playerIndex].priority = newPriority
        MoveUpInQueue(playerIndex)
        MoveDownInQueue(playerIndex)
    end

    if saveToDatabase == "true" then
        local result = MySQL.insert.await('INSERT INTO priority (license, priority_level) VALUES (?, ?) ON DUPLICATE KEY UPDATE priority_level = VALUES(priority_level)', { playerId, newPriority })
        if not result then
            return false, "Failed to update database priority for player: " .. tostring(playerId)
        end
    end

    return true, "Priority changed for player: " .. tostring(playerId)
end

-- Moves a player upwards in the queue to maintain the queues order
function MoveUpInQueue(startIndex)
    local currentIndex = startIndex or #playerQueue.playerHeap

    while currentIndex > 1 do
        local parentIndex = math.floor(currentIndex / 2)
        if CompareQueueNodes(playerQueue.playerHeap[currentIndex], playerQueue.playerHeap[parentIndex]) then
            SwapQueueNodes(currentIndex, parentIndex)
            currentIndex = parentIndex
        else
            break
        end
    end
end

-- Moves a player down in the queue to maintain the queues order
function MoveDownInQueue(startIndex)
    local currentIndex = startIndex or 1

    while true do
        local leftChildIndex = 2 * currentIndex
        local rightChildIndex = leftChildIndex + 1
        local swapIndex = nil

        if leftChildIndex <= #playerQueue.playerHeap and CompareQueueNodes(playerQueue.playerHeap[leftChildIndex], playerQueue.playerHeap[currentIndex]) then
            swapIndex = leftChildIndex
        end

        if rightChildIndex <= #playerQueue.playerHeap and CompareQueueNodes(playerQueue.playerHeap[rightChildIndex], playerQueue.playerHeap[swapIndex or currentIndex]) then
            swapIndex = rightChildIndex
        end

        if not swapIndex then break end

        SwapQueueNodes(currentIndex, swapIndex)
        currentIndex = swapIndex
    end
end

-- Compares two nodes in the queue based on priority and timestamp
function CompareQueueNodes(firstNode, secondNode)
    return firstNode.priority > secondNode.priority or (firstNode.priority == secondNode.priority and firstNode.timestamp < secondNode.timestamp)
end

-- Swaps the position of two nodes in the queue
function SwapQueueNodes(firstIndex, secondIndex)
    playerQueue.playerHeap[firstIndex], playerQueue.playerHeap[secondIndex] = playerQueue.playerHeap[secondIndex], playerQueue.playerHeap[firstIndex]
end

-- Finds a players index in the queue based on their id
function GetPlayerQueueIndex(playerId)
    for i, playerNode in ipairs(playerQueue.playerHeap) do
        if playerNode.playerId == playerId then
            return i
        end
    end
    return nil
end

-- Returns the total number of players in the queue
function GetQueueSize()
    return #playerQueue.playerHeap, "Total players in queue: " .. #playerQueue.playerHeap
end

-- Returns the players position in the queue based on their id
function GetPlayerQueuePosition(playerId)
    local playerIndex = GetPlayerQueueIndex(playerId)
    return playerIndex, playerIndex and "Position in queue: " .. playerIndex or "Player not found in queue"
end

exports('UpdatePlayerPriority', UpdatePlayerPriority)
