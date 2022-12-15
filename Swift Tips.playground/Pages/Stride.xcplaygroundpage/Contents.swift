//: [Previous](@previous)

/*
- Stride/ Strideable:
    - Protocol
    - A type representing continuous, one-dimensional values that can be offset and measured.
    - OptionSet in Swift allows you to define a set of options for configurations.
    - Src:
        - https://useyourloaf.com/blog/swift-stride-quick-guide/?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_145

*/

import Foundation

// MARK: StrideTo & StrideThrough

 /*

// StrideTo on Int type

let stride1 = stride(from: 0,
                     to: 10,
                     by: 2)
let s1 = stride1.map { $0 }
print(s1)
dump(s1)

print(stride1)
dump(stride1)

// StrideThrough on Int type

let stride2 = stride(from: 0,
                     through: 10,
                     by: 2)
let s2 = stride2.map { $0 }

print(s2)
dump(s2)

print(stride2)
dump(stride2)

let list = [0, 2, 4, 6, 8]

let stride3 = stride(from: 0, to: list.last!, by: 1)
let s3 = stride3.map({ $0 })
let filteredS3 = s3.filter({ $0 % 2 == 0 })

dump(stride3)
dump(s3)
dump(filteredS3)

*/

// MARK: Stride Example Use Cases

/*

for oddValue in stride(from: 1, through: 30, by: 2) {
  print(oddValue)
}

// Matrix

//  0  1  2  3
//  4  5  6  7
//  8  9 10 11

let matrix = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

let rows = 3
let columns = 4

let column = 3
let result = stride(from: column,
                      to: rows*columns,
                      by: columns)
  .map { matrix[$0] }

print(result)

// Graphs

let sineWave = stride(from: 0.0,
                   through: 2 * .pi,
                        by: .pi / 8)
  .map { sin($0) }

let endVal: CGFloat = 2 * .pi
let strideVal: CGFloat = .pi / 8

dump(endVal)
dump(strideVal)

*/

//: [Next](@next)
