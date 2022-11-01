//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html
 
 NOTE:
    - Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance.
    - subscripts can’t use in-out parameters.
 
 - Subscripts:
    - Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name.
    - You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, in the same way as instance methods.
    - You can define multiple subscripts for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript.
    - Unlike instance methods, subscripts can be read-write or read-only.
 
 - Type Subscripts:
    - You indicate a type subscript by writing the static keyword before the subscript keyword.
    - Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that subscript.
 
 */

import Foundation

// MARK: Subscripts

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)

matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

print(matrix)

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)


//: [Next](@next)
