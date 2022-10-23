//: [Previous](@previous)

import Foundation

/*
 Link: https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html
 
 - It’s good practice to create immutable collections in all cases where the collection doesn’t need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.
 
 Sets:
 - A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.
 
 Dictionaries:
 - A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering.
 - updateValue(_:forKey:):
    - The updateValue(_:forKey:) method returns the old value after performing an update. This enables you to check whether or not an update took place.
 - removeValue(forKey:):
    - This method removes the key-value pair if it exists and returns the removed value, or returns nil if no value existed
 
 */
 
 // MARK: Arrays

var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

var shoppingList = ["Eggs", "Milk"]

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]


print(shoppingList)

shoppingList[3...5] = ["Bananas", "Apples"]

print(shoppingList)

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

var favoriteGenresArray = ["Rock", "Classical", "Hip hop"]

favoriteGenresArray.insert("Fusion", at: favoriteGenresArray.count)
 
 // MARK: SET

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

print(favoriteGenres)

var favoriteGenresShorter: Set = ["Rock", "Classical", "Hip hop"]

print(favoriteGenresShorter)

favoriteGenresShorter.insert("Fusion")

favoriteGenresShorter.insert("Techno")

print(favoriteGenresShorter)

favoriteGenresShorter.remove("Fusion")

print(favoriteGenresShorter)

for genre in favoriteGenresShorter {
    print(genre)
}

for genre in favoriteGenresShorter.sorted() {
    print(genre)
}

for genre in favoriteGenresShorter.sorted(by: >) {
    print(genre)
}

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()

oddDigits.intersection(evenDigits).sorted()

oddDigits.subtracting(singleDigitPrimeNumbers).sorted()

oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)

farmAnimals.isSuperset(of: houseAnimals)

farmAnimals.isDisjoint(with: cityAnimals)

houseAnimals.isStrictSubset(of: farmAnimals)

houseAnimals.isStrictSubset(of: cityAnimals)

farmAnimals.isStrictSuperset(of: houseAnimals)

houseAnimals.isStrictSubset(of: cityAnimals)


// MARK: Dictionaries

var emptyStringsArray: [String] = []
var emptyStringSet: Set<String> = []
var emptyDictionary: [Int: String] = [:]

print(type(of: emptyStringsArray))
print(type(of: emptyStringSet))

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
print("The airports dictionary contains \(airports.count) items.")

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary isn't empty.")
}

airports["LHR"] = "London"

print(airports)

let oldValue = airports.updateValue("London Heathrow", forKey: "LHR")

//airports["LHR"] = "London Heathrow"

print(airports)

print(oldValue)

airports["APL"] = "Apple International"

print(airports)

airports["APL"] = nil // To remove a value from Dict.

airports["JPN"] = nil

print(airports)

let removedValue = airports.removeValue(forKey: "DUB")

print(airports, "\n", removedValue)

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)

print(airportCodes, "\n", airportNames)



//: [Next](@next)
