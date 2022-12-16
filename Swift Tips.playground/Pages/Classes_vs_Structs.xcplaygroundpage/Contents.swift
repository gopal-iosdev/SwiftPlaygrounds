//: [Previous](@previous)

/*
- Classes v/s Structs:
    - Structs are great when you are representing just Data types.
    - You have to use structs & classes with discipline.
    - Choose depending on semantics.
        - Structs => great for value types.
        - Classes => Great for behaviors with side effects, Examples: View Models.
    - Src:
        - https://www.youtube.com/watch?v=3zSuAkIt9jY&ab_channel=EssentialDeveloper

*/

import Foundation

// Mark mutating a value in Struct

// Before:

/*

struct Customer {
    var name: String
}

struct Purchase {
    let customer: Customer
}

var customer = Customer(name: "Gopal")
var purchase = Purchase(customer: customer)

customer.name = "Bharu"

print(purchase.customer.name)

 */

// After: Struct with let is mutated

/*

class Customer {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Purchase {
    let customer: Customer
}

var customer = Customer(name: "Gopal")
var purchase = Purchase(customer: customer)

customer.name = "Bharu"

print(purchase.customer.name)
 
 */


//: [Next](@next)
