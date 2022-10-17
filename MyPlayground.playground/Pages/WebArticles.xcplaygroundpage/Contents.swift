//: [Previous](@previous)

import Foundation


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



//: [Next](@next)
