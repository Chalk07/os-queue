queue = { heap = {} }

-- Enqueues an item with a given priority.
function enqueue(item, priority)
    local node = { item = item, priority = priority, timestamp = os.time() }
    table.insert(queue.heap, node)
    bubbleUp()
    return true, "Enqueued item: " .. tostring(item)
end

-- Dequeues an item. If itemKey is given, removes that specific item; otherwise, removes the highest priority item.
function dequeue(itemKey)
    if #queue.heap == 0 then
        return false, "Queue is empty"
    end

    local indexToRemove = 1
    if itemKey then
        indexToRemove = getIndex(itemKey)
        if not indexToRemove then
            return false, "Item not found in queue"
        end
    end

    local removedItem = queue.heap[indexToRemove].item
    swap(indexToRemove, #queue.heap)
    table.remove(queue.heap)

    if #queue.heap > 1 then
        bubbleUp(indexToRemove)
        sinkDown(indexToRemove)
    end

    return true, "Dequeued item: " .. tostring(removedItem)
end

-- Changes the priority of a specific item in the queue.
function changePriority(itemKey, newPriority)
    local index = getIndex(itemKey)
    if not index then
        return false, "Item not found in queue"
    end

    queue.heap[index].priority = newPriority
    bubbleUp(index)
    sinkDown(index)
    return true, "Priority changed for item: " .. tostring(itemKey)
end

-- Adjusts the position of an item upwards in the heap to maintain the heap property.
function bubbleUp(startIndex)
    local currentIndex = startIndex or #queue.heap

    while currentIndex > 1 do
        local parentIndex = math.floor(currentIndex / 2)
        if compareNodes(queue.heap[currentIndex], queue.heap[parentIndex]) then
            swap(currentIndex, parentIndex)
            currentIndex = parentIndex
        else
            break
        end
    end
end

-- Adjusts the position of an item downwards in the heap to maintain the heap property.
function sinkDown(startIndex)
    local currentIndex = startIndex or 1

    while true do
        local leftChildIndex = 2 * currentIndex
        local rightChildIndex = leftChildIndex + 1
        local swapIndex = nil

        if leftChildIndex <= #queue.heap and compareNodes(queue.heap[leftChildIndex], queue.heap[currentIndex]) then
            swapIndex = leftChildIndex
        end

        if rightChildIndex <= #queue.heap and compareNodes(queue.heap[rightChildIndex], queue.heap[swapIndex or currentIndex]) then
            swapIndex = rightChildIndex
        end

        if not swapIndex then break end

        swap(currentIndex, swapIndex)
        currentIndex = swapIndex
    end
end

-- Compares two nodes in the heap based on priority and timestamp.
function compareNodes(node1, node2)
    return node1.priority > node2.priority or (node1.priority == node2.priority and node1.timestamp < node2.timestamp)
end

-- Swaps two items in the heap.
function swap(firstIndex, secondIndex)
    queue.heap[firstIndex], queue.heap[secondIndex] = queue.heap[secondIndex], queue.heap[firstIndex]
end

-- Finds the index of an item by its key.
function getIndex(itemKey)
    for i, node in ipairs(queue.heap) do
        if node.item == itemKey then
            return i
        end
    end
    return nil
end

-- Returns the total number of items in the queue.
function getQueueSize()
    return #queue.heap, "Total items in queue: " .. #queue.heap
end

-- Returns a player's position in the queue based on their unique identifier.
function getQueuePosition(itemKey)
    local index = getIndex(itemKey)
    return index, index and "Position in queue: " .. index or "Item not found in queue"
end

-- Export the changePriority function
exports('changePriority', changePriority)
