//: [Previous](@previous)


/*
Source:
 - https://sarunw.com/posts/decode-array-with-corrupted-element/

NOTE:
 -
 
 */


import Foundation
import XCTest

// MARK: - JSON Serialization

/*

struct User: Codable {
    let firstName: String
    let middleName: String?
    let lastName: String
}

public struct OptionalObject<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}

// MARK: Correct JSON

/*

let json = """
    [
        {
            "firstName": "John",
            "lastName": "Doe"
        },
        {
            "firstName": "Luffy",
            "middleName": "D.",
            "lastName": "Monkey"
        }
    ]
"""

do {
    let users = try JSONDecoder().decode([User].self, from: json.data(using: .utf8)!)
    XCTAssertEqual(users.count, 2)
    print(users)
} catch {
    print(error)
}
 */

// MARK: Unexpected JSON

/*

let unExpectedJson = """
    [
        {
            "firstName": "John",
            "lastName": "Doe"
        },
        {
            "firstName": "Luffy",
            "middleName": "D.",
            "lastName": "Monkey"
        },
        {
            "firstName": "Alice"
        }
    ]
"""

do {
    let users = try JSONDecoder().decode([User].self, from: unExpectedJson.data(using: .utf8)!)
    XCTAssertEqual(users.count, 2)
} catch {
    print(error)
}

// MARK: Solution for Unexpected JSON

do {
    let optionalUsers = try JSONDecoder().decode([OptionalObject<User>].self, from: unExpectedJson.data(using: .utf8)!)
    let users = optionalUsers.compactMap { $0.value }
    print(users)
} catch {
    print(error)
}

 */

// MARK: Unexpected JSON Array in another object

/*

let employeesJson = """
{
"employees":
    [
        {
            "firstName": "John",
            "lastName": "Doe"
        },
        {
            "firstName": "Luffy",
            "middleName": "D.",
            "lastName": "Monkey"
        },
        {
            "firstName": "Alice"
        }
    ]
}
"""

struct Company: Codable {
    let employees: [User]

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let nullableEmployees = try values.decode([OptionalObject<User>].self, forKey: .employees) // <1>
        self.employees = nullableEmployees.compactMap { $0.value } // <2>
    }
}

do {
    let company = try JSONDecoder().decode(Company.self, from: employeesJson.data(using: .utf8)!)
    print(company)
} catch {
    print(error)
}

 */
 
 */

//: [Next](@next)
