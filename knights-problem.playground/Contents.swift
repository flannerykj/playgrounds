import UIKit

var knightKeypadGraph: [Int: [Int]] = [
    1: [8,6],
    2: [7,9],
    3: [4,8],
    4: [3,9,0],
    6: [1, 7, 0],
    7: [2, 6],
    8: [1, 3],
    9: [2, 4],
    0: [4, 6]
]

//func getDistinctNumbers(inNumberOfHops hops: Int, startingAt startNumber: Int, sequenceSoFar: [Int], allSequences: inout [[Int]]) {
//    var updatedSequence = sequenceSoFar
//    if sequenceSoFar.count == 0 {
//        updatedSequence.append(startNumber)
//    }
//    if hops == 0 {
//        allSequences.append(sequenceSoFar)
//        return
//    }
//    let neighbours = knightKeypadGraph[startNumber] ?? []
//    for neighbour in neighbours {
//        getDistinctNumbers(inNumberOfHops: hops - 1, startingAt: neighbour, sequenceSoFar: updatedSequence + [neighbour], allSequences: &allSequences)
//    }
//}
//
//var allSequences = [[Int]]()
//getDistinctNumbers(inNumberOfHops: 8, startingAt: 3, sequenceSoFar: [], allSequences: &allSequences)
//print("all sequences count: \(allSequences.count)")
//

struct CacheKey: Hashable {
    var startingNumber: Int
    var numberOfHops: Int
}

func countDistinctNumbers(inNumberOfHops hops: Int, startingAt startNumber: Int) -> Int {
    let neighbours = knightKeypadGraph[startNumber] ?? []
    if hops == 1 {
        return neighbours.count
    } else {
        return neighbours.map {
            countDistinctNumbers(inNumberOfHops: hops - 1, startingAt: $0)
        }.reduce(0, +)
    }
}
//let disinctNumbers = countDistinctNumbers(inNumberOfHops: 8, startingAt: 3)
//print("distinctSquences count: \(disinctNumbers)")


// with memoization

func countDistinct(inNumberOfHops hops: Int, startingAt startNumber: Int, cache: inout [CacheKey: Int]) -> Int {
    let cacheKey = CacheKey(startingNumber: startNumber, numberOfHops: hops)
    if let cachedSum = cache[cacheKey] {
        return cachedSum
    }
    let neighbours = knightKeypadGraph[startNumber] ?? []
    if hops == 1 {
        return neighbours.count
    }
    return neighbours.map {
        let sum = countDistinct(inNumberOfHops: hops - 1, startingAt: $0, cache: &cache)
        cache[CacheKey(startingNumber: $0, numberOfHops: hops - 1)] = sum
        return sum
    }.reduce(0, +)
}

//var cache = [CacheKey:Int]()
//let disinctNumbers = countDistinct(inNumberOfHops: 18, startingAt: 3, cache: &cache)
//print("distinctSquences count: \(disinctNumbers)")
//print(cache.keys.count)


func inductiveCountDistinct(inNumberOfHops hops: Int, startingAt startNumber: Int) -> Int {
    var currentCase = Array(repeating: 0, count: 10)
    var priorCase = Array(repeating: 1, count: 10)
    var currentHop = 0
    
    while currentHop < hops {
        currentHop += 1
        currentCase = Array(repeating: 0, count: 10)
        print("current hop: \(currentHop)")
        print("sums so far: \(currentCase)")
        for i in 0..<10 {
            let neighbours = knightKeypadGraph[i] ?? []
            currentCase[i] = neighbours.map { priorCase[$0] }.reduce(0, +)
        }
        priorCase = currentCase
    }
    
    return currentCase[startNumber]
}
print(inductiveCountDistinct(inNumberOfHops: 8, startingAt: 3))
