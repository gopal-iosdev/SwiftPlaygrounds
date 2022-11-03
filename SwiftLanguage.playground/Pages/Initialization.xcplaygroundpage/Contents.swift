//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Initialization.html
 
 NOTE:
    - Unlike Objective-C initializers, Swift initializers don’t return a value.
    - When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
    - If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance, as described later in this chapter.
    - For class instances, a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.
    - Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers.
    - If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.
    - types of Initializers:
        - designated initializers:
            - primary initializers for a class.
            - A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
            - Classes tend to have very few designated initializers, and it’s quite common for a class to have only one.
            - Designated initializers must always delegate up.
            - You always write the override modifier when overriding a superclass designated initializer
        - Convenience initializers:
            - Secondary, supporting initializers for a class.
            - convenience modifier placed before the init keyword.
            - Convenience initializers must always delegate across.
            - You don't write the override modifier when overriding a superclass convenience initializer
        - Required Initializers:
            - @required.
        - Failable
            - init?()
        - init! Failable Initializer:
            - init!()
    - Swift’s two-phase initialization process is similar to initialization in Objective-C. The main difference is that during phase 1, Objective-C assigns zero or null values (such as 0 or nil) to every property. Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which 0 or nil isn’t a valid default value.
    - A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
    - A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
    - A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
    - An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
    - Superclass initializers are inherited in certain circumstances, but only when it’s safe and appropriate to do so.
    - You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.
    - Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties.
    - A subclass can implement a superclass designated initializer as a subclass convenience initializer.
    - You can’t define a failable and a nonfailable initializer with the same parameter types and names.
    - Strictly speaking, initializers don’t return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends. Although you write return nil to trigger an initialization failure, you don’t use the return keyword to indicate initialization success.
    - Enumerations with raw values automatically receive a failable initializer, init?(rawValue:)
    - A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.
    - You can override a failable initializer with a nonfailable initializer but not the other way around.
    - You don’t write the override modifier when overriding a required designated initializer.
    - You don’t have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.
    - If you use a closure to initialize a property, remember that the rest of the instance hasn’t yet been initialized at the point that the closure is executed. This means that you can’t access any other property values from within your closure, even if those properties have default values. You also can’t use the implicit self property, or call any of the instance’s methods.
 
 - Initialization:
    - Initialization is the process of preparing an instance of a class, structure, or enumeration for use.
    - Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated.
 
 - Initializers:
    - Initializers are called to create a new instance of a particular type.
 
 
 - Initializer delegation:
    - Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.
    - Value types (structures and enumerations) don’t support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes, as described in Inheritance. This means that classes have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization.
 
 - Two-Phase Initialization:
    - Class initialization in Swift is a two-phase process:
        - Phase 1: each stored property is assigned an initial value by the class that introduced it.
        - Phase 2:  each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
 
    - Two-phase initialization prevents property values from being accessed before they’re initialized, and prevents property values from being set to a different value by another initializer unexpectedly.
 
 - Failable Initializers:
    - It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail.
    -  You write a failable initializer by placing a question mark after the init keyword (init?).
    
 - The init! Failable Initializer:
    - you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation point after the init keyword (init!) instead of a question mark.
    - You can delegate from init? to init! and vice versa, and you can override init? with init! and vice versa. You can also delegate from init to init!, although doing so will trigger an assertion if the init! initializer causes initialization to fail.
 
 - Required Initializers:
    - Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer.
    - You must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You don’t write the override modifier when overriding a required designated initializer
 
 */

/*
 
 import UIKit

// MARK: Initialization

// MARK: Initializers


struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


// MARK: Customizing Initialization

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)


struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

let bodyTemperature = Celsius(37.0)

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."


// Assigning Constant Properties During Initialization

let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"

// Memberwise Initializers for Structure Types

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
print(twoByTwo.width, twoByTwo.height)

let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                      size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

print(basicRect, originRect, centerRect)

// Class Inheritance and Initialization

// Two-Phase Initialization

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
//        super.init() //implicitly called here
    }
    
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")


class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
print(namedMeat.name)

let unNamedMeat = Food()
print(unNamedMeat.name)
print(unNamedMeat)

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

// MARK: Failable Initializers

let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}


let valueChanged = Int(exactly: pi)

if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")

if let someCreature {
    print("An animal was initialized with a species of \(someCreature.species)")
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}


// Failable Initializers for Enumerations

enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}

// Propagation of Initialization Failure

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

// Overriding a Failable Initializer

class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

class TestFailableInit {
    var argument: String?
    
    init!(with argument: String?) {
        if argument == nil { return nil }
        
        self.argument = argument
    }
}

let testFailable = TestFailableInit(with: "Hello")
print(testFailable?.argument)

let testFailable2 = TestFailableInit(with: "")
print(testFailable2?.argument)

// MARK: Required Initializers

class SomeClass {
    let lastName = "Gurram"
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass {
    let name = "Gopal"
}

let subClass = SomeSubclass()
print(subClass.name, subClass.lastName)

// Setting a Default Property Value with a Closure or Function

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))

 */

//: [Next](@next)
