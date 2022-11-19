//: [Previous](@previous)

/*
- callAsFunction:
   - Src: https://www.youtube.com/watch?v=td_7eLXo0w0&list=PLdXMqVQnoFleH3GSuTUpr3Fjzp1JMy-je&index=16&ab_channel=VincentPradeilles
   - Call the object like it was a function.

*/


import UIKit

// MARK: callAsFunction

/*

struct CellConfiguration<Model, Cell: UITableViewCell> {
    let model: Model
    let configurator: (Cell) -> Void
    
    func configure(_ cell: Cell) {
        print("Configure Cell")
        configurator(cell)
    }
}

struct Person {
    let name: String
}

let cell = UITableViewCell()
let model = Person(name: "Gopal")

let cellConfigurator = CellConfiguration(model: model) { cell in
    cell.textLabel?.text = model.name
}

cellConfigurator.configure(cell)


// with callAsFunction

struct CellConfigurator2<Model, Cell: UITableViewCell> {
    let model: Model
    let configurator: (Cell) -> Void
    
    func callAsFunction(_ cell: Cell) {
        print("callAsFunction")
        configurator(cell)
    }
}

let cell2 = UITableViewCell()
let model2 = Person(name: "Test")
let configurator2 = CellConfigurator2(model: model2) { cell in
    cell.textLabel?.text = model2.name
}
configurator2(cell)

 */

//: [Next](@next)
