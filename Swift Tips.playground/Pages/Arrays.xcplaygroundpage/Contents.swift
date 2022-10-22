//: [Previous](@previous)

import Foundation

// MARK: How to remove nil elements from an array in Swift

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


//: [Next](@next)
