//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
 
 NOTE:
    - Swift enumeration cases don’t have an integer value set by default, unlike languages like C and Objective-C. In the CompassPoint example above, north, south, east and west don’t implicitly equal 0, 1, 2 and 3. Instead, the different enumeration cases are values in their own right, with an explicitly defined type of CompassPoint.
    - CaseIterable:
        - To iterate over enum cases.
    - Associated Values:
        - Associating a value to enum case.
        - Example: case qrCode(String)
    - Raw Values:
        - The raw value initializer is a failable initializer, because not every raw value will return an enumeration case.
    - Recursive Enumerations:
        - A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases.
 
 - Enumerations:
    - An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
    - Enumerations in Swift are first-class types in their own right.

 - Iterating over Enumeration Cases:
    - For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type.

 - Associated Values:
    - This additional information attached to a enum is called an associated value, and it varies each time you use that case as a value in your code.
        Example:
             enum Barcode {
                 case upc(Int, Int, Int, Int)
                 case qrCode(String)
             }
 
 - Raw Values:
    - cases can come prepopulated with default values (called raw values), which are all of the same type.
 - Implicitly Assigned Raw Values:
    - When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift automatically assigns the values for you.
 
 - Recursive Enumerations:
    - A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases.
    - You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.
    - Example:
         enum ArithmeticExpression {
             case number(Int)
             indirect case addition(ArithmeticExpression, ArithmeticExpression)
             indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
         }
 
 */

import Foundation

/*

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west

var planet = Planet.earth

print("We need to head \(directionToHead) on planet \(planet)")

switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}


let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

// MARK: Iterating over Enumeration Cases

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

Beverage.allCases.map { print($0) }

// MARK: Associated Values

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

print(productBarcode)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

print(productBarcode)

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(var productCode):
    productCode += "STUVWXYZ"
    print("QR code: \(productCode).")
}


switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
 
 */

// MARK: Raw Values

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// MARK: Implicitly Assigned Raw Values

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoint: String {
    case north, south, east, west
}

let earthsOrder = Planet.earth.rawValue

let sunsetDirection = CompassPoint.west.rawValue

print(earthsOrder, sunsetDirection)

let direction = CompassPoint(rawValue: "south")

print(direction?.rawValue)

let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

// MARK: Recursive Enumerations

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

func evaluate2(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate2(left) + evaluate2(right)
    case let .multiplication(left, right):
        return evaluate2(left) * evaluate2(right)
    }
}

print(evaluate(product))

print(evaluate2(product))

//: [Next](@next)
