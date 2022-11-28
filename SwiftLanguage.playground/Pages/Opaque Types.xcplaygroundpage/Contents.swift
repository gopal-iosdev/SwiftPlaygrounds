//: [Previous](@previous)

/*
Source:
 - https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html

 NOTE:
 -
 
 - OpaqueTypes:
    - A function or method with an opaque return type hides its return value’s type information.
    - Instead of providing a concrete type as the function’s return type, the return value is described in terms of the protocols it supports.
    - Unlike returning a value whose type is a protocol type, opaque types preserve type identity—the compiler has access to the type information, but clients of the module don’t.
    - You can think of an opaque type like being the reverse of a generic type.
    - Generic types let the code that calls a function pick the type for that function’s parameters and return value in a way that’s abstracted away from the function implementation.
    - An opaque type lets the function implementation pick the type for the value it returns in a way that’s abstracted away from the code that calls the function.
    - Differences Between Opaque Types and Protocol Types:
        - Returning an opaque type looks very similar to using a protocol type as the return type of a function, but these two kinds of return type differ in whether they preserve type identity.
        - An opaque type refers to one specific type, although the caller of the function isn’t able to see which type; a protocol type can refer to any type that conforms to the protocol.
        - Generally speaking, protocol types give you more flexibility about the underlying types of the values they store, and opaque types let you make stronger guarantees about those underlying types.
        - Using a protocol type as the return type for a function gives you the flexibility to return any type that conforms to the protocol. However, the cost of that flexibility is that some operations aren’t possible on the returned values.
        - In contrast, opaque types preserve the identity of the under lying type. Swift can infer associated types, which lets you use an opaque return value in places where a protocol type can’t be used as a return value.
 */

import Foundation

// MARK: - Opaque Types

/*

protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangles.draw())

struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 2)
    let middle = Square(size: 2)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}
let trapezoid = makeTrapezoid()
print(trapezoid.draw())

func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}

let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print(opaqueJoinedTriangles.draw())

struct FlippedShape2<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        if shape is Square {
            return shape.draw()
        }
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}

func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
    return Array<T>(repeating: shape, count: count)
}

*/

// MARK: Differences Between Opaque Types and Protocol Types

/*

func protoFlip<T: Shape>(_ shape: T) -> Shape {
    return FlippedShape(shape: shape)
}

func protoFlip2<T: Shape>(_ shape: T) -> Shape {
    if shape is Square {
        return shape
    }

    return FlippedShape(shape: shape)
}

let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
//protoFlippedTriangle == sameThing // Error

protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
extension Array: Container { }

//func makeProtocolContainer<T>(item: T) -> Container {
//    return [item]
//}
//
//func makeProtocolContainer<T, C: Container>(item: T) -> C {
//    return [item]
//}

func makeOpaqueContainer2<T>(item: T) -> some Container {
    return [item]
}
let opaqueContainer = makeOpaqueContainer2(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))
 
*/

//: [Next](@next)
