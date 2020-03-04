import UIKit

class MaxHeap<T: Comparable> {
    
    lazy var items: [T?] = Array(repeating: nil, count: capacity)
    
    var capacity: Int = 100
    var size: Int = 0
    
    init() {}
    
    func getLeftChildIndex(parentIndex: Int) -> Int {
        return 2 * parentIndex + 1
    }
    
    func getRightChildIndex(parentIndex: Int) -> Int {
        return 2 * parentIndex + 2
    }
    
    func getParentIndex(childIndex: Int) -> Int {
        return (childIndex - 1)/2
    }
    
    func hasLefChild(parentIndex: Int) -> Bool {
        return getLeftChildIndex(parentIndex: parentIndex) < size
    }
    
    func hasRightChild(parentIndex: Int) -> Bool {
        return getRightChildIndex(parentIndex: parentIndex) < size
    }
    
    func hasParent(childIndex: Int) -> Bool {
        return getParentIndex(childIndex: childIndex) >= 0
    }
    
    func swap(index1: Int, index2: Int) {
        guard index1 < size, index2 < size else {
            return
        }
        let temp = items[index1]
        items[index1] = items[index2]
        items[index2] = temp
    }
    
    func heapifyUp() {
        var index = size - 1
        
        while getParentIndex(childIndex: index) >= 0, items[index]! > items[getParentIndex(childIndex: index)]! {
            // while item is greater than its parent
            
            let parentIndex = getParentIndex(childIndex: index)
            swap(index1: index, index2: parentIndex)
            index = parentIndex
        }
    }
    func heapifyDown() {
        var index = 0
        while getLeftChildIndex(parentIndex: index) < size {
            let leftChildIndex = getLeftChildIndex(parentIndex: index)
            guard let leftChild = items[leftChildIndex], let parent = items[index] else {
                return
            }

            var greaterChildIndex = leftChildIndex
            let rightChildIndex = getRightChildIndex(parentIndex: index)
            if let rightChild = items[rightChildIndex], rightChild > leftChild {
                greaterChildIndex = rightChildIndex
            }
            
            if let greaterChild = items[greaterChildIndex], greaterChild > parent {
                swap(index1: index, index2: leftChildIndex)
            } else {
                break
            }
            index = greaterChildIndex
        }
    }
    func pop() -> T? {
        let temp = items[0]
        swap(index1: 0, index2: size - 1)
        size -= 1
        heapifyDown()
        return temp
    }
    
    func push(_ item: T) {
        items[size] = item
        size += 1
        heapifyUp()
    }
    
    func ensureCapacity() {
            // TODO:
    }
}


//let heap = MaxHeap<Int>()
//heap.push(0)
//heap.push(-1)
//heap.push(20)
//heap.push(5)
//heap.push(13)
//heap.push(-50)
//
//print(heap.pop())
//print(heap.pop())
//print(heap.pop())
//print(heap.pop())
//print(heap.pop())
//print(heap.pop())


struct NodeAndDistance: Comparable {
    static func < (lhs: NodeAndDistance, rhs: NodeAndDistance) -> Bool {
        return lhs.distance < rhs.distance
    }
    
    var node: Int
    var distance: Double
}

func dijkstras(from start: Int, to target: Int, tree: [Int: [(Int, Double)]]) -> Double {
    var visited: [Int: Bool] = [:]
    var parents: [Int: Int] = [:]
    
    var distances: [Int: Double] = [:]
    
    let toVisit = MaxHeap<NodeAndDistance>()
    toVisit.push(NodeAndDistance(node: start, distance: 0))
    
    while let next = toVisit.pop() {
        visited[next.node] = true
        let children = tree[next.node]
        
        for child in (children ?? []) {

            let (childNode, dist) = child
            guard visited[childNode] == nil else { continue }

            let childDist = next.distance + dist
            if childDist < (distances[childNode] ?? Double.infinity) {
                distances[childNode] = childDist
                toVisit.push(NodeAndDistance(node: childNode, distance: childDist))
                parents[childNode] = next.node
            }
        }
    }
    return Double.infinity
}
