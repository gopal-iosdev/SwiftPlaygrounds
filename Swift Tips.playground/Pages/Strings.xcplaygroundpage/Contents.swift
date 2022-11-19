//: [Previous](@previous)

/*
 ExpressibleByStringLiteral:
    - Src: https://www.youtube.com/watch?v=RG4YXbQXhxY&list=PLdXMqVQnoFleH3GSuTUpr3Fjzp1JMy-je&index=34&ab_channel=VincentPradeilles
    - It's a Protocol
 */

import Foundation

// MARK: Count Words

/*

extension String {
    func countWords() -> Int {
        var count = 0
        let range = self.startIndex..<self.endIndex
        self.enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })
        return count
    }
}

print("\(greeting) contains \(greeting.countWords()) words")
 
 */

// MARK: ExpressibleByStringLiteral

/*

let url: URL = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population")!

print(url)

// ExpressibleByStringLiteral

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: "\(value)")!
    }
}

let url2 = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"

print(url2)
print(url2.description)
print(url2.debugDescription)

assert(url.absoluteString == url2.description)


let literal: StringLiteralType = "My Dog said \"Hello Sir!\""

print(literal)

let twitterLink = """
        <a href="https://twitter.com/gopal_iosdev"></a>
        """
print(twitterLink)

 */


//: [Next](@next)
