//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html
 
 NOTE:
    - Swift classes don’t inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.
    - If you provide a setter as part of a property override, you must also provide a getter for that override. If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning super.someProperty from the getter, where someProperty is the name of the property you are overriding.
    - You can’t add property observers to inherited constant stored properties or inherited read-only computed properties. The value of these properties can’t be set, and so it isn’t appropriate to provide a willSet or didSet implementation as part of an override.
        Note also that you can’t provide both an overriding setter and an overriding property observer for the same property. If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
    - You can prevent a method, property, or subscript from being overridden by marking it as final.
 
 - Inheritance:
    - A class can inherit methods, properties, and other characteristics from another class.
    - The inheriting class is known as a subclass, and the class it inherits from is known as its superclass.

 - Base Class:
    - Any class that doesn’t inherit from another class is known as a base class.
 
 - Subclassing:
    - Subclassing is the act of basing a new class on an existing class. The subclass inherits characteristics from the existing class, which you can then refine. You can also add new characteristics to the subclass.
 
 */

import Foundation

// MARK: Inheritance

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

let someVehicle = Vehicle()

print("Vehicle: \(someVehicle.description)")

// MARK: Subclassing

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")



//car.description = "My Desc"
//
//print("After Car: \(car.description)")


//: [Next](@next)
