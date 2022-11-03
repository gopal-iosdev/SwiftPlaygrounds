//: [Previous](@previous)

/*
 Source: https://docs.swift.org/swift-book/LanguageGuide/Properties.html
 
 NOTE:
    - If you create an instance of a structure and assign that instance to a constant, you can’t modify the instance’s properties, even if they were declared as variable properties
    - You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.
    - If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
    - You must declare computed properties—including read-only computed properties—as variable properties with the var keyword, because their value isn’t fixed. The let keyword is only used for constant properties, to indicate that their values can’t be changed once they’re set as part of instance initialization.
    - The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They aren’t called while a class is setting its own properties, before the superclass initializer has been called.
    - If you pass a property that has observers to a function as an in-out parameter, the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function.
    - Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables don’t need to be marked with the lazy modifier. Local constants and variables are never computed lazily.
    - Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself doesn’t have an initializer that can assign a value to a stored type property at initialization time.
    - Stored type properties are lazily initialized on their first access. They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they don’t need to be marked with the lazy modifier.
    - You can also define read-write computed type properties with the same syntax as for computed instance properties.
 
 - Properties:
    - Properties associate values with a particular class, structure, or enumeration.
    - Computed properties are provided by classes, structures, and enumerations.
    - Stored properties are provided only by classes and structures.
    - If you create an instance of a structure and assign that instance to a constant, you can’t modify the instance’s properties, even if they were declared as variable properties.
    - If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
 
 - Lazy Stored Properties:
    - A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used. You indicate a lazy stored property by writing the lazy modifier before its declaration.
    
 - Computed Properties:
    - Read-Only Computed Properties:
        - A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but can’t be set to a different value.
 
 - Property Observers:
    - Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
    - You can add property observers in the following places:
        - Stored properties that you define.
        - Stored properties that you inherit.
        - Computed properties that you inherit.
    - willSet is called just before the value is stored.
    - didSet is called immediately after the new value is stored.
 
 - Property Wrappers:
    - A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
    - To define a property wrapper, you make a structure, enumeration, or class that defines a wrappedValue property.
    - You apply a wrapper to a property by writing the wrapper’s name before the property as an attribute.
    - Projecting a Value From a Property Wrapper:
        - In addition to the wrapped value, a property wrapper can expose additional functionality by defining a projected value
        - A property wrapper can return a value of any type as its projected value.
 
 - Global and Local Variables:
    - Global variables are variables that are defined outside of any function, method, closure, or type context.
    - Local variables are variables that are defined within a function, method, or closure context.
 
 - Type Properties:
    - Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance.
    - You can also define properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called type properties.
    - You define type properties with the static keyword. For computed type properties for class types, you can use the class keyword instead to allow subclasses to override the superclass’s implementation.
 
 */

/*
 
 import Foundation

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3

print(rangeOfFourItems)

// MARK: Lazy Stored Properties

class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

print(manager)

print(manager.importer.filename)

print(manager)

// MARK: Computed Properties


struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// Read-Only Computed Properties

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        get { width * height * depth }
        set {
            width = newValue / 3.0
            height = newValue / 3.0
            depth = newValue / 3.0
        }
        
//        width * height * depth
    }
}
var fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

print(fourByFiveByTwo)

//fourByFiveByTwo.volume = 60
//
//print(fourByFiveByTwo)

// MARK: Property Observers

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360

stepCounter.totalSteps = 896

// MARK: Property Wrappers

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}


struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)


rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)


struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)

struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)

// Projecting a Value From a Property Wrapper

@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)

enum Size {
    case small, large
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int

    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}

var sizedRect = SizedRectangle()
sizedRect.resize(to: .small)
print(sizedRect.height, sizedRect.width)
print(sizedRect.$height, sizedRect.$width)


sizedRect.resize(to: .large)
print(sizedRect.height, sizedRect.width)
print(sizedRect.$height, sizedRect.$width)

func someFunction() {
    @SmallNumber var myNumber: Int

    myNumber = 10
    // now myNumber is 10

    myNumber = 24
    // now myNumber is 12
}

// MARK: Type Properties

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)

SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)

print(SomeClass.computedTypeProperty)

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 19

print(rightChannel.currentLevel)

print(AudioChannel.maxInputLevelForAllChannels)

 */

//: [Next](@next)
