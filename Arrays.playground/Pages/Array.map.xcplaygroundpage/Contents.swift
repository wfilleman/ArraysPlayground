//: [Previous](@previous)

//: ## Swift Array.map
//: * Use real weather data to convert into clean arrays for use by a caller.
//: * Returned forecasted weather data from Open Weather Map is returned in a monster JSON result forecasted for the next 5 days.
//: * Temperature data in JSON result is in Kelvin.

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import Alamofire
import SwiftyJSON
import PromiseKit

//: Promised function to return just the Forecasted data over the next 5 days every three hours.
func returnWeatherForecast() -> Promise<JSON> {

    return Promise { fulfill, rejected in
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&APPID=\(openWeatherAPIKey)").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    fulfill(json)
                }
            case .Failure(let error):
                print(error)
                rejected(error)
            }
        }
    }
}

//: ## Entry Point
returnWeatherForecast()
    .then { weatherJSON -> Void in
        
        // Example:
        // * The .map operator on a Swift Array will iterate over each element of the ["list"] element to convert into another element.
        // * The "listObj" parameter is one element from the ["list"] JSON array in JSON.
        // * "listObj -> NSNumber" means take this element input in JSON and give back just a NSNumber
        // * maxTempForecast results in a type of [NSNumber]
        let maxTempForecast = weatherJSON["list"].arrayValue.map { listObj -> NSNumber in
            
            // Pull out the Max Temp for the day. Results are in Kelvin
            let maxTempK = listObj["main"]["temp_max"].numberValue
            
            // Return the Max Temp in Fahrenheit represented as a NSNumber
            return KtoF(maxTempK)
        }
        
        // START Exercise: Return the Forecasted Humidity instead.
        // Step 1: Find the Humidity JSON tag from the returned JSON.
        // Step 2: Setup the let variable to map to an array of NSNumbers.
        // Step 3: Pull out the humidity tag and convert to NSNumber to return to the map call.
        // Step 4: fulfill the Humidity array instead of maxTempForecast
        // Step 5: Change the map to return a string so that your values read: "50%"
        
        let maxHumidityForecast = weatherJSON["list"].arrayValue.map { listObj -> NSNumber in
            return listObj["main"]["humidity"].numberValue
        }
        print(maxHumidityForecast)
        let maxHumidityForecastString = weatherJSON["list"].arrayValue.map { listObj -> String in
            return "\(listObj["main"]["humidity"].numberValue)%"
        }
        print(maxHumidityForecastString)
        
        // END Excercise Code
        
        print(maxTempForecast) // Look at the Log for results
    }
    .error { error in
        print(error)
    }

//: [Next](@next)
