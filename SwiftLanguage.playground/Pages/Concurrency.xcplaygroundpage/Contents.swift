//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
 
 NOTE:
 - If you’ve written concurrent code before, you might be used to working with threads. The concurrency model in Swift is built on top of threads, but you don’t interact with them directly. An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked. When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on.
 - For a function or method that’s both asynchronous and throwing, you write async before throws.
 - The Task.sleep(until:tolerance:clock:) method is useful when writing simple code to learn how concurrency works. This method does nothing, but waits at least the given number of nanoseconds before it returns. Here’s a version of the listPhotos(inGallery:) function that uses sleep(until:tolerance:clock:) to simulate waiting for a network operation:
 
 - Concurrency:
    - Combination of asynchronous and parallel code.
    - Swift has built-in support for writing asynchronous and parallel code in a structured way. Asynchronous code can be suspended and resumed later.
    - Although it’s possible to write concurrent code without using Swift’s language support, that code tends to be harder to read.
    - Call asynchronous functions with await when the code on the following lines depends on that function’s result. This creates work that is carried out sequentially.
    - Call asynchronous functions with async-let when you don’t need the result until later in your code. This creates work that can be carried out in parallel.
    - Both await and async-let allow other code to run while they’re suspended.
    -
 
 - Asynchronous Functions:
    - An asynchronous function or asynchronous method is a special kind of function or method that can be suspended while it’s partway through execution.
    - To indicate that a function or method is asynchronous, you write the async keyword in its declaration after its parameters, similar to how you use throws to mark a throwing function.
    - When calling an asynchronous method, execution suspends until that method returns. You write await in front of the call to mark the possible suspension point.
 - Asynchronous Sequences:
    - Example:
         let handle = FileHandle.standardInput
         for try await line in handle.bytes.lines {
             print(line)
         }
    - A for-await-in loop potentially suspends execution at the beginning of each iteration, when it’s waiting for the next element to be available.
    - In the same way that you can use your own types in a for-in loop by adding conformance to the Sequence protocol, you can use your own types in a for-await-in loop by adding conformance to the AsyncSequence protocol.
 
 - Calling Asynchronous Functions in Parallel:
    - Using `async let`
 
 - Tasks and Task Groups:
    - A task is a unit of work that can be run asynchronously as part of your program. All asynchronous code runs as part of some task.
    - You can also create a task group and add child tasks to that group, which gives you more control over priority and cancellation, and lets you create a dynamic number of tasks.
    - Tasks are arranged in a hierarchy. Each task in a task group has the same parent task, and each task can have child tasks. Because of the explicit relationship between tasks and task groups, this approach is called structured concurrency.
 
 - Unstructured Concurrency:
    - Unlike tasks that are part of a task group, an unstructured task doesn’t have a parent task.
    - You have complete flexibility to manage unstructured tasks in whatever way your program needs, but you’re also completely responsible for their correctness.
    - To create an unstructured task that runs on the current actor, call the Task.init(priority:operation:) initializer. To create an unstructured task that’s not part of the current actor, known more specifically as a detached task, call the Task.detached(priority:operation:) class method.
 
 - Task Cancellation:
    - To check for cancellation, either call Task.checkCancellation(), which throws CancellationError if the task has been canceled, or check the value of Task.isCancelled and handle the cancellation in your own code.
    - To propagate cancellation manually, call Task.cancel().
 
 - Actors:
    - Tasks are isolated from each other, which is what makes it safe for them to run at the same time, but sometimes you need to share some information between tasks.
    - Actors let you safely share information between concurrent code.
    - Like classes, actors are reference types
    - Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to interact with the same instance of an actor.
    - You introduce an actor with the actor keyword, followed by its definition in a pair of braces.
    - Swift guarantees that only code inside an actor can access the actor’s local state. This guarantee is known as actor isolation.

 - Sendable Types:
    - A type that can be shared from one concurrency domain to another is known as a sendable type.
    - You mark a type as being sendable by declaring conformance to the Sendable protocol. That protocol doesn’t have any code requirements, but it does have semantic requirements that Swift enforces. In general, there are three ways for a type to be sendable:
        - The type is a value type, and its mutable state is made up of other sendable data—for example, a structure with stored properties that are sendable or an enumeration with associated values that are sendable.
 
        - The type doesn’t have any mutable state, and its immutable state is made up of other sendable data—for example, a structure or class that has only read-only properties.

        - The type has code that ensures the safety of its mutable state, like a class that’s marked @MainActor or a class that serializes access to its properties on a particular thread or queue.
 
    -

 
 */

import UIKit

// MARK: - Concurrency

// MARK: Asynchronous Functions

/*

enum CustomError: Error {
    case myError
    case someThingWentWrong
}


func listPhotos(inGallery name: String) async throws -> [String] {
    
    try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    
    throw CustomError.myError
    
    return ["IMG001", "IMG99", "IMG0404"]
}

func downloadPhoto(named: String) async -> UIImage {
    return UIImage()
}

func show(_ image: UIImage) {
    let imageView = UIImageView(image: image)
    
//    print(imageView.image ?? nil)
}
do {
    let photoNames = try await listPhotos(inGallery: "Summer Vacation")
    
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    let photo = await downloadPhoto(named: name)
    show(photo)
    print("✅ Success")
} catch let error as CustomError {
    print("Custom Error: \(error)")
} catch {
    print("Unknown Error")
}

let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
add(firstPhoto toGallery: "Road Trip")
// At this point, firstPhoto is temporarily in both galleries.
remove(firstPhoto fromGallery: "Summer Vacation")

func move(_ photoName: String, from source: String, to destination: String) {
    add(photoName, to: destination)
    remove(photoName, from: source)
}
// ...
let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
move(firstPhoto, from: "Summer Vacation", to: "Road Trip")
*/

// MARK: Asynchronous Sequences

/*

let handle = FileHandle.standardInput
print("Before")

do {
    for try await line in handle.bytes.lines {
        print(line)
    }
} catch {
    print("Error: \(error.localizedDescription)")
}

print("After")

// Calling Asynchronous Functions in Parallel

func downloadPhoto(named: String) async -> UIImage {
    print("downloadPhoto, \(named)")
    return UIImage()
}

// General approach:
let photoNames = ["IMG001", "IMG99", "IMG0404"]

let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
//show(photos)

// New approach:

print("---- New Approach -------")

async let firstPhotoAsync = downloadPhoto(named: photoNames[0])
async let secondPhotoAsync = downloadPhoto(named: photoNames[1])
async let thirdPhotoAsync = downloadPhoto(named: photoNames[2])

let photosAsync = await [firstPhoto, secondPhoto, thirdPhoto]
//show(photos)

await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}
 
 */
 
// MARK: Actors

/*

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)

*/

// MARK: Sendable Types

/*

struct TemperatureReading: Sendable {
    var measurement: Int
}

extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

let logger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger.addReading(from: reading)

print("Max: \(await logger.max)")

 */


//: [Next](@next)
