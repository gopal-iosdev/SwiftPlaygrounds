//: [Previous](@previous)

/*

 - @autoclosure:
    - Src: https://www.youtube.com/watch?v=5YGJDsbEVjM&list=PLdXMqVQnoFleH3GSuTUpr3Fjzp1JMy-je&index=31&ab_channel=VincentPradeilles
    - It's going to take arg passed in as a string and it will automatically wrap it in a function that returns a string.
    - We call the func only when need to, so there is no performance penality.
 
 */

import Foundation

// MARK: @autoclosure
/*

func log(_ message: () -> String) {
    print("log func")
    #if DEBUG
        print("inside debug")
        print(message())
    #endif
}

func logWithAutoClosure(_ message: @autoclosure () -> String) {
    print("logWithAutoClosure func")
    #if DEBUG
        print("inside debug")
        print(message())
    #endif
}

let urlResponse = URLResponse()
log {
    urlResponse.debugDescription
}

// autoclosure

logWithAutoClosure(urlResponse.debugDescription)

*/

//: [Next](@next)
