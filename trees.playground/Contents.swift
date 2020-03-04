import UIKit

var tree = [
    0: [1,2],
    1: [3,4],
    2: [5,6],
    3: [7,8],
    4: [9, 10],
    5: [11, 12],
    6: [13, 14],
    7: [15]
]

// DFS
//func getLeaves(tree: [Int: [Int]], startNode: Int = 0) -> [Int] {
//    let children = tree[startNode] ?? []
//
//    if children.count == 0 {
//        return [startNode]
//    }
//
//    var leaves = [Int]()
//    for child in children {
//        leaves += getLeaves(tree: tree, startNode: child)
//    }
//
//    return leaves
//}


//print(getLeaves(tree: tree))


//func getTreeHeight(tree: [Int: [Int]], startNode: Int = 0) -> Int {
//    print("get height of subtree at: \(startNode)")
//    let children = tree[startNode] ?? []
//    var height = 0
//    if children.count == 0 {
//        return height
//    }
//    height += 1
//    height += children.map { getTreeHeight(tree: tree, startNode: $0)}.max() ?? 0
//    return height
//}

//print(getTreeHeight(tree: tree))

class Node {
    var id: Int
    var parent: Node?
    var children: [Node] = []
    
    init(id: Int) {
        self.id = id
    }
    func addChild(_ node: Node) {
        self.children.append(node)
    }
}

func buildTree(undirectedGraph: [Int: [Int]], root: Int) -> Node {
    let children = undirectedGraph[root] ?? []
    
    let rootNode = Node(id: root)
    for child in children {
        if child != root {
            rootNode.addChild(buildTree(undirectedGraph: undirectedGraph, root: child))
        }
    }
    return rootNode
}

// print(buildTree(undirectedGraph: tree, root: 0))

func getDegrees(tree: [Int: [Int]], startNode: Int = 0, degrees: inout [Int: Int], parent: Int? = nil){
    let children = tree[startNode] ?? []
    degrees[startNode] = (degrees[startNode] ?? 0) + children.count

    for child in children {
        guard child != parent else {
            continue
        }
        getDegrees(tree: tree, startNode: child, degrees: &degrees, parent: startNode)
    }
}
//
//var degrees: [Int: Int] = [:]

// getDegrees(tree: tree, degrees: &degrees)
// print(degrees)

var undirectedTree = [
    0: [1,2],
    1: [0,3,4],
    2: [0,5,6],
    3: [1,7,8],
    4: [1,9,10],
    5: [2,11,12],
    6: [2,13,14],
    7: [3,15],
    8: [3, 16],
    9: [4],
    10: [4],
    11: [5],
    12: [5],
    13: [6],
    14: [6],
    15: [7],
    16: [8]
]

func rootTree(tree: [Int: [Int]], root: Int, parent: Int?, rootedTree: inout [Int: [Int]]) -> [Int: [Int]] {
    let children = tree[root] ?? []
    for child in children {
        if parent == child {
            continue
        }
        rootedTree[root] = (rootedTree[root] ?? []) + [child]
        rootTree(tree: tree, root: child, parent: root, rootedTree: &rootedTree)
    }
    return rootedTree
}

var rootedTree = [Int: [Int]]()

rootTree(tree: undirectedTree, root: 1, parent: nil, rootedTree: &rootedTree)

print(rootedTree)

var degrees: [Int: Int] = [:]
getDegrees(tree: undirectedTree, degrees: &degrees)
print(degrees)

func getTreeCenters(tree: [Int: [Int]]) -> [Int] {
    var degrees = [Int: Int]()
    getDegrees(tree: tree, degrees: &degrees)
    print(degrees)
    var leaves: [Int] = []

    // initialize the first rounds of leaves
    for node in degrees.keys {
        if degrees[node] == 0 || // is single-node tree
            degrees[node] == 1 {// is leaf
            degrees[node] = 0
            leaves.append(node)
        }
    }
    
    var count = leaves.count
    var iterations = 0
    print("total nodes: \(degrees.keys.count)")
    while count < degrees.keys.count {
        print("=============")
        print("leaves: \(leaves)")
        print("count: \(count)")
        print("degrees: \(degrees)")

        var nextLeaves = [Int]()
        
        for leaf in leaves {
            for leafNeighbour in tree[leaf] ?? [] {
                degrees[leafNeighbour] = (degrees[leafNeighbour] ?? 0) - 1
                if degrees[leafNeighbour] == 1 {
                    nextLeaves.append(leafNeighbour)
                }
            }
            degrees[leaf] = 0 // set to 0 so we don't process this leaf again.
        }
        count += nextLeaves.count
        leaves = nextLeaves
        iterations += 1
    }
    print("iterations: \(iterations)")
    return leaves
}

print(getTreeCenters(tree: undirectedTree))
    

func encodeTree(tree: [Int: [Int]], startNode: Int = 0) -> String {
    var result = "("
    let children = tree[startNode] ?? []
    for child in children.sorted() {
        result += encodeTree(tree: tree, startNode: child)
    }
    result += ")"
    return result
    
}
print("encoded tree: \(encodeTree(tree: tree))")

func areTreesIsomorphic(tree1: [Int: [Int]], tree2: [Int: [Int]]) -> Bool {
    let tree1Centers = getTreeCenters(tree: tree1)
    let tree2Centers = getTreeCenters(tree: tree2)
    
    var rootedTree1 = [Int: [Int]]()
    rootTree(tree: tree1, root: tree1Centers[0], parent: nil, rootedTree: &rootedTree1)
    let encodedTree1 = encodeTree(tree: rootedTree1)
    
    for center in tree2Centers {
        var rootedTree2 = [Int: [Int]]()
        rootTree(tree: tree2, root: center, parent: nil, rootedTree: &rootedTree2)
        let encodedTree2 = encodeTree(tree: rootedTree2)
        if encodedTree1 == encodedTree2 {
            return true
        }
    }
    return false
}

func dfsHelper(tree: [Int: [Int]], root: Int) -> [Int] {
    let children = tree[root] ?? []
    var sorted = [root]
    for child in children {
        sorted.append(contentsOf: dfsHelper(tree: tree, root: child))
    }
    return sorted
}

let x = Double.infinity
