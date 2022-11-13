//: [Previous](@previous)

import Foundation
import UIKit


// Article - https://www.swiftjectivec.com/swift-debug-print-print-dump-mirror-reflection/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS%2BDev%2BWeekly%2BIssue%2B578

/*
 
 let numbers: [Int] = [0,1,2]
 print(numbers)
 debugPrint(numbers)

 struct VideoGame: Identifiable {
     enum Genre: Int {
         case Adventure, Sports, Shooter
     }
     var id = UUID()
     var genre: Genre
     var name: String
     var releaseDate: Date
 }

 let originalReleaseDate = Date(timeIntervalSince1970: 1195250594)
 let massEffect = VideoGame(genre: .Adventure,
                            name: "Mass Effect",
                            releaseDate: originalReleaseDate)

 print(massEffect)
 debugPrint(massEffect)
 print("====================================================")
 print(String(reflecting: massEffect))
 print("====================================================")
 print(Mirror(reflecting: massEffect))
 print("====================================================")
 dump(massEffect)

 let name = "Jordan"

 print(name)
 debugPrint(name)

 print(String(reflecting:"Jordan"), String(reflecting:"Jansyn"), separator: " -- ")

 debugPrint("Jordan", "Jansyn", separator: " -- ")

 
 */

/*

let s = "anagram"
let t = "nagaram"

func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count
    else { return false }
    
    let sArray = Array(s)
    let tArray = Array(t)
    
    for sChar in sArray {
        let sCharCount = sArray.filter { $0 == sChar }
        let sCharCountInTArray = tArray.filter { $0 == sChar }
        
        guard sCharCount == sCharCountInTArray
        else { return false }
    }
    
    return true
}

print(isAnagram(s, t))

print(isAnagram("cat", "act")) // true

print(isAnagram("car", "tar")) // false


print(isAnagram("aacc", "ccac")) // false


print(s.sorted(), t.sorted())


func isAnagram2(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    
    var map = [Character : Int]()
    
    for (c1, c2) in zip(s,t) {
        map[c1, default: 0] += 1
        map[c2, default: 0] -= 1
    }
    
    return map.reduce(0, { $0 + abs($1.value) }) == 0
}

let words = ["one", "two", "three", "four"]
let numbers = 1...4

for (word, number) in zip(words, numbers) {
    print("\(word): \(number)")
}

let naturalNumbers = 1...Int.max
print(words, naturalNumbers)
let zipped = Array(zip(words, naturalNumbers))
print(zipped)

func isAnagram3(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    
    var map = [Character : Int]()
    for (c1, c2) in zip(s,t) {
        map[c1, default: 0] += 1
        map[c2, default: 0] -= 1
    }
    
    print(map)
    
    return map.reduce(0, { $0 + abs($1.value) }) == 0
}

isAnagram3("cat", "tac")

let names = ["alan","brian","charlie"]
print(names.reduce("===", +))

let csv = names.reduce("===") { partialResult, name in
    "\(partialResult), \(name)"
}

print(csv)


let results = [[5,2,7], [4,8], [9,1,3]]

let allResults = results.flatMap { $0 }
// [5, 2, 7, 4, 8, 9, 1, 3]

let passMarks = results.flatMap { $0.filter { $0 > 5} }
 
 */


/*

let testStr = "Hello"
let reverseStr = testStr.reduce(String()) { partialResult, nextChar in
    print(partialResult, nextChar)
    return String(nextChar) + String(partialResult)
}

print(testStr, reverseStr)
 
 */

/*

func exists<T: Equatable>(item: T, elements: [T]) -> Bool {
    elements.filter({ $0 == item }).count > 0
}


func existsNew<T: Equatable>(item:T, elements:[T]) -> Bool {
    for element in elements {
        if item == element {
            return true
        }
    }
    return false
}

let intArr = [1, 2, 4, 6, 8, 10]
let doubleArr = intArr.compactMap({ Double($0) * 2.0 })

print(exists(item: 2, elements: intArr))
print(exists(item: 8.0, elements: doubleArr))

print(existsNew(item: 2, elements: intArr))
print(existsNew(item: 8.0, elements: doubleArr))


struct Money: Comparable {
    let value: Int
    let currencyCode: String
    static func < (lhs: Money, rhs: Money) -> Bool {
        lhs.value < rhs.value
    }
}

class Person {
    var name: String
    var age: Int
    final var surName = "Gurram"
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let gopal = Gopal()

class Gopal: Person {
    init() {
        super.init(name: "Gopal", age: 31)
    }
}

print(gopal.name, gopal.surName)

enum MembershipType {
    case `default`
    case premium
    case trial
}

let membership = MembershipType.default

switch membership {
case .default:
    print("defalult case")
default:
    print("default")
}

*/

/*

protocol Animal {
    func speak()
}

class Dog: Animal {}
class Cat: Animal {}
extension Animal where Self: Dog {
    func speak() {
        print("Woof!")
    }
}
extension Animal where Self: Cat {
    func speak() {
        print("Meow!")
    }
}

let dog = Dog()
let cat = Cat()
print(dog.speak())
print(cat.speak())

let arr = [2, 3, 5, 7, 9]

print(arr.sorted())

print(arr.sorted(by: >))

print(arr.sorted(by: <))

enum Direction: String {
    case east, west, north, south
}

print(Direction.north.rawValue)

let direction = Direction(rawValue: "South")

print(direction?.rawValue)

let tuple = (1, 2, 3, 123.0, "Hello, world!")
print(tuple.4)

print(tuple.0)

let newT = (one: 1, two: "Two")

print(newT.one)
print(newT.two)

struct Flight {
    var origin: String
    var destination: String
    let cost: Int
}

enum Result<Type, Failure> where Failure: Error {
    case success(Flight)
    case failure(Failure)
}

enum FailureError: Error {
    case noNetwork
    case serverDown
}

func beResponse(_ success: Bool,_ completion: ((Result<Flight, FailureError>) -> Void)) {
    if success {
        completion(.success(Flight(origin: "EWR", destination: "SFO", cost: 200)))
    } else {
        completion(.failure(.serverDown))
    }
}

beResponse(true) { result in
    switch result {
    case .success(let flight):
        print(flight.origin)
    case .failure(let error):
        print(error)
    }
}

func defaultValue(value1: Int = 21, value2: String = "Hello", value3: Bool = false) {
    print(value1, value2, value3)
}

defaultValue()

func doubleInput(_ input: Int) throws -> Int {
    guard input != 0 else {
        throw FailureError.noNetwork
    }
    return input * 2
}

do {
    try [1,0,3,4,5].map { try doubleInput($0) }
} catch {
    print(error.localizedDescription)
}

 */

/*
let serialQueue = DispatchQueue(label: "aryamansharda")
serialQueue.async {
    print("This happens first!")
}
serialQueue.async {
    print("This happens second!")
}

print("END SERIAL QUEUE")

let concurrentQueue = DispatchQueue(label: "aryamansharda",
                                    attributes: .concurrent)
concurrentQueue.async {
    print("I'm added to the queue first!")
}
concurrentQueue.async {
    print("I'm added to the queue second!")
}

print("END CONCURRENT QUEUE")
 */

/*

class VisitorCount {
    let queue = DispatchQueue(label: "aryamansharda.visitor.count",
                              attributes: .concurrent)
    private var visitorCount = 0
    func getVisitorCount() -> Int {
        queue.sync {
            return visitorCount
        }
        
//        return visitorCount
    }
    
    func updateVisitorCount() {
        queue.sync(flags: .barrier) {
            visitorCount += 1
        }
        
//        visitorCount += 1
    }
    
}

let visitorCount = VisitorCount()
//print(visitorCount.getVisitorCount())
//print(visitorCount.updateVisitorCount())
//print(visitorCount.getVisitorCount())

let serialQueue = DispatchQueue(label: "SerialQueue")
let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)

serialQueue.async {
    print("QUEUE_1", visitorCount.getVisitorCount())
    print("QUEUE_1", visitorCount.updateVisitorCount())
    print("QUEUE_1", visitorCount.getVisitorCount())
}

concurrentQueue.async {
    print("CONCURRENT QUEUE_1", visitorCount.getVisitorCount())
    print("CONCURRENT QUEUE_1", visitorCount.updateVisitorCount())
    print("CONCURRENT QUEUE_1", visitorCount.getVisitorCount())
}

serialQueue.async {
    print("QUEUE_2", visitorCount.updateVisitorCount())
    print("QUEUE_2", visitorCount.getVisitorCount())
}

concurrentQueue.async {
    print("CONCURRENT QUEUE_2", visitorCount.getVisitorCount())
    print("CONCURRENT QUEUE_2", visitorCount.updateVisitorCount())
}
 
 */

/*

// MARK: Deadlock

func deadLock() {
    let queue = DispatchQueue(label: "deadlock-demo")
    queue.async { // A
        print("Entered the queue")
        queue.sync { // B
            print("B: Waiting on A to finish.")
        }
        print("A: Waiting on B to finish.")
    }
}

deadLock()
 
 */

/*

// MARK: Dispatch Group

class DispatchGroupDemo {
    func uploadImages(images: [UIImage]) {
        let group = DispatchGroup()
        
        for image in images {
            group.enter()
            ImageUploader.upload(image) {
                // Successfully uploaded photo
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            // TODO: Show user success message
        }
    }
}
*/

/*

// MARK: Cancel GCD/ O.Q

class WorkItem {
    func cancelTask() {
        let task = DispatchWorkItem { [weak self] in
            print("Performing a task...")
        }
        DispatchQueue.main.async(execute: task)
        task.cancel()
        
        print(task)
    }
    
    func cancelOperationQueue() {
        let operationQueue = OperationQueue()
        let op1 = BlockOperation { print("First") }
        let op2 = BlockOperation { print("Second") }
        
        let op3 = BlockOperation { print("Third") }
        operationQueue.addOperations([op1, op2, op3], waitUntilFinished: false)
        
        // Ex: Pause / Resuming Operation Queue
        operationQueue.isSuspended = true
        if operationQueue.isSuspended {
            operationQueue.isSuspended = false
        }
        // Cancels a single Operation
        op2.cancel()
        // Output: true
        print(op2.isCancelled)
    }
}

let workItem = WorkItem()
workItem.cancelTask()

workItem.cancelOperationQueue()

let dispatchQuePriorityZero = DispatchQueue(label: "Test QUS", qos: .userInteractive)

print(dispatchQuePriorityZero.qos)

let dispatchQuePriorityOne = DispatchQueue(label: "Test QUS", qos: .userInitiated)

print(dispatchQuePriorityOne.qos)

let dispatchQuePriorityTwo = DispatchQueue(label: "Test QUS", qos: .utility)

print(dispatchQuePriorityTwo.qos)

let dispatchQuePriorityThree = DispatchQueue(label: "Test QUS", qos: .background)

print(dispatchQuePriorityThree.qos.relativePriority)

print(dispatchQuePriorityZero.qos.relativePriority > dispatchQuePriorityTwo.qos.relativePriority)

let testStr = """


"""
 
 */


//: [Next](@next)
