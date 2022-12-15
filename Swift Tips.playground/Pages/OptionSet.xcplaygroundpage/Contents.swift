//: [Previous](@previous)

/*
- OptionSet:
    - Protocol
    - A type that presents a mathematical set interface to a bit set.
    - OptionSet in Swift allows you to define a set of options for configurations.
    - Src:
        - https://twitter.com/imrabti/status/1603365199108513795
        -
    - Call the object like it was a function.

*/


import Foundation

// MARK: OptionSet With Enums

/*
 
// Before OptionSet

enum InventoryFlag: Int32 {
    case open = 0x1
    case buy = 0x2
    case ready = 0x4
    case discount = 0x8
    
    func isActive(flags: Int32) -> Bool {
        rawValue & flags == rawValue
    }
    
    func enable(flags: Int32) -> Int32 {
        rawValue | flags
    }
    
    func disable(flags: Int32) -> Int32 {
        ~rawValue & flags
    }
}

// After OptionSet

struct InventoryFlagAfter: OptionSet, Hashable {
    let rawValue: Int32
    
    static let open = InventoryFlag(rawValue: 1 << 0)
    static let buy = InventoryFlag(rawValue: 1 << 1)
    static let ready = InventoryFlag(rawValue: 1 << 2)
    static let discount = InventoryFlag(rawValue: 1 << 3)
}


dump(InventoryFlagAfter.open?.rawValue)
dump(InventoryFlagAfter.buy?.rawValue)
dump(InventoryFlagAfter.ready?.rawValue)
dump(InventoryFlagAfter.discount?.rawValue)
 
 */

//: [Next](@next)

// MARK: OptionSet With Parsion JSON

/*
let data = try JSONSerialization.data(withJSONObject: messageWrapper, options: [.prettyPrinted, .sortedKeys])
*/


// MARK: OptionSet With URLSession

/*
 
 struct UploadOptions: OptionSet {
 let rawValue: UInt
 
 static let waitsForConnectivity    = UploadOptions(rawValue: 1 << 0)
 static let allowCellular  = UploadOptions(rawValue: 1 << 1)
 static let multipathTCPAllowed   = UploadOptions(rawValue: 1 << 2)
 
 static let standard: UploadOptions = [.waitsForConnectivity, .allowCellular]
 static let all: UploadOptions = [.waitsForConnectivity, .allowCellular, .multipathTCPAllowed]
 }
 
 struct Uploader {
 private let urlSession: URLSession
 
 init(options: UploadOptions) {
 let configuration = URLSessionConfiguration.default
 
 if options.contains(.multipathTCPAllowed) {
 configuration.multipathServiceType = .handover
 }
 
 configuration.allowsCellularAccess = options.contains(.allowCellular)
 configuration.waitsForConnectivity = options.contains(.waitsForConnectivity)
 
 urlSession = URLSession(configuration: configuration)
 }
 }
 
 let uploader = Uploader(options: [.waitsForConnectivity, .allowCellular])
 
 */
