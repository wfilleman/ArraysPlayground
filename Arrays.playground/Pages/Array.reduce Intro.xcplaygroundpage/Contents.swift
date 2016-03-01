//: [Previous](@previous)

//: ## Swift Array.reduce Intro
//: .reduce operates over an array to apply a formula to each element. The input is the results of the last operator. 
//: IE add up all ints in an array.

import Foundation

let siblings = ["Bobby", "Mary", "Lisa", "Johnny"]

//: Count the total number of characters across all names
let totalCharacters = siblings.reduce(0, combine: { (sum, nextElement) -> Int in
    return sum + nextElement.characters.count
})
//: The 0 is the value of the initial element that is passed into the combine: (sum) to get the .reduce started.
//: Change 0 to another Int to see how it impacts the result.

//: Exercise: Create an array using .reduce on "siblings" that returns the length of the smallest name. IE:
//: * 4

// START Exercise

// REPLACE WITH YOUR CODE

// END Exercise code

//: [Next](@next)
