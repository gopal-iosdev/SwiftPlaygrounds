//: [Previous](@previous)

/*
 Source:
    -
 
 - Filter:
    - Applies filter on an entire collection.
    - Filter a list based on a condition.
    - Returns a filtered list.
 
 - Map:
    - Applies transformation on entire collection.
    - Maps one list to another.
    - Returns a mapped list.
    -
 
 - Reduce:
    - Takes every element in a collection and aggregate it into some sort of collection.
    - Combine/ Sum up all the prices into one.
    - Returns a single/ reduced value.
    -
 
 - Keypath:
    - Is a generic type with 2 generic arguments.
    - arg1 => Root: Type on which we will invoke the keypath.
    - arg2 => Value: Type of the property the keypath refers to.
    - Syntax: (Root) -> Value => Takes Root & Returns Value.
 
 
 NOTE:
 
 
 */

import Foundation

// MARK: MAP

let intArr = [1, 3, 4, 6, 9]

let intDescArr = intArr.map({ $0.description + "t" })

let intDescKeyPathArr = intArr.map(\.description)

print(intArr, "\n", intDescArr, "\n", intDescKeyPathArr)

print(intDescArr == intDescKeyPathArr)

// MARK: FILTER

let evenArr = intArr.filter({ $0 % 2 == 0 })
print(evenArr)


// MARK: REDUCE

let sumOfElements = intArr.reduce(0) { partialResult, nextNum in
    partialResult + nextNum
}

let sum = intArr.reduce(0, +)

print(sumOfElements, sum)


// Reduce Into

// get max val in an array

let maxVal = intArr.reduce(into: Int.min) { currentMaxVal, nextNum in
    currentMaxVal = (currentMaxVal > nextNum) ? currentMaxVal : nextNum
}

print(maxVal)

// reduce to a dict

let intDict = intArr.reduce(into: [:]) { partialResult, nextNum in
    partialResult[nextNum.description] = nextNum
}

print(intDict)

let str = "abcaabbccdefedef"
let countsDict = Array(str).reduce(into: [:]) { countsDict, char in
    countsDict[char, default: 0] += 1
}

print(countsDict)

var strIntAr = intArr.map({ $0.description })
strIntAr.append("x")
strIntAr.append("12")
strIntAr.append("13x")
strIntAr.append("14")

print(strIntAr)

let mappedIntArr = strIntAr.map({ Int($0) })
let compactMappedIntArr = strIntAr.compactMap({ Int($0) })

print(mappedIntArr)
print(compactMappedIntArr)

let arrayOfInts = [[1, 3, 7], [2, 6, 3], [2, 10, 4, 1]]
let evenNums = arrayOfInts.flatMap({ $0.filter( { $0 % 2 == 0 } ) })
print(evenNums)

let countsArrDict = arrayOfInts.reduce(into: [:]) { countsDict, arr in
    arr.forEach { num in
        countsDict[num, default: 0] += 1
    }
}

print(countsArrDict)

let newDict = countsArrDict.lazy.sorted { $0.key > $1.key
}

print(newDict)


//: [Next](@next)
