//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Functions.html
 
 - Functions:
    - Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.
    - Parameters can provide default values to simplify function calls and can be passed as in-out parameters.
    - Functions without a defined return type return a special value of type Void. This is simply an empty tuple, which is written as ().
 
 - Functions with Multiple Return Values:
    - Tuples.
 
 - Optional Tuple Return Types:
    - You can use an optional tuple return type to reflect the fact that the entire tuple can be nil.
    - An optional tuple type such as (Int, Int)? is different from a tuple that contains optional types such as (Int?, Int?). With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
 
 - Functions With an Implicit Return:
    - If the entire body of the function is a single expression, the function implicitly returns that expression.
 
 - Function Argument Labels and Parameter Names:
    - Example:
         func someFunction(argumentLabel parameterName: Int) {
             // In the function body, parameterName refers to the argument value
             // for that parameter.
         }
 
 - Omitting Argument Labels:
    - If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.
 
 - Default Parameter Values:
    - You can define a default value for any parameter in a function by assigning a value to the parameter after that parameter’s type.
    - Place parameters that don’t have default values at the beginning of a function’s parameter list, before the parameters that have default values.

 - Variadic Parameters:
    - A variadic parameter accepts zero or more values of a specified type.
        Example:
            - func arithmeticMean(_ numbers: Double...)
 
- In-Out Parameters:
    -  If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
    - You can only pass a variable as the argument for an in-out parameter.
    - You place an ampersand (&) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
    - In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.
    -
 
 - Function Types:
    - Type of a function.
        - Example:
            - func printHelloWorld() {
                 print("hello, world")
            }
            - ^^^ a function that has no parameters, and returns Void.
    - Using Function Types:
        - You can define a constant or variable to be of a function type and assign an appropriate function to that variable
    - As with any other type, you can leave it to Swift to infer the function type when you assign a function to a constant or variable.
 
    - Function Types as Parameter Types:
        - You can pass function type as i/p parameter.
 
    - Function Types as Return Types:
        - You can use a function type as the return type of another function.
 
 - Nested Functions:
    - You can also define functions inside the bodies of other functions, known as nested functions.
 
 */


// MARK: Tuples

/*

 import Foundation
 
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])

print("min is \(bounds.min) and max is \(bounds.max)")

// MARK: Optional Tuples

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

// MARK: Functions With an Implicit Return

func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))

// MARK: Default Parameter Values

func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12, defaultString: String? = nil) {
    print(parameterWithoutDefault, parameterWithDefault, (defaultString ?? "Empty String"))
}

someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)

someFunction(parameterWithoutDefault: 4)


// MARK: Variadic Parameters

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

print(arithmeticMean(1, 2, 3, 4, 5))
print(arithmeticMean(3, 8.25, 18.75))

*/

// MARK: In-Out Parameters

/*

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107

print("BEFORE: someInt is now \(someInt), and anotherInt is now \(anotherInt)")

swapTwoInts(&someInt, &anotherInt)

print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


// MARK: Function Types

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")

mathFunction = multiplyTwoInts

print("Result: \(mathFunction(2, 3))")

let anotherMathFunction = addTwoInts

print(anotherMathFunction(3, 4))

// MARK: Function Types as Parameter Types

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5)

printMathResult(multiplyTwoInts, 3, 5)

// MARK: Function Types as Return Types

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> ((Int) -> Int) {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

print(moveNearerToZero(currentValue))

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

// MARK: Nested Functions

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
 
 */

//: [Next](@next)
