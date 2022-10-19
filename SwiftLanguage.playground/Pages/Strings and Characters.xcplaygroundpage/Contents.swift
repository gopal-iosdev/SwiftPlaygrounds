//: [Previous](@previous)

/*
 Link: https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html
 
 - Multiline Strings:
    - When you don’t want the line breaks to be part of the string’s value, Write a backslash (\) at the end of those lines.
        Example:
        1.) let quotation = """
             The White Rabbit put on his spectacles.  "Where shall I begin,
             please your Majesty?" he asked.
             """
            print(quotation):
             The White Rabbit put on his spectacles.  "Where shall I begin,
             please your Majesty?" he asked.
        2.) let softWrappedQuotation = """
             The White Rabbit put on his spectacles.  "Where shall I begin, \
             please your Majesty?" he asked.
            """
            print(softWrappedQuotation):
             The White Rabbit put on his spectacles.  "Where shall I begin, please your Majesty?" he asked.
- Swift’s String type is a value type.
- Unicode:
    - Unicode is an international standard for encoding, representing, and processing text in different writing systems.
    - Swift’s String and Character types are fully Unicode-compliant.
 
- String Indices:
    - Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string.
    - startIndex property to access the position of the first Character of a String.
    - endIndex property is the position after the last character in a String.
        - As a result, the endIndex property isn’t a valid argument to a string’s subscript
    - If a String is empty, startIndex and endIndex are equal.
 
    - NOTE:
        - You can use the startIndex and endIndex properties and the index(before:), index(after:), and index(_:offsetBy:) methods on any type that conforms to the Collection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set.
 - Note:
    - You can use the insert(_:at:), insert(contentsOf:at:), remove(at:), and removeSubrange(_:) methods on any type that conforms to the RangeReplaceableCollection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set.
 
 - Substrings:
    - substring from a string.
    - Substrings in Swift have most of the same methods as strings, which means you can work with substrings the same way you work with strings.
    - However, unlike strings, you use substrings for only a short amount of time while performing actions on a string.
    - The difference between strings and substrings is that, as a performance optimization, a substring can reuse part of the memory that’s used to store the original string, or part of the memory that’s used to store another substring.
    - substrings aren’t suitable for long-term storage—because they reuse the storage of the original string.
    - Note:
        - Both String and Substring conform to the StringProtocol protocol, which means it’s often convenient for string-manipulation functions to accept a StringProtocol value. You can call such functions with either a String or Substring value.
 - Comparing Strings:
    - Two String values (or two Character values) are considered equal if their extended grapheme clusters are canonically equivalent.
        - Grapheme clusters are canonically equivalent if they have the same linguistic meaning and appearance
        - Grapheme Cluster:
            - Every instance of Swift’s Character type represents a single extended grapheme cluster. An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
    - NOTE:
        - String and character comparisons in Swift aren’t locale-sensitive.
 
 - Prefix and Suffix Equality:
    - To check whether a string has a particular string prefix or suffix, call the string’s hasPrefix(_:) and hasSuffix(_:) methods, both of which take a single argument of type String and return a Boolean value.
    - NOTE:
        - The hasPrefix(_:) and hasSuffix(_:) methods perform a character-by-character canonical equivalence comparison between the extended grapheme clusters in each string
 
 */

import Foundation

/*

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""

print(quotation)
print("\n=======================================\n")
print(softWrappedQuotation)

let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""

print(lineBreaks)

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"

print(wiseWords)

let threeDoubleQuotationMarks = """
Escaping the first quotation mark \""
Escaping all three quotation marks \"\"\"
"""

print(threeDoubleQuotationMarks)

let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#

print(threeMoreDoubleQuotationMarks)

if threeMoreDoubleQuotationMarks.isEmpty {
    print("threeMoreDoubleQuotationMarks is Empty")
}

let exclamationMark: Character = "!"

print(exclamationMark)

let usFlag: Character = "\u{1F1FA}\u{1F1F8}"
print(usFlag)

let multiplier = 3
print(#"Write an interpolated string in Swift using \(multiplier)."#)
print(#"6 times 7 is \#(6 * 7)."#)
print("6 times 7 is \(6 * 7).")

let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
print(regionalIndicatorForUS)

let snail = "🐌"
for char in snail { print(char, terminator: "") }
print("")
print(snail.count)

let greeting = "Guten Tag!"

print(greeting[greeting.startIndex])

print(greeting[greeting.index(before: greeting.endIndex)])

print(greeting[greeting.index(after: greeting.startIndex)])

let index = greeting.index(greeting.startIndex, offsetBy: 8)
print(greeting[index])

for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}

print("")

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))

print(welcome.startIndex)
print(welcome.endIndex)
debugPrint(welcome)

let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"


print(beginning)
print(type(of: beginning))

var str = "World"
var subS: Substring = ""
subS = "Hello"

subS = subS + str

print(subS)


// Convert the result to a String for long-term storage.
let newString = String(beginning)

let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0

for scene in romeoAndJuliet {
    if scene.hasSuffix("mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("cell") {
        cellCount += 1
    }
}

print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
 
let dogString = "Dog‼🐶"

for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")

for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar) ", terminator: "")
}
print("")

 */

//: [Next](@next)
