//: [Previous](@previous)

import Foundation

/*
 - Zip():
    - Src: https://www.youtube.com/watch?v=SSSQDygQPO4&list=PLdXMqVQnoFleH3GSuTUpr3Fjzp1JMy-je&index=18&ab_channel=VincentPradeilles
    - Enables us to iterate over multiple collections at the same time.
 */

// MARK: How to remove nil elements from an array in Swift

/*

let optionalNumbers: [String?] = ["1", "2", nil, "3", "four"]
let nonOptionalNumbers = optionalNumbers.compactMap { $0 }

print(nonOptionalNumbers)

let nonOptionalInts = optionalNumbers.compactMap { numberString in
    if let numberString {
        // 1
        return Int(numberString)
    } else {
        return nil
    }
}
print(nonOptionalInts)
*/

// MARK: Zip()

/*

let intArr = [1, 3, 5, 7, 9, 11]
let strArr = ["Hello", "Hi", "Hey", "Yooo"]

// How to map both arrays
for i in 0..<min(intArr.count, strArr.count) {
    print(strArr[i], intArr[i])
}

// Using Zip

for element in zip(intArr, strArr) {
    print(element)
}

 */

//: [Next](@next)
