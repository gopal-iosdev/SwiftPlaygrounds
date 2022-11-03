//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html
 
 - Swift’s switch statement is considerably more powerful than its counterpart in many C-like languages. Cases can match many different patterns, including interval matches, tuples, and casts to a specific type.
 - For-In Loops:
    - You use the for-in loop to iterate over a sequence.
 - While Loops:
    - A while loop performs a set of statements until a condition becomes false.
    - while evaluates its condition at the start of each pass through the loop.
    - repeat-while evaluates its condition at the end of each pass through the loop.
        - The repeat-while loop in Swift is analogous to a do-while loop in other languages.
    -
 - Conditional Statements:
    - If
    - Switch
        - Every switch statement must be exhaustive.
        - Don't need an explicit break statement.
        - For multiple case matching: separating the cases with commas.
        - Tuples:
            - You can use tuples to test multiple values in the same switch statement. Each element of the tuple can be tested against a different value or interval of values. Alternatively, use the underscore character (_), also known as the wildcard pattern, to match any possible value.
        - Value Bindings:
            - A switch case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as value binding, because the values are bound to temporary constants or variables within the case’s body.
        - Where:
            - A switch case can use a where clause to check for additional conditions.
        - Compound Cases:
            - Multiple switch cases that share the same body can be combined by writing several patterns after case, with a comma between each of the patterns.
 
    - Control Transfer Statements
        - Control transfer statements change the order in which your code is executed, by transferring control from one piece of code to another.
        - Swift has five control transfer statements:
            - continue:
                - The continue statement tells a loop to stop what it’s doing and start again at the beginning of the next iteration through the loop.
 
            - break:
                - The break statement ends execution of an entire control flow statement immediately. The break statement can be used inside a switch or loop statement when you want to terminate the execution of the switch or loop statement earlier than would otherwise be the case.
 
            - fallthrough:
                - Going through each and every switch case.
                - The fallthrough keyword doesn’t check the case conditions for the switch case that it causes execution to fall into. The fallthrough keyword simply causes code execution to move directly to the statements inside the next case (or default case) block, as in C’s standard switch statement behavior.
            - return:
                -
            - throw:
 
    - Labeled Statements:
        - A labeled statement is indicated by placing a label on the same line as the statement’s introducer keyword, followed by a colon.
 
    - Early Exit:
        - guard statement.
    
    - Checking API Availability:
        - You use an availability condition in an if or guard statement to conditionally execute a block of code, depending on whether the APIs you want to use are available at runtime.
 
 */

/*
// MARK: For-In Loops
 
 import Foundation

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

for var index in 1...5 {
    index += 1
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
    print(tickMark)
}

let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    print(tickMark)
}


let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
    print(tickMark)
}

// MARK: While Loops

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

//print(board)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

//print(board)

var square = 0
var diceRoll = 0
print("square: \(square), finalSquare: \(finalSquare)")
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    print(diceRoll)
    if diceRoll == 7 { diceRoll = 1 }
    
    // move by the rolled amount
    square += diceRoll
    
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
    
    print("square after: \(square)")
}
print("Game over!")

// MARK: Repeat-While

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

repeat {
    // move up or down for a snake or ladder
    square += board[square]
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
} while square < finalSquare

print("Game over!")

// MARK: Conditional Statements

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

for aplhabet in "abcdefghijklmnopqrstuvwxyz" {
    switch aplhabet {
    case "a", "e", "i", "o", "u":
        print("\(aplhabet) is a vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
         "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("\(aplhabet) is a consonant")
    default:
        print("\(aplhabet) isn't a vowel or a consonant")
    }
}

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

// MARK: Control Transfer Statements
 
 // continue

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u"]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        print("continue")
        continue
    }
    puzzleOutput.append(character)
}

print(puzzleOutput)
 
 // break

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u"]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        print("break")
        break
    }
    puzzleOutput.append(character)
}

print(puzzleOutput)

let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}

// fallthrough

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
case 21:
    description += " a fancy number"
    fallthrough
default:
    description += " an integer."
}
print(description)

// Labeled Statements

let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    
    if diceRoll == 7 { diceRoll = 1 }
    
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
 
 */

//: [Next](@next)
