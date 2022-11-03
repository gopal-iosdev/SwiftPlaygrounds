//: [Previous](@previous)

/*
 
 Link: https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html
 
 - Only in Swift, Operators: a..<b and a...b -> shortcut for expressing a range of values.
 - Operators are unary, binary, or ternary:
    - Unary: -a, !b, c!
    - Binary: 2 + 3 -> + is infix operator here, infix because they appear in between their two targets.
    - Ternary: (a ? b : c)
 
 - The compound assignment operators don’t return a value. For example, you can’t write let b = a += 2.
 - You can compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal.
    Example: (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
    - NOTE:
        The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
 - Unicode comparison for strings:
    - Example: "apple" < "bird" // true, because "apple" is less than "bird"
        - ^^^ comparison works based on unicode comparison for strings.
        - apple -> 97(i.e. a) 112 112 108 101
        - bird -> 98 105 114 100
        - Reasoning:
            1.) `bird` first char value(i.e. `b`) which is greated than `a` in apple -> so obviously it's the winner
 
- < operator can’t be applied to Bool values.
    Example: let trueFlag = true
            let falseFlag = false
    - ^^^ means, you can't say if `trueFlag > falseFlag`
- Avoid combining multiple instances of the ternary conditional operator into one compound statement.

 - Nil-Coalescing Operator(i.e. ??):
    - The nil-coalescing operator is shorthand for the code below:
    Example: a != nil ? a! : b -> with ternary operator
             a ?? b -> with nil-coalescing operator
 - Range Operators:
    - 1.) Closed Range Operator: a...b
    Example: 1...5: from 1 to 5 => 1, 2, 3, 4, 5
    - 2.) Half-Open Range Operator: a..<b
        - Half-open ranges are particularly useful when you work with zero-based lists such as arrays, where it’s useful to count up to (but not including) the length of the list
    Example: 1.) 1..<5: from 1 to 4 => 1, 2, 3, 4
            2.)
                let names = ["Anna", "Alex", "Brian", "Jack"]
                let count = names.count
                for i in 0..<count
    - 3.) One-Sided Ranges: a... or ...b or ..<b
    Exmple: 1.) ..<5: less than 5
            2.) ...5: less than or equal to 5
            3.) 2...: greater than or equal to 2
 - Explicit Parentheses:
    - It’s sometimes useful to include parentheses when they’re not strictly needed, to make the intention of a complex expression easier to read. In the door access example above, it’s useful to add parentheses around the first part of the compound expression to make its intent explicit:
     if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
         print("Welcome!")
     } else {
         print("ACCESS DENIED")
     }
 
 */

/*

import UIKit

var i = 8
var j = 11

var k = 10

let range = i..<j

var trueFlag = true
var optionalVal: String?

optionalVal = "Force Unwrapped"

//if (k in i..<j) {
//    print("\(k) in range of: \(range)")
//}

print(-i)
print(!trueFlag)
print(optionalVal!)

print("Remainder: \(j % i)")

print("Remainder - : \(-j % i)")

print("Remainder -(lower value) : \(j % -i)")

let three = 3
let minusThree = -three
let plusThree = -minusThree
print("Unary Minus Operator: \(three), \(minusThree), \(plusThree)")

let minusSix = -6
let alsoMinuSix = +minusSix
print("Unary Plus Operator: \(minusSix), \(alsoMinuSix)")

var a = 10

a += 2

print("Compound Assignment Operators: \(a)")


print("Tuple Comparison:")

print("apple" < "bird")

print((1, "zebra") < (2, "apple")) // true because 1 is less than 2; "zebra" and "apple" aren't compared

print((3, "apple") < (3, "bird"))    // true because 3 is equal to 3, and "apple" is less than "bird"

print((4, "dog") == (4, "dog"))      // true because 4 is equal to 4, and "dog" is equal to "dog"

var str1 = "apple"
var str2 = "bird"
print("str1.unicodeScalars: \(str1.unicodeScalars)")
print("str2.unicodeScalars: \(str2.unicodeScalars)")
print("str1.unicodeScalars.startIndex: \(str1.unicodeScalars.startIndex)")
print("str2.unicodeScalars.startIndex: \(str2.unicodeScalars.startIndex)")
print("str1.unicodeScalars[str1.unicodeScalars.startIndex]: \(str1.unicodeScalars[str1.unicodeScalars.startIndex])")
print("str2.unicodeScalars[str2.unicodeScalars.startIndex]: \(str2.unicodeScalars[str2.unicodeScalars.startIndex])")
print(str1.unicodeScalars[str1.unicodeScalars.startIndex].value)
print(str2.unicodeScalars[str2.unicodeScalars.startIndex].value)

print("#####")

str1 = "cpple"

for v in str1.unicodeScalars {
    print(v.value)
}

print("#####")

for v in str2.unicodeScalars {
    print(v.value)
}

print(str1 < str2)

print("Ternary Conditional Operator")

print("Nil-Coalescing Operator")

print("Range Operators")

let names = ["Anna", "Alex", "Brian", "Jack"]
let greaterThanOneSideRange = names[2...]

print(greaterThanOneSideRange)

let emojiText: NSString = "?launcher"
print(emojiText.substring(with: NSRange(location: 0, length: 2)))

print("Logical Operators")

 */
