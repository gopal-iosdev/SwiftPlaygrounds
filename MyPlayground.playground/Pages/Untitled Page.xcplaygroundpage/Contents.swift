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
