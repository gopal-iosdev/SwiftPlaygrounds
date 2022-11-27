//: [Previous](@previous)

/*
Source: https://docs.swift.org/swift-book/LanguageGuide/Protocols.html

 NOTE:
 - If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma
 - Swift reports an error at compile time if a protocol requirement isn’t fulfilled.
 - If you mark a protocol instance method requirement as mutating, you don’t need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.
 - Because protocols are types, begin their names with a capital letter (such as FullyNamed and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String, and Double).
 - To prevent strong reference cycles, delegates are declared as weak references.
 - Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance’s type in an extension.
 - Types don’t automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.
 - Use a class-only protocol when the behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics.
 - Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
 - Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.
 - If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift uses the implementation corresponding to the most specialized constraints.
 
 - Protocols:
    - A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
    - The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements.
    - Property Requirements:
        - The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type.
        - The protocol also specifies whether each property must be gettable or gettable and settable.
        - If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property.
        - Property requirements are always declared as variable properties, prefixed with the var keyword.
        - Always prefix type property requirements with the static keyword when you define them in a protocol.
        
    - Method Requirements:
        - Variadic parameters are allowed, subject to the same rules as for normal methods.
            - Variadic parameters make it possible to pass zero or more values of a specific type into a function.
            - A Variadic Parameter is defined using a value type followed by 3 dots, for example:
                 mutating func add(_ newContent: Content...) {
                     content.append(contentsOf: newContent)
                 }
        - Default values, however, can’t be specified for method parameters within a protocol’s definition.
        - As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class.
        
    - Mutating Method Requirements:
        - If you define a protocol instance method requirement that’s intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition.
        
    - Initializer Requirements:
        - Protocols can require specific initializers to be implemented by conforming types. You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body.
        - You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier.
        - You don’t need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes can’t subclassed.
        - If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the required and override modifiers.
        
    - Protocols as Types:
        - Protocols don’t actually implement any functionality themselves. Nonetheless, you can use protocols as a fully fledged types in your code.
        - You can use a protocol in many places where other types are allowed, including:
            - As a parameter type or return type in a function, method, or initializer.
            - As the type of a constant, variable, or property.
            - As the type of items in an array, dictionary, or other container
        
    - Delegation:
        - Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type.
    - Adopting a Protocol Using a Synthesized Implementation:
        - Swift can automatically provide the protocol conformance for Equatable, Hashable, and Comparable in many simple cases. Using this synthesized implementation means you don’t have to write repetitive boilerplate code to implement the protocol requirements yourself.
        - Equatable, Hashable & Comparable.
        - Swift provides a synthesized implementation of Equatable for the following kinds of custom types:
            - Structures that have only stored properties that conform to the Equatable protocol.
            - Enumerations that have only associated types that conform to the Equatable protocol
            - Enumerations that have no associated types
        - Swift provides a synthesized implementation of Hashable for the following kinds of custom types:
            - Structures that have only stored properties that conform to the Hashable protocol
            - Enumerations that have only associated types that conform to the Hashable protocol
            - Enumerations that have no associated types
 
    - Protocol Inheritance:
        - A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits.
        
    - Class-Only Protocols:
        - You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list.
    - Protocol Composition:
        - It can be useful to require a type to conform to multiple protocols at the same time. You can combine multiple protocols into a single requirement with a protocol composition.
        - Protocol compositions don’t define any new protocol types.
        - Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols as you need, separating them with ampersands (&).
        
    - Checking for Protocol Conformance:
        - You can use the is and as operators described in Type Casting to check for protocol conformance, and to cast to a specific protocol.
        - Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:
            - The is operator returns true if an instance conforms to a protocol and returns false if it doesn’t.
            - The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance doesn’t conform to that protocol.
            - The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast doesn’t succeed.
        
    - Optional Protocol Requirements:
        - You can define optional requirements for protocols. These requirements don’t have to be implemented by types that conform to the protocol.
        - Optional requirements are prefixed by the optional modifier as part of the protocol’s definition.
        - Optional requirements are available so that you can write code that interoperates with Objective-C. Both the protocol and the optional requirement must be marked with the @objc attribute.
        - When you use a method or property in an optional requirement, its type automatically becomes an optional.
        
    - Protocol Extensions:
        - Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types.
        - This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
        - Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol. Protocol inheritance is always specified in the protocol declaration itself.
        
    - Adding Constraints to Protocol Extensions:
        - When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available.
        - You write these constraints after the name of the protocol you’re extending by writing a generic where clause.
 
 */

import UIKit

// MARK: - Protocols

// MARK: Property Requirements

/*

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

print(ncc1701.fullName)
 
 */

// MARK: Method Requirements

/*

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")

print("And another one: \(generator.random())")
*/

// MARK: Mutating Method Requirements

/*

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

 */

// MARK: Initializer Requirements

/*
protocol SomeProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
 */

// MARK: Protocols as Types

/*

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

 */

// MARK: Delegation

/*
 
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    weak var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)
 
 */

// MARK: Conditionally Conforming to a Protocol

/*

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)

*/

// MARK: Declaring Protocol Adoption with an Extension

/*

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
 
 */

// MARK: Adopting a Protocol Using a Synthesized Implementation

/*

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}

 */

// MARK: Protcol Composition

/*

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

*/

// MARK: Checking for Protocol Conformance

/*
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
*/

// MARK: Optional Protocol Requirements

/*

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
 
 */

// MARK: Protocol Extensions

/*
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true"
*/

// MARK: Adding Constraints to Protocol Extensions

/*
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())

print(differentNumbers.allEqual())
 */


//: [Next](@next)
