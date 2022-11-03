//: [Previous](@previous)

import Foundation

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Closures.html
 
 NOTE:
    - Closures Are Reference Types
    - Completion handlers can become hard to read, especially when you have to nest multiple handlers. An alternate approach is to use asynchronous code, as described in Concurrency.
    - If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses capture lists to break these strong reference cycles. For more information, see Strong Reference Cycles for Closures.
    - Escaping/ @escaping Closure:
        - refer to self explicitly.
    - Non-Escaping Closure:
        - refer to self implicitly.
    - An autoclosure/ @autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure.
        - Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.
    - If you want an autoclosure that’s allowed to escape, use both the @autoclosure and @escaping attributes.
 
 - Closures:
    - Closures are self-contained blocks of functionality that can be passed around and used in your code.
    - Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.
    - Global functions:
        - Closures that have a name and don’t capture any values.
    - Nested functions:
        - Closures that have a name and can capture values from their enclosing function.
    - Closure expressions:
        - Unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
    - Swift’s closure optimizations:
        - Inferring parameter and return value types from context
        - Implicit returns from single-expression closures
        - Shorthand argument names
        - Trailing closure syntax
 
 - Trailing Closures:
    - If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead.
 
         func someFunctionThatTakesAClosure(closure: () -> Void) {
             // function body goes here
         }

         // Here's how you call this function without using a trailing closure:

         someFunctionThatTakesAClosure(closure: {
             // closure's body goes here
         })

         // Here's how you call this function with a trailing closure instead:

         someFunctionThatTakesAClosure() {
             // trailing closure's body goes here
         }
        
        - Example with 2 trailing closures
 
         func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
             if let picture = download("photo.jpg", from: server) {
                 completion(picture)
             } else {
                 onFailure()
             }
         }

         loadPicture(from: someServer) { picture in
             someView.currentPicture = picture
         } onFailure: {
             print("Couldn't download the next picture.")
         }
 
 - Capturing Values:
    - A closure can capture constants and variables from the surrounding context in which it’s defined, even if the original scope that defined the constants and variables no longer exists.
 
 - Closures Are Reference Types:
    - functions and closures are reference types.
    - Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure.
    - This also means that if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure.
 
 - Escaping Closures or @escaping:
    - Helps the closure to outlive the life of the function that called it.
        Example: N/W api calls.
             var completionHandlers: [() -> Void] = []
             func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
                 completionHandlers.append(completionHandler)
             }
    - refer to self explicitly.
    - A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.
    - If self is an instance of a structure or an enumeration, you can always refer to self implicitly. However, an escaping closure can’t capture a mutable reference to self when self is an instance of a structure or an enumeration. Structures and enumerations don’t allow shared mutability.
 
 - Autoclosures or @autoclosure:
    - An autoclosure is a closure that’s automatically created to wrap an expression that’s being passed as an argument to a function. It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it.
    - It’s common to call functions that take autoclosures, but it’s not common to implement that kind of function. For example, the assert(condition:message:file:line:) function takes an autoclosure for its condition and message parameters; its condition parameter is evaluated only in debug builds and its message parameter is evaluated only if condition is false.
    - An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure.
 
 */


// MARK: Closures

// Version 1

/*

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

// Version 2

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

print(reversedNames)

// Version 3

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

print(reversedNames)

// Version 4

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: { (s1, s2) in return s1 > s2 } )

print(reversedNames)

// Version 5

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

print(reversedNames)

// Version 6

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: { $0 > $1 } )

print(reversedNames)

// Version 7

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

var reversedNames = names.sorted(by: >)

print(reversedNames)

// MARK: Trailing Closures

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

print(numbers)

let strings = numbers.map { number -> String in
    var number = number
    var output = ""
    
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print(strings)

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        print(runningTotal)
        return runningTotal
    }
    return incrementer
}

let increment = makeIncrementer(forIncrement: 10)
var runningTotal = 0

print("BEFORE", increment())

//runningTotal = increment()

print("AFTER", increment())
//print(runningTotal)

print("AFTER 2", increment())

// MARK: Escaping & Non Escaping Closures or @escaping


var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [weak self] in
            self?.x += 100
        }
        
        someFunctionWithNonescapingClosure {
            x += 200
        }
    }
}

let instance = SomeClass()

print("BEFORE Closure", instance.x)

instance.doSomething()

print("AFTER doSomething or NonescapingClosure", instance.x)

completionHandlers.first?()

print("AFTER doSomething or EscapingClosure", instance.x)

instance.doSomething()

print("AFTER 2 doSomething or NonescapingClosure", instance.x)
 

struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
//        someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}

var instanceStruct = SomeStruct()

print("BEFORE SomeStruct Closure", instanceStruct.x)

instanceStruct.doSomething()

print("AFTER SomeStruct doSomething or NonescapingClosure", instanceStruct.x)

instanceStruct.doSomething()

print("AFTER 2 SomeStruct doSomething or NonescapingClosure", instanceStruct.x)

// MARK: Autoclosures or @autoclosure

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella", "Gopal"]
print(customersInLine.count)

let customerProviderOne = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProviderOne())!")
print(customersInLine.count)

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )

func serveTwo(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serveTwo(customer: customersInLine.remove(at: 0))

// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}

//assert(customersInLine.count > 1, "Only One Customer")

 */

//: [Next](@next)
