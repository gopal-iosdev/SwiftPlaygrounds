//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html
 
 NOTE:
 - Casting doesn’t actually modify the instance or change its values. The underlying instance remains the same; it’s simply treated and accessed as an instance of the type to which it has been cast.
 - The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any, as shown below.
    - Example:
         let optionalNumber: Int? = 3
         things.append(optionalNumber) // Warning: Expression implicitly coerced from 'Int?' to 'Any'
         things.append(optionalNumber as Any) // No Warning
 
 - Type Casting:
    - Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.
    - Type casting in Swift is implemented with the "is" and "as" operators.
    -
 
 - Downcasting:
    - You can try to downcast to the subclass type with a type cast operator (as? or as!).
        - as?:
            - returns an optional value of the type you are trying to downcast to
            - Use the conditional form of the type cast operator (as?) when you aren’t sure if the downcast will succeed.
        - as!:
            - The forced form, as!, attempts the downcast and force-unwraps the result as a single compound action.
            - Use the forced form of the type cast operator (as!) only when you are sure that the downcast will always succeed.
            - This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
 
 - Type Casting for Any and AnyObject:
    - Swift provides two special types for working with nonspecific types:
        - Any: Can represent an instance of any type at all, including function types.
        - AnyObject: Can represent an instance of any class type.
 */

import Foundation

// MARK: - Type Casting

/*

class MediaItem {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

 */

// MARK: Any Type

/*

var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

print(type(of: things))

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

let optionalNumber: Int? = 3
things.append(optionalNumber) // Warning: Expression implicitly coerced from 'Int?' to 'Any'
things.append(optionalNumber as Any)

 */

//: [Next](@next)
