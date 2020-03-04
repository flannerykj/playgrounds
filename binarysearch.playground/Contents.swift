import UIKit


func _bst(orderedElements: [String], targetElement: String, searchRange: NSRange) -> Int? {
    guard searchRange.length > 0 else { return nil }

    let middleIndex = Int((searchRange.location + (searchRange.length - searchRange.location)/2))
    let middleItem = orderedElements[middleIndex]
    
    if middleItem == targetElement {
        return middleIndex
    }
    if targetElement < middleItem {
        return _bst(orderedElements: orderedElements, targetElement: targetElement, searchRange: NSRange(location: searchRange.location, length: middleIndex - searchRange.location))
    }
    if targetElement > middleItem {
        return _bst(orderedElements: orderedElements, targetElement: targetElement, searchRange: NSRange(location: middleIndex + 1, length: searchRange.length - middleIndex))
    }
    
    return nil
}

func bst(orderedElements: [String], targetElement: String) -> Int? {
    return _bst(orderedElements: orderedElements, targetElement: targetElement, searchRange: NSRange(location: 0, length: orderedElements.count))
}

let orderedList = ["Apple", "Banana", "Canteloupe", "Grapes", "Kiwi", "Mango", "Strawberries"]

print(bst(orderedElements: orderedList, targetElement: "Canteloupe"))



func selectionSort(elements: inout [String]) {
    var firstUnsortedIndex = 0
    
    while firstUnsortedIndex < elements.count {
        var indexOfLowestValue = firstUnsortedIndex
        for i in firstUnsortedIndex..<elements.count{
            if elements[i] < elements[indexOfLowestValue] {
                indexOfLowestValue = i
            }
        }
        let temp = elements[firstUnsortedIndex]
        elements[firstUnsortedIndex] = elements[indexOfLowestValue]
        elements[indexOfLowestValue] = temp
        
        firstUnsortedIndex += 1
    }
}
var unOrderedList = ["Banana", "Strawberries", "Canteloupe", "Apple", "Kiwi", "Grapes", "Mango"]

selectionSort(elements: &unOrderedList)
print(unOrderedList)


func insertionSort(elements: inout [String]) {
    
    var index = 1
    
    while index < elements.count {
        var tempValue = elements[index]
        var emptySlotIndex = index
        for i in (index-1)...0 {
            if elements[i] > tempValue {
                elements[i+1] = elements[i]
            }
        }
        index += 1
    }
    
}
