import UIKit


func binarySearch<T: Comparable>(in array: [T], for target: T, searchRange: NSRange) -> Int? {
    if searchRange.lowerBound > searchRange.upperBound {
        // item not found in array
        return nil
    }
    let midIndex = Int(searchRange.lowerBound + (searchRange.upperBound - searchRange.lowerBound)/2)

    if array[midIndex] < target {
        // search upper half of array
        
    } else if array[midIndex] > target {
        // search lower half
    } else {
        // target equal to item at midIndex
        return midIndex
    }
}
