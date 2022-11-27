//: [Previous](@previous)

/*
Source:
 - https://www.youtube.com/watch?v=y4qFRLp_JNM&ab_channel=PaulHudson
 -
 - https://docs.swift.org/swift-book/LanguageGuide/Generics.html

 NOTE:
 - Generics are great when we want to model a concept for multiple cases.
 - The goal of deploying generics should be to make our top level code simpler, not harder, or more complicated.
 - When used in right situations genercis can be super powerful, and lets us reuse code & concepts through shared abstractions.
 - Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they’re a placeholder for a type, not a value.
 
 - Generics:
    - Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define.
    - You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.
    - Generics are one of the most powerful features of Swift, and much of the Swift standard library is built with generic code.
        - For example, Swift’s Array and Dictionary types are both generic collections.
    - Naming Types:
        - In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value> and Element in Array<Element>, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in.
        - However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V, such as T in the swapTwoValues(_:_:) function above.
    - Generic Types:
        - In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
        - Extending a Generic Type:
            - When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. Instead, the type parameter list from the original type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.
 
        - Type Constraints:
            - Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
            - For example, Swift’s Dictionary type places a limitation on the types that can be used as keys for a dictionary. As described in Dictionaries, the type of a dictionary’s keys must be hashable.
 
        - Associated Types:
            - When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition.
            - An associated type gives a placeholder name to a type that’s used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted.
            - Associated types are specified with the associatedtype keyword.
            - You can add type constraints to an associated type in a protocol to require that conforming types satisfy those constraints.
            - A protocol can appear as part of its own requirements.
 
    - Generic Where Clauses:
        - Type constraints, as described in Type Constraints, enable you to define requirements on the type parameters associated with a generic function, subscript, or type.
        - It can also be useful to define requirements for associated types. You do this by defining a generic where clause.
        - A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
        - A generic where clause starts with the where keyword, followed by constraints for associated types or equality relationships between types and associated types.
        - You write a generic where clause right before the opening curly brace of a type or function’s body.
 
    - Extensions with a Generic Where Clause:
        - You can also use a generic where clause as part of an extension.
        - You can also write a generic where clauses that require Item to be a specific type.
 
    - Contextual Where Clauses:
        - You can write a generic where clause as part of a declaration that doesn’t have its own generic type constraints, when you’re already working in the context of generic types.
 
    - Generic Subscripts:
        - Subscripts can be generic, and they can include generic where clauses. You write the placeholder type name inside angle brackets after subscript, and you write a generic where clause right before the opening curly brace of the subscript’s body.
    
 */

import Foundation

// MARK: - Generics

/*

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = 10
var b = 20

swapTwoInts(&a, &b)

print(a, b)

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// Generic One Type

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

swap(&a, &b)

print(a, b)

// Generic Two Type

func printTwoTypesValues<A, B>(_ a: A, _ b: B) {
    print(a)
    print(b)
}

var strA = "Hello"
var intB = 10

printTwoTypesValues(strA, 10)

 */

// MARK: Generic Types

/*
struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

print(stackOfStrings)

print(stackOfStrings.pop())
*/

// MARK: Extending a Generic Type

/*
extension Stack {
    var topItem: Element? {
        items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
*/
 
// MARK: Type Constraints in Action

/*
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])

let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
*/

// MARK: Associated Types in Action

/*
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack2: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack2<Element>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

protocol Container2 {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct Stack3<Element: Equatable>: Container2 {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack2: SuffixableContainer {
    func suffix(_ size: Int) -> Stack2 {
        var result = Stack2()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
var stackOfInts = Stack2<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)

extension IntStack2: SuffixableContainer {
    func suffix(_ size: Int) -> Stack2<Int> {
        var result = Stack2<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack<Int>.
}
 
 */

// MARK: Generic Where Clauses

/*
extension Array: Container { }

func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {

        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }

        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // All items match, so return true.
        return true
}

var stackOfStrings2 = Stack2<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
 */

// MARK: Extensions with a Generic Where Clause

/*
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())

 */
 
// MARK: Contextual Where Clauses

/*

extension Container {
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]
print(numbers.average())
print(numbers.endsWith(37))

 */
 
// MARK: Associated Types with a Generic Where Clause

/*

protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }

    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComparableContainer: Container3 where Item: Comparable { }

 */

// MARK: Generic Subscripts

/*

extension Container3 {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
    where Indices.Iterator.Element == Int {
        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

*/

//: [Next](@next)
