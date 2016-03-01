//: [Previous](@previous)

//: ## Swift Array.filter Intro
//: .filter operates over an array to keep elements based on a condition that resolves to true.

import Foundation

let siblings = ["Bobby", "Mary", "Lisa", "Johnny"]

let girlsOnly = siblings.filter { firstName -> Bool in
    return (firstName == "Mary" || firstName == "Lisa")
}

//: Exercise: Create an array using .filter on "siblings" that returns all names longer than 4 characters. IE:
//: * Bobby
//: * Johnny

// START Exercise

// REPLACE WITH YOUR CODE

// END Exercise code

//: [Next](@next)
