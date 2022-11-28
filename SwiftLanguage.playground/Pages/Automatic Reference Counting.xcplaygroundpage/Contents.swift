//: [Previous](@previous)

/*
Source:
 - https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html

 NOTE:
 - Weak V/s UnOwned:
    - Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first.
    - In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.
    - When you use an unowned optional reference, you’re responsible for making sure it always refers to a valid object or is set to nil.
    - ARC never sets an unowned reference’s value to nil.
 - Property observers aren’t called when ARC sets a weak reference to nil.
 - In systems that use garbage collection, weak pointers are sometimes used to implement a simple caching mechanism because objects with no strong references are deallocated only when memory pressure triggers garbage collection. However, with ARC, values are deallocated as soon as their last strong reference is removed, making weak references unsuitable for such a purpose.
 - Use an unowned reference only when you are sure that the reference always refers to an instance that hasn’t been deallocated.
 - If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.
 - You indicate an unsafe unowned reference by writing unowned(unsafe). If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.
 - The underlying type of an optional value is Optional, which is an enumeration in the Swift standard library. However, optionals are an exception to the rule that value types can’t be marked with unowned.
 - The optional that wraps the class doesn’t use reference counting, so you don’t need to maintain a strong reference to the optional.
 - Even though the closure refers to self multiple times, it only captures one strong reference to the Parent instance.
 - Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod()) whenever you refer to a member of self within a closure. This helps you remember that it’s possible to capture self by accident.
 - If the captured reference will never become nil, it should always be captured as an unowned reference, rather than a weak reference.
 
 - AutomaticReferenceCounting:
    - Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage.
    - In most cases, this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself.
    - ARC automatically frees up the memory used by class instances when those instances are no longer needed.
    - Using ARC in Swift is very similar to the approach described in Transitioning to ARC Release Notes for using ARC with Objective-C.
    - Reference counting applies only to instances of classes. Structures and enumerations are value types, not reference types, and aren’t stored and passed by reference.
    - However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods. Indeed, if you tried to access the instance, your app would most likely crash.
    - strong reference cycle:
        - An instance of a class never gets to a point where it has zero strong references.
        - This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive. This is known as a strong reference cycle.
        - Solution:
            - Swift provides two ways to resolve strong reference cycles when you work with properties of class type: `weak references` and `unowned references`.

    - Weak References:
        - A weak reference is a reference that doesn’t keep a strong hold on the instance it refers to, and so doesn’t stop ARC from disposing of the referenced instance.
        - Because a weak reference doesn’t keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it. Therefore, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated.
 
    - Unowned References:
        - Like a weak reference, an unowned reference doesn’t keep a strong hold on the instance it refers to.
        - Unlike a weak reference, an unowned reference is expected to always have a value.
        - As a result, marking a value as unowned doesn’t make it optional, and ARC never sets an unowned reference’s value to nil.
 
    - Unowned Optional References:
        - You can mark an optional reference to a class as unowned.
        - An unowned optional reference doesn’t keep a strong hold on the instance of the class that it wraps, and so it doesn’t prevent ARC from deallocating the instance. It behaves the same as an unowned reference does under ARC, except that an unowned optional reference can be nil.
 
    - Unowned References and Implicitly Unwrapped Optional Properties:
        - When both properties should always have a value, and neither property should ever be nil once initialization is complete. In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
        - This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still avoiding a reference cycle.
        
    - Strong Reference Cycles for Closures:
        - A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance.
        - Closure to “capture” self, creates a strong reference cycle.
        
    - Resolving Strong Reference Cycles for Closures:
        - You resolve a strong reference cycle between a closure and a class instance by defining a capture list as part of the closure’s definition.
        - A capture list defines the rules to use when capturing one or more reference types within the closure’s body.
        - Defining a Capture List:
            - Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance (such as self) or a variable initialized with some value (such as delegate = self.delegate).
            - These pairings are written within a pair of square braces, separated by commas.
        - Weak and Unowned References:
            - Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
            - Conversely, define a capture as a weak reference when the captured reference may become nil at some point in the future. Weak references are always of an optional type, and automatically become nil when the instance they reference is deallocated.
 
 */

import Foundation

// MARK: - ARC in Action

/*

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil

reference3 = nil
 
 */

// MARK: Strong Reference Cycles Between Class Instances

/*
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil

print(unit4A?.unit)

unit4A = nil
 */

// MARK: Unowned

/*
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var john: Customer?

john = Customer(name: "John Appleseed")

john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

john = nil
 */

// MARK: Unowned Optional References

/*
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]
*/

// MARK: Unowned References and Implicitly Unwrapped Optional Properties

/*
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
 */

// MARK: Strong Reference Cycles for Closures

/*
class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

let defaultText = "some default text"
let heading = HTMLElement(name: "h1", text: defaultText)

heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil


class CaptureClosure {
    lazy var someClosure = {
        [unowned self, weak delegate = self.delegate]
        (index: Int, stringToProcess: String) -> String in
        // closure body goes here
    }
}
*/

// MARK: Weak and Unowned References

/*

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil

*/

//: [Next](@next)
