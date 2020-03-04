import UIKit

var flights: [String: [(String, Int)]] = [
    "Denver": [("New York City", 120),  ("San Francisco", 300), ("Hawaii", 200)],
    "New York City": [("San Francisco", 400), ("Seattle", 300), ("St. Louis", 310), ("Hawaii", 380)],
    "San Francisco": [("Denver", 200), ("New Orleans", 150), ("Austin", 230)],
    "Hawaii": [("Austin", 566)]
]


func getCheapestRoute(fromCity: String, toCity: String) -> ([String], Int)? {
    var toVisit: [([String], Int)] = [] // ( [Stops], CostSoFar)
    var visited: [String] = []
    
    toVisit.append(([fromCity], 0))
    
    var bestOtionSoFar: ([String], Int)?
    
    while let (stopsSoFar, costSoFar) = toVisit.popLast() {
        guard let currentCity = stopsSoFar.last else {
            continue
        }
        if currentCity == toCity {
             // we have another option.
            if let (_, currentBestCost) = bestOtionSoFar, costSoFar < currentBestCost {
                bestOtionSoFar = (stopsSoFar, costSoFar)
                continue
            } else {
                bestOtionSoFar = (stopsSoFar, costSoFar)
                continue
            }
        }
        visited.append(currentCity)
        
        for (nextCity, cost) in flights[currentCity] ?? [] {
            if !visited.contains(nextCity) {
                toVisit.append((stopsSoFar + [nextCity], costSoFar + cost))
            }
        }
    }
    return bestOtionSoFar
}

// print("cost from New York City to Denver: \(getCheapestRoute(fromCity: "New York City", toCity: "Denver"))")


func getCheapestRoute2(fromCity: String, toCity: String) -> Int? {
    
    var costToAnyCity: [String: Int] = [:]
    
    var visited: [String] = []
    var toVisit: [(String, Int)] = [(fromCity, 0)]
    
    while let (city, accumulatedCost) = toVisit.popLast() {
        visited.append(city)
        
        for (nextCity, costOfFlight) in flights[city] ?? [] {
            if !visited.contains(nextCity) {
                let nextAccumulatedCost = accumulatedCost + costOfFlight
                if let existingCost = costToAnyCity[nextCity], existingCost < nextAccumulatedCost {
                    continue
                } else {
                    costToAnyCity[nextCity] = nextAccumulatedCost
                    toVisit.append((nextCity, nextAccumulatedCost))
                }
            }
        }
        
        
    }
    print(costToAnyCity)
    return costToAnyCity[toCity]
}
print("cost from New York City to Denver: \(getCheapestRoute2(fromCity: "New York City", toCity: "Denver"))")
