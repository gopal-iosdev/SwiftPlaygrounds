import UIKit

// MARK: - Swift Tips #35 - reduce

// reduce can replace for loop

let numbers = [1, 2, 3, 4, 5]

var sum = 0

for number in numbers { sum += number }

//print(sum)

// using reduce:

let reduceSum = numbers.reduce(0) { partialResult, nextValue in return (partialResult + nextValue) }

//print(reduceSum)

let reduceSumPlus = numbers.reduce(0, +)

print(reduceSumPlus)

let reduceFindMaxNumber = numbers.reduce(Int.min) { currentMax, nextValue in
    return currentMax > nextValue ? currentMax : nextValue
}

//print(reduceFindMaxNumber)

// using reduce(into:)

let letters = "abracadabra"

let letterCount = letters.reduce(into: [:]) { counts, letter in
    counts[letter, default: 0] += 1
}

//print(letterCount)

struct Product {
    let isYearly: Bool
}
var product: Product? = nil//Product(isYearly: false)
var testDuration = (product?.isYearly ?? false) ? "annual" : "monthly"

//print(testDuration)

if let product = product {
    testDuration = "duration"//product.duration
}
//print(testDuration)

enum EpicPromoType {
    case none
    case oneDollarPromo
    case bts
    
    static func current() -> EpicPromoType {
        return .none
    }
}


enum DebugProperties: String, CaseIterable {
    case deviceId = "Device UUID", consumerFlowType = "Consumer Flow Type", promoType = "Promo Type"
    
    static var allCases: [DebugProperties] {
        var validCases: [DebugProperties] = [.deviceId, .consumerFlowType]
        
        print(validCases)
        
        guard EpicPromoType.current() != .none
        else {
            return validCases
        }
        
        validCases.append(.promoType)
        
        return validCases
    }
    
//    static func validCases() -> [DebugProperties] {
//        var allCases: [DebugProperties] = DebugProperties.allCases
//
//        guard EpicPromoType.current() != .none
//        else {
//            return allCases.filter {
//                return $0 != .promoType
//            }
//        }
//
//        return allCases
//    }
    
    static func validCases() -> [DebugProperties] {
        guard EpicPromoType.current() != .none
        else {
            return DebugProperties.allCases.filter {
                return $0 != .promoType
            }
        }

        return DebugProperties.allCases
    }
}

print(DebugProperties.allCases)
