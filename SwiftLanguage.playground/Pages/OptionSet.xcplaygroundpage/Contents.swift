//: [Previous](@previous)

/*
Source:
 - https://www.avanderlee.com/swift/optionset-swift/

NOTE:
 - options & enum cases are not same.
 - OptionSet in Swift allows you to define a set of configurations with a method or type initializer.
 
 
 - OptionSet:
    - OptionSet in Swift allows you to define a set of options for configurations.
    - The OptionSet protocol allows you to define available configuration options for a specific type or method.
    - It’s commonly used in the standard libraries, for example, when parsing JSON in Swift.
        - Example:
            let data = try JSONSerialization.data(withJSONObject: messageWrapper, options: [.prettyPrinted, .sortedKeys])
    -
 
 */

import Foundation

/*

struct WritingOptions: OptionSet {
    init(rawValue: UInt)
    static var prettyPrinted: JSONSerialization.WritingOptions // RawValue 1
    static var sortedKeys: JSONSerialization.WritingOptions // RawValue 2
    static var fragmentsAllowed: JSONSerialization.WritingOptions // RawValue 4
    static var withoutEscapingSlashes: JSONSerialization.WritingOptions // RawValue 8
}

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

//: [Next](@next)
