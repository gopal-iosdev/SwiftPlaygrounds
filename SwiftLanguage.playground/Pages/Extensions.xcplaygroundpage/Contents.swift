//: [Previous](@previous)

/*
Source: https://docs.swift.org/swift-book/LanguageGuide/Extensions.html

 NOTE:
 - Extensions can add new functionality to a type, but they can’t override existing functionality.
 - If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 - Extensions can add new computed properties, but they can’t add stored properties, or add property observers to existing properties.
 - If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.
 

 - Extensions:
    - Lets you add functionality to any type, inclluding the types we made & Apple own types.
    - Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
    - Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions don’t have names.)
    - Extensions in Swift can:
        - Add computed instance properties and computed type properties
        - Define instance methods and type methods
        - Provide new initializers
        - Define subscripts
        - Define and use new nested types
        - Make an existing type conform to a protocol
    - Extensions can add new initializers to existing types.
    - Extensions can add new convenience initializers to a class, but they can’t add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
 
 - Subscripts:
    - Extensions can add new subscripts to an existing type.
    - This subscript [n] returns the decimal digit n places in from the right of the number.
    - If the Int value doesn’t have enough digits for the requested index, the subscript implementation returns 0, as if the number had been padded with zeros to the left
 
 */

import Foundation

// MARK: - Extensions

// MARK: Computed Properties

/*

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello")
}

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
print(someInt)

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

746381295[0]

746381295[1]

746381295[2]

746381295[8]

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])

extension Numeric {
    mutating func squared() -> Self {
        self * self
    }
}

var intNum = 3
var doubleNum = 3.0

print(intNum.squared())
print(doubleNum.squared())

*/

//: [Next](@next)
