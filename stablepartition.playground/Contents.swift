import UIKit

var arr = [1,4,3,7,22,40,9,4,5]

extension MutableCollection where Element: Comparable {
    mutating func stablePartition(isSuffixElement: ((Element) -> Bool)) {
        guard self.count > 0 else { return }
        guard var iIndex = firstIndex(where: {
            isSuffixElement($0)
        }) else {
            return
        }
        print("first suffix:")
        print(self[iIndex])
        let start = distance(from: startIndex, to: iIndex) + 1
        print("start: \(start)")
        for var j in start..<self.count {
            print("----------")
            var jIndex = index(startIndex, offsetBy: j)
            print("item at i is \(self[iIndex])")
            print("item at j is \(self[jIndex])")
            if isSuffixElement(self[iIndex]) && !isSuffixElement(self[jIndex]) {
                print("swapping")
                swapAt(iIndex, jIndex)
                formIndex(after: &iIndex)
                formIndex(after: &jIndex)
            } else {
                formIndex(after: &jIndex)
            }
            j = distance(from: startIndex, to: jIndex)
            print(self)
        }
    }
}

arr.stablePartition(isSuffixElement: { $0 % 2 == 1 })
print(arr)
