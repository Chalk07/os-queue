function createPriorityQueue()
    return { heap = {} }
end

function enqueue(queue, item, priority)
    local node = { item = item, priority = priority, timestamp = os.time() }
    table.insert(queue.heap, node)
    bubbleUp(queue.heap)
end

function dequeue(queue)
    if #queue.heap == 0 then return nil end

    local highestPriorityItem = queue.heap[1].item
    local endNode = table.remove(queue.heap)

    if #queue.heap > 0 then
        queue.heap[1] = endNode
        sinkDown(queue.heap)
    end

    return highestPriorityItem
end

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

function compareNodes(node1, node2)
    if node1.priority > node2.priority then
        return true
    elseif node1.priority == node2.priority then
        return node1.timestamp < node2.timestamp
    else
        return false
    end
end

function swap(heap, firstIndex, secondIndex)
    heap[firstIndex], heap[secondIndex] = heap[secondIndex], heap[firstIndex]
end

function dequeueByKey(queue, itemKey)
    local length = #queue.heap
    local indexToRemove

    for i = 1, length do
        if queue.heap[i].item == itemKey then
            indexToRemove = i
            break
        end
    end

    if not indexToRemove then
        return false, "Item not found in queue"
    end

    queue.heap[indexToRemove] = queue.heap[length]
    table.remove(queue.heap)

    if length > 1 then
        bubbleUp(queue.heap, indexToRemove)
        sinkDown(queue.heap, indexToRemove)
    end

    return true, "Item removed successfully"
end
