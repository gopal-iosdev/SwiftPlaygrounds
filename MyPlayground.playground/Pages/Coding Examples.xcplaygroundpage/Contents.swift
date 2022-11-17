import UIKit

//public enum Tag: Hashable, Codable, CaseIterable {
//    case newRelease
//    case onSale
//    case promoted
//    case custom(String)
//}

// V/S

/*

public struct Tag: Hashable, Codable {
    public var string: String

    public init(_ string: String) {
        self.string = string
    }
}

extension Tag: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        string = value
    }
}

public extension Tag {
    static var newRelease: Self { #function }
    static var onSale: Self { #function }
    static var promoted: Self { #function }
}

//for tag in Tag.allCases {
//    print(tag)
//}

//Tag.allCases.forEach { print($0) }

protocol Tagged: Hashable {
    var tags: [Tag] { get }
}

struct TaggedCollection<Element: Tagged & Hashable> {
    private var elements = [Tag : Set<Element>]()
    
    // Note that we have to explicitly add a public initializer
    // in order to be able to initialize a type outside of
    // the module that it's declared in:
    public init() {}

    public mutating func add(_ element: Element) {
        for tag in element.tags {
            elements[tag, default: []].insert(element)
        }
    }

    public mutating func remove(_ element: Element) {
        for tag in element.tags {
            elements[tag]?.remove(element)
        }
    }

    public func elements(taggedWith tag: Tag) -> Set<Element> {
        elements[tag] ?? []
    }
}

public struct RecommendationEngine<Element: Tagged & Hashable> {
    private let collection: TaggedCollection<Element>
    private let sorting: Sorting<Element>
    private let maxElementCount: Int

    public init(collection: TaggedCollection<Element>,
                sorting: Sorting<Element> = .shuffled,
                maxElementCount: Int = 3) {
        self.collection = collection
        self.sorting = sorting
        self.maxElementCount = maxElementCount
    }

    public func recommendations(forTag tag: Tag) -> [Element] {
        let elements = collection.elements(taggedWith: tag)
        return Array(sorting.body(elements).prefix(maxElementCount))
    }
}

public struct Sorting<Element: Hashable> {
    public typealias Body = (Set<Element>) -> [Element]

    public var body: Body

    public init(body: @escaping Body) {
        self.body = body
    }
}

public extension Sorting {
    static var shuffled: Self {
        .init { $0.shuffled() }
    }
}

public extension Sorting {
    static func basedOn<V: Comparable>(
        _ keyPath: KeyPath<Element, V>
    ) -> Self {
        .init { set in
            set.sorted {
                $0[keyPath: keyPath] < $1[keyPath: keyPath]
            }
        }
    }
}

let testTag = Tag("testTag")

let allTags: [Tag] = [.newRelease, .onSale, .promoted, testTag]

allTags.forEach({ print($0) })

*/

// MARK: Stack O(1) time

/*
class MinStack {
    
    var arr: [Int] = []
    var minimums: [Int] = []
    var minimum: Int?
    
    init() {}
    
    func push(_ val: Int) {
        arr.append(val)
        minimum = minimum == nil ? val : min(minimum!, val)
        minimums.append(minimum!)
    }
    
    func pop() {
        _ = arr.popLast()
        _ = minimums.popLast()
        minimum = minimums.last
    }
    
    func top() -> Int {
        return arr.last!
    }
    
    func getMin() -> Int {
        return minimums.last!
    }
}

let minStack = MinStack()
minStack.push(18)
minStack.push(19)
minStack.push(29)
minStack.push(15)
minStack.push(16)

print(minStack.arr)
print(minStack.minimums)
print(minStack.minimum)

minStack.pop()

print("-------")

minStack.pop()

print("-------")

minStack.pop()

print("-------")

print(minStack.arr)
print(minStack.minimums)
print(minStack.minimum)
*/

class Photo {
    var name: String
    var city: String
    var time: Date
    
    init(name: String, city: String, time: String) {
        self.name = name
        self.city = city
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD HH:MM:SS"
        self.time = formatter.date(from: time) ?? Date()
    }
}

public func solution(_ S : inout String) -> String {
    // write your code in Swift 4.2.1 (Linux)
    var photos: [Photo] = [Photo]()
    var photosDict: [String : [Photo]] = [:]
    var photosList: [String] = []
    var newName = ""
    
    photosList = S.components(separatedBy: "\n")
    
    for photoString in photosList {
        let photoInfo: [String] = photoString.components(separatedBy: ",")
        
        guard photoInfo.count == 3 else { continue }
        
        let photo = Photo(name: photoInfo[0], city: photoInfo[1], time: photoInfo[2])
        photos.append(photo)
    }
    
    // MARK - Group Photos By City
    
    for photo in photos {
        let myPlace: String = photo.city
        
        if var myPhotos = photosDict[myPlace] {
            myPhotos.append(photo)
        } else {
            var myPhotos: [Photo] = [Photo]()
            myPhotos.append(photo)
            photosDict[myPlace] = myPhotos
        }
    }
    
    for (place, photos) in photosDict {
        print(place)
        photos.forEach({ print($0.name) })
    }
    
    for photo in photos {
        var sortedPhotos: [Photo] = photosDict[photo.city] ?? []
        
        sortedPhotos = sortedPhotos.sorted(by: { $0.time < $1.time })
        
        print(sortedPhotos.count)
        
        let counter = (sortedPhotos.firstIndex(where: { $0.city == photo.city }) ?? 0) + 1
        let photoName: [String] = photo.name.components(separatedBy: ".")
        
        guard photoName.count == 2 else { continue }
        
        newName = newName + photo.city + (counter > 9 ? String.returnZeroes(counter) : String(counter)) + "." + photoName[1] + "\n"
    }
    
    
    return newName
}

extension String {
    static func returnZeroes(_ counter: Int) -> String {
        var str = ""
        
        for _ in 0..<counter {
            str += "0"
        }
        
        return str
    }
}

var inpurStr = """
photo.jpg, Warsaw, 2013-09-05 14:08:15
john.png, London, 2015-06-20 15:13:22
myFriends.png, Warsaw, 2013-09-05 14:07:13
Eiffel.jpg, Paris, 2015-07-23 08:03:02
pisatower.jpg, Paris, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Paris, 2015-09-01 12:00:00
me.jpg, Warsaw, 2013-09-06 15:40:22
a.png, Warsaw, 2016-02-13 13:33:50
b.jpg, Warsaw, 2016-01-02 15:12:22
c.jpg, Warsaw, 2016-01-02 14:34:30
d.jpg, Warsaw, 2016-01-02 15:15:01
e.png, Warsaw, 2016-01-02 09:49:09
f.png, Warsaw, 2016-01-02 10:55:32
g.jpg, Warsaw, 2016-02-29 22:13:11
"""

print(solution(&inpurStr))
