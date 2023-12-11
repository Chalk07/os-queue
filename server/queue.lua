-- Creates and returns an empty priority queue
function createPriorityQueue()
    return { heap = {} }
end

-- Adds an item to the priority queue with a given priority.
-- The heap property is maintained by performing a bubble-up operation.
function enqueue(queue, item, priority)
    local node = { item = item, priority = priority, timestamp = os.time() }
    table.insert(queue.heap, node)
    bubbleUp(queue.heap)
end

-- Removes and returns an item from the queue.
-- If itemKey is provided, removes the specified item;
-- otherwise, removes the highest priority item.
function dequeue(queue, itemKey)
    if #queue.heap == 0 then return nil end

    local indexToRemove = 1
    local removedItem

    if itemKey then
        for i, node in ipairs(queue.heap) do
            if node.item == itemKey then
                indexToRemove = i
                break
            end
        end

        if indexToRemove == nil then
            return false, "Item not found in queue"
        elseif indexToRemove == #queue.heap then
            removedItem = table.remove(queue.heap).item
            return true, removedItem
        end
    end

    removedItem = queue.heap[indexToRemove].item
    swap(queue.heap, indexToRemove, #queue.heap)
    table.remove(queue.heap)

    if #queue.heap > 0 then
        bubbleUp(queue.heap, indexToRemove)
        sinkDown(queue.heap, indexToRemove)
    end

    return true, removedItem
end

-- Internal function to adjust the position of an item upwards in the heap.
function bubbleUp(heap, startIndex)
    local currentIndex = startIndex or #heap

    while currentIndex > 1 do
        local parentIndex = math.floor(currentIndex / 2)
        if compareNodes(heap[currentIndex], heap[parentIndex]) then
            swap(heap, currentIndex, parentIndex)
            currentIndex = parentIndex
        else
            break
        end
    end
end

-- Internal function to adjust the position of an item downwards in the heap.
function sinkDown(heap, startIndex)
    local currentIndex = startIndex or 1
    local length = #heap

    while true do
        local leftChildIndex = 2 * currentIndex
        local rightChildIndex = leftChildIndex + 1
        local swapIndex = nil

        if leftChildIndex <= length and compareNodes(heap[leftChildIndex], heap[currentIndex]) then
            swapIndex = leftChildIndex
        end

        if rightChildIndex <= length and compareNodes(heap[rightChildIndex], heap[swapIndex or currentIndex]) then
            swapIndex = rightChildIndex
        end

        if not swapIndex then break end

        swap(heap, currentIndex, swapIndex)
        currentIndex = swapIndex
    end
end

-- Compares two nodes in the heap based on priority and timestamp.
-- Returns true if the first node should be higher in the heap.
function compareNodes(node1, node2)
    if node1.priority > node2.priority then
        return true
    elseif node1.priority == node2.priority then
        return node1.timestamp < node2.timestamp
    else
        return false
    end
end

-- Swaps two items in the heap. Used during bubble-up and sink-down operations.
function swap(heap, firstIndex, secondIndex)
    heap[firstIndex], heap[secondIndex] = heap[secondIndex], heap[firstIndex]
end-- Creates and returns an empty priority queue
function createPriorityQueue()
    return { heap = {} }
end

-- Adds an item to the priority queue with a given priority.
-- The heap property is maintained by performing a bubble-up operation.
function enqueue(queue, item, priority)
    local node = { item = item, priority = priority, timestamp = os.time() }
    table.insert(queue.heap, node)
    bubbleUp(queue.heap)
end

-- Removes and returns an item from the queue.
-- If itemKey is provided, removes the specified item;
-- otherwise, removes the highest priority item.
function dequeue(queue, itemKey)
    if #queue.heap == 0 then return nil end

    local indexToRemove = 1
    local removedItem

    if itemKey then
        for i, node in ipairs(queue.heap) do
            if node.item == itemKey then
                indexToRemove = i
                break
            end
        end

        if indexToRemove == nil then
            return false, "Item not found in queue"
        elseif indexToRemove == #queue.heap then
            removedItem = table.remove(queue.heap).item
            return true, removedItem
        end
    end

    removedItem = queue.heap[indexToRemove].item
    swap(queue.heap, indexToRemove, #queue.heap)
    table.remove(queue.heap)

    if #queue.heap > 0 then
        bubbleUp(queue.heap, indexToRemove)
        sinkDown(queue.heap, indexToRemove)
    end

    return true, removedItem
end

-- Internal function to adjust the position of an item upwards in the heap.
function bubbleUp(heap, startIndex)
    local currentIndex = startIndex or #heap

    while currentIndex > 1 do
        local parentIndex = math.floor(currentIndex / 2)
        if compareNodes(heap[currentIndex], heap[parentIndex]) then
            swap(heap, currentIndex, parentIndex)
            currentIndex = parentIndex
        else
            break
        end
    end
end

-- Internal function to adjust the position of an item downwards in the heap.
function sinkDown(heap, startIndex)
    local currentIndex = startIndex or 1
    local length = #heap

    while true do
        local leftChildIndex = 2 * currentIndex
        local rightChildIndex = leftChildIndex + 1
        local swapIndex = nil

        if leftChildIndex <= length and compareNodes(heap[leftChildIndex], heap[currentIndex]) then
            swapIndex = leftChildIndex
        end

        if rightChildIndex <= length and compareNodes(heap[rightChildIndex], heap[swapIndex or currentIndex]) then
            swapIndex = rightChildIndex
        end

        if not swapIndex then break end

        swap(heap, currentIndex, swapIndex)
        currentIndex = swapIndex
    end
end

-- Compares two nodes in the heap based on priority and timestamp.
-- Returns true if the first node should be higher in the heap.
function compareNodes(node1, node2)
    if node1.priority > node2.priority then
        return true
    elseif node1.priority == node2.priority then
        return node1.timestamp < node2.timestamp
    else
        return false
    end
end

-- Swaps two items in the heap. Used during bubble-up and sink-down operations.
function swap(heap, firstIndex, secondIndex)
    heap[firstIndex], heap[secondIndex] = heap[secondIndex], heap[firstIndex]
end
