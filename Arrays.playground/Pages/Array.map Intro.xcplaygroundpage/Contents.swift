//: [Previous](@previous)

//: ## Swift Array.map Intro
//: .map converts an array of elements to another array of the same size of any type.

import Foundation

let siblings = ["Bobby", "Mary", "Lisa", "Johnny"]

//: Take a list of names and convert to another array of character count per name.
let charsInName = siblings.map { firstName -> Int in
    return firstName.characters.count
}

//: Exercise: Create an array using .map on "siblings" that returns their full name as each element of the array. IE: 
//: * Bobby Jones
//: * Mary Jones
//: * Lisa Jones
//: * Johnny Jones

let fullNames = siblings.map { firstName -> String in
    return firstName + " Jones"
}
fullNames

//: [Next](@next)
