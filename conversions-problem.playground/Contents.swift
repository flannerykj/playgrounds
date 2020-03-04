import UIKit

typealias ConversionsDict = [String: [(String, Float)]]

var conversions: ConversionsDict = [ // origin unit: (destination unit, conversion)
    "foot": [("metre", 0.3048), ("centimetre", 30.48)],
    "inch": [("foot", 0.0833333), ("hand", 0.25)],
    "metre": [("hand", 9.84252), ("kilometre", 0.001)],
    "centimetre": [("hand", 0.0984252), ("inch", 0.393701), ("metre", 0.01)],
    "kilometre": [("metre", 1000)]
]


func dfs_conversion(startUnit: String, targetUnit: String, origin_rate: Float = 1.0, conversionsDict: ConversionsDict, visited: inout [String]) -> Float? {
    if startUnit == targetUnit {
        return origin_rate
    }
    if !visited.contains(startUnit) {
        visited.append(startUnit)
        let conversions = conversionsDict[startUnit] ?? []
        for conversion in conversions {
            let (toUnit, rate) = conversion
            let res = dfs_conversion(startUnit: toUnit, targetUnit: targetUnit, origin_rate: origin_rate * rate, conversionsDict: conversionsDict, visited: &visited)
            if res != nil {
                return res
            }
        }
    }
    return nil
}


func bfs_conversion(startUnit: String, targetUnit: String, origin_rate: Float = 1.0, conversionsDict: ConversionsDict) -> Float? {
    var visited = [String]()
    var toVisit = [(String, Float)]()
    toVisit.append((startUnit, origin_rate))
    
    while toVisit.count > 0 {
        let (unit, rate) = toVisit.popLast()!
        if unit == targetUnit { return rate }
        if visited.contains(unit) { continue }
        visited.append(unit)
        
        for conversion in (conversionsDict[unit] ?? []) {
            let (nextUnit, nextRate) = conversion
            toVisit.append((nextUnit, rate * nextRate))
        }
    }
    return nil
}

var visited = [String]()
let res = dfs_conversion(startUnit: "inch", targetUnit: "kilometre", conversionsDict: conversions, visited: &visited)
let bfSRes = bfs_conversion(startUnit: "inch", targetUnit: "kilometre", conversionsDict: conversions)

print("RESULT: \(res)")


func makeConversions(startUnit: String, conversionsDict: ConversionsDict, conversions: inout [String: (String, Float)]) {
    var toVisit = [(String, Float)]()
    toVisit.append((startUnit, 1.0))
    while toVisit.count > 0 {
        let (unit, rate) = toVisit.popLast()!
        if conversions[unit] != nil {
            continue
        }
        conversions[unit] = (startUnit, rate)
        for conversion in (conversionsDict[unit] ?? []) {
            let (nextUnit, nextRate) = conversion
            toVisit.insert((nextUnit, rate * nextRate), at: 0)
        }
    }
}

var conversionsCache: [String: (String, Float)] = [:]

for unit in conversions.keys {
    if conversionsCache[unit] == nil {
        print("making conversions for \(unit)")
        makeConversions(startUnit: unit, conversionsDict: conversions, conversions: &conversionsCache)
    }
}

print(conversionsCache)

func convert(startUnit: String, targetUnit: String, conversionsCache: [String: (String, Float)]) -> Float? {
    if startUnit == targetUnit { return 1 }
    guard let startUnitEntry = conversionsCache[startUnit] else { return nil  }
    guard let targetUnitEntry = conversionsCache[targetUnit] else { return nil  }
    
    let (startRoot, startRateToRoot) = startUnitEntry
    let (targetRoot, targetRateToRoot) = targetUnitEntry
    
    guard startRoot == targetRoot else { return nil }
    return targetRateToRoot/startRateToRoot
}

let res3 = convert(startUnit: "inch", targetUnit: "metre", conversionsCache: conversionsCache)
print(res3)
