//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

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

//: [Next](@next)
