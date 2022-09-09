//: [Previous](@previous)

//: [Next](@next)

/*
 
 Link: https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
 
 Swift v/s Objective C:
 ~ Only in Swift:
    - Tuples, Optionals, Type Safety.
    - < operator can’t be applied to Bool values.
      Example:
        - In Swift: true > false => will throw an error.
        - In Objective C: YES/ true > NO/ false => will return YES.
    -
 
 NOTE:
 - If a stored value in your code won’t change, always declare it as a constant with the let keyword. Use variables only for storing values that need to be able to change.
 
 Cheat sheet:
 - You can define multiple related variables of the same type on a single line, separated by commas, with a single type annotation after the final variable name:
 ```
    var red, green, blue: Double
 ```
 - Double v/s Float
 Double - at least 15 decimal digits
 Float - 6 decimal digits
 * In situations where either type would be appropriate, Double is preferred. *
 
 - You can't add 2 different types without type conversion.
 Example:
 let twoThousand: UInt16 = 2_000
 let one: UInt8 = 1
 let twoThousandAndOne = twoThousand + UInt16(one)
 
 - typealias: alternative name for an existing type
 
 - Type safety:
 * Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process.
 * Swift’s type safety prevents non-Boolean values from being substituted for Bool.
 Example:
 ~ Swift:
 let i = 1
 if i {
     // this example will not compile, and will report an error
 }
 
 ~ Objective C
 int i = 1
 if (i) {
 // this example will compile, and will go into if loop.
 }
 
 - Error Handling:
 
* You use error handling to respond to error conditions your program may encounter during execution.
 
 Example:
 func makeASandwich() throws {
     // ...
 }

 do {
     try makeASandwich()
     eatASandwich()
 } catch SandwichError.outOfCleanDishes {
     washDishes()
 } catch SandwichError.missingIngredients(let ingredients) {
     buyGroceries(ingredients)
 }
 
 * Because makeASandwich() can throw an error, the function call is wrapped in a try expression.
 
 - Assertions and Preconditions:
 * Assertions and preconditions are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code.
 * Using assertions and preconditions isn’t a substitute for designing your code in such a way that invalid conditions are unlikely to arise. However, using them to enforce valid data and state causes your app to terminate more predictably if an invalid state occurs, and helps make the problem easier to debug.
 * The difference between assertions and preconditions is in when they’re checked: Assertions are checked only in debug builds, but preconditions are checked in both debug and production builds.
 * Preconditions: Use a precondition whenever a condition has the potential to be false, but must definitely be true for your code to continue execution. For example, use a precondition to check that a subscript isn’t out of bounds, or to check that a function has been passed a valid value.
 * If you compile in unchecked mode (-Ounchecked), preconditions aren’t checked. The compiler assumes that preconditions are always true, and it optimizes your code accordingly. However, the fatalError(_:file:line:) function always halts execution, regardless of optimization settings.
 
 */

import Foundation

var red, green, blue: Double

red = 2.45
green = 2.45
blue = 2.5

print(red, green, blue)

print(red, terminator: "Hello")

let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8

print(minValue, maxValue)


let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
let intPi = Int(pi)

print(pi)
print(intPi)

typealias AudioSample = UInt16

print(AudioSample.max)

var myNumber: Int?

myNumber = 10

let assumedString: String! = "An implicitly unwrapped optional string."

//assumedString = nil

print(assumedString)

// MARK: - Assertion

let age = -3
let fileName: StaticString = "The Basics"
//assert(age >= 0, "A person's age can't be less than zero.", file: fileName, line: 118)

// MARK: - Precondition

var index = 10
precondition(index > -1, "Index must be greater than zero.")
print("Code after precondition")

if index <= 0 {
    fatalError("Index must be greater than zero.")
}

print("Code after fatalError")

