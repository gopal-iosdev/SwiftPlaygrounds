//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html
 
 NOTE:
    - Error handling in Swift interoperates with error handling patterns that use the NSError class in Cocoa and Objective-C.
    - Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords. Unlike exception handling in many languages—including Objective-C—error handling in Swift doesn’t involve unwinding the call stack, a process that can be computationally expensive. As such, the performance characteristics of a throw statement are comparable to those of a return statement.
    - Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.
        - Example:
             func canThrowErrors() throws -> String
             func cannotThrowErrors() -> String
    - You use try? to handle an error by converting it to an optional value. If an error is thrown while evaluating the try? expression, the value of the expression is nil.
    - You can use a defer statement even when no error handling code is involved.
 
 - Error Handling:
    - Error handling is the process of responding to and recovering from error conditions in your program.
    - You use a do-catch statement to handle errors by running a block of code.
    - try v/s try? v/s try!:
        - try:
            - Throws error & have to handle it.
        - try?:
            - Doesn't throw and error, Converts error to an optional value.
            - Using try? lets you write concise error handling code when you want to handle all errors in the same way.
        - try!:
            - Doesn't throw and error, If an error actually is thrown, you’ll get a runtime error.
            - Example:
                let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
 - A defer statement defers execution until the current scope is exited. This statement consists of the defer keyword and the statements to be executed later.
 - Deferred actions are executed in the reverse of the order that they’re written in your source code. That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first.
 
 */

import Foundation


// MARK: Error Handling

/*

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws -> Item? {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
        
        return item
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws -> Item? {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    return try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("🍟 ✅ Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("🍟 ✅ Success! Yum.")
} catch let error as VendingMachineError {
    switch error {
    case .invalidSelection:
        print("Invalid Selection.")
    case .outOfStock:
        print("Out of Stock.")
    case .insufficientFunds(let coinsNeeded):
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    }
} catch {
    print("Unexpected error: \(error).")
}

func someThrowingFunction() throws -> Int {
    // ...
    return 0
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

func fetchDataFromDisk() -> Data { return Data() }
func fetchDataFromServer() -> Data { return Data() }

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}

 */

//: [Next](@next)
