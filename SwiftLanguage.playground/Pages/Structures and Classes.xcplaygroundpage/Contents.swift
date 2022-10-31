//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html
     https://developer.apple.com/documentation/swift/choosing-between-structures-and-classes
 
 NOTE:
    - Classes - Value Types, Example: Share Google Doc
    - Structs - Value Types, Example: Share Excel Sheet
    - Use structures by default.
    - Use classes when you need Objective-C interoperability.
    - Use classes when you need to control the identity of the data you’re modeling.
    - Use structures along with protocols to adopt behavior by sharing implementations.
        - Examples:
            - Common use cases are file handles, network connections, and shared hardware intermediaries like CBCentralManager.
    - Classes have additional capabilities that structures don’t have:
         - Inheritance.
         - Type casting.
         - Deinitializers.
         - Reference counting allows more than one reference to a class instance.
    - Stored properties are constants or variables that are bundled up and stored as part of the structure or class.
    - Unlike other programming languages, Swift doesn’t require you to create separate interface and implementation files for custom structures and classes.
    - An instance of a class is traditionally known as an object. However, Swift structures and classes are much closer in functionality than in other languages.
    - Classes and actors share many of the same characteristics and behaviors.
    - Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. The behavior you see in your code is always as if a copy took place immediately.
    

 
 - Structures and Classes:
    - Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code.
 
 - Identity Operators:
    - Finding if multiple constants and variables to refer to the same single instance of a class behind the scenes.
    - Two types:
         - Identical to (===)
         - Not identical to (!==)
 
 */


import Foundation

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")

print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// MARK: Identity Operators

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}


//: [Next](@next)
